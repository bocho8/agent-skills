#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$Mcp,
    [switch]$Cursor
)

$ErrorActionPreference = 'Stop'
$RepoRoot = $PSScriptRoot
$SkillsSrc = Join-Path $RepoRoot 'skills'
$RulesSrc = Join-Path $RepoRoot 'rules'

if (-not (Test-Path (Join-Path $SkillsSrc 'unslop\SKILL.md'))) {
    throw "Run this from the extracted repo. Expected $SkillsSrc\unslop\SKILL.md"
}

function Ensure-Dir([string]$Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Test-ReparsePoint([string]$Path) {
    if (-not (Test-Path $Path)) { return $false }
    $item = Get-Item $Path -Force
    return [bool]($item.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

function Link-SkillDir([string]$Link, [string]$Target) {
    if (Test-Path $Link) {
        if (Test-ReparsePoint $Link) {
            cmd /c rmdir "$Link" | Out-Null
        } else {
            Write-Host "skip $Link (exists, not a junction)"
            return
        }
    }
    New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
    Write-Host "link $Link"
}

$ClaudeSkills = Join-Path $env:USERPROFILE '.claude\skills'
$ClaudeRules = Join-Path $env:USERPROFILE '.claude\rules'
Ensure-Dir $ClaudeSkills
Ensure-Dir $ClaudeRules

Get-ChildItem $SkillsSrc -Directory | ForEach-Object {
    Link-SkillDir (Join-Path $ClaudeSkills $_.Name) $_.FullName
}

foreach ($name in @('unslop.md', 'unslop-ui.md')) {
    $src = Join-Path $RulesSrc $name
    $dst = Join-Path $ClaudeRules $name
    Copy-Item $src $dst -Force
    Write-Host "copy $dst"
}

if ($Cursor) {
    $AgentsSkills = Join-Path $env:USERPROFILE '.agents\skills'
    $CursorRules = Join-Path $env:USERPROFILE '.cursor\rules'
    Ensure-Dir (Join-Path $env:USERPROFILE '.agents')
    Ensure-Dir $CursorRules

    if (Test-Path $AgentsSkills) {
        if (Test-ReparsePoint $AgentsSkills) {
            cmd /c rmdir "$AgentsSkills" | Out-Null
        } else {
            Write-Host "skip $AgentsSkills (exists, not a junction). Cursor skills not linked."
            $AgentsSkills = $null
        }
    }
    if ($AgentsSkills) {
        New-Item -ItemType Junction -Path $AgentsSkills -Target $SkillsSrc | Out-Null
        Write-Host "link $AgentsSkills"
    }

    foreach ($name in @('unslop.mdc', 'unslop-ui.mdc')) {
        $src = Join-Path $RulesSrc $name
        $dst = Join-Path $CursorRules $name
        Copy-Item $src $dst -Force
        Write-Host "copy $dst"
    }
}

$Arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'windows-arm64' } else { 'windows-amd64' }
$McpZip = "https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-$Arch.zip"

Write-Host ""
Write-Host "Claude Code: restart, then /skills. unslop and unslop-ui are skills and always-on rules. Slash skills need the / name on the message."
Write-Host "Codebase MCP zip: $McpZip"

if ($Mcp) {
    Write-Host "Installing codebase-memory-mcp for this machine..."
    Invoke-RestMethod https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/scripts/setup-windows.ps1 | Invoke-Expression
    Write-Host "Restart Claude Code, then /mcp. Index a repo by asking it to."
} else {
    Write-Host "MCP later: re-run with -Mcp, or download the zip above and run the install.ps1 inside it."
}
