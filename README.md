# agent-skills

Global agent skills. Edit this repo to change them. Do not `npx skills add -g` or `npx skills update`.

`codebase-memory` is not in this repo. Install it from the MCP download below. Project skills live in the project.

Copied from [mattpocock/skills](https://github.com/mattpocock/skills) and [pstack](https://github.com/cursor/plugins/tree/main/pstack/skills). `unslop-ui` tells adapted from [Nutlope/hallmark](https://github.com/Nutlope/hallmark). Not tracked as submodules.

## Skills

| Skill | When to use |
|---|---|
| `grill-me` | Plan or decision before building. `/` |
| `grilling` | Interview primitive. Called by `grill-me` and `improve-codebase-architecture`. |
| `handoff` | Compact this session so another agent can continue. `/` |
| `unslop` | Strip AI tells from writing. Always-on rule plus `/unslop`. |
| `unslop-ui` | Strip AI tells from UI. Always-on bans plus `/unslop-ui` when building UI. |
| `diagnosing-bugs` | Hard bug or regression. Starts from a pass/fail loop. |
| `research` | Primary-source investigation, cited markdown in the repo. |
| `blast-radius` | What else a small change could break. Prove it by running code. `/` |
| `how` | How a subsystem works. Runtime, ownership, layering. |
| `why` | Why it is this shape. Git, issues, docs. |
| `bro` | Restate the last message in plain language. `/` |
| `improve-codebase-architecture` | Scan for deepening opportunities, then grill one. `/` |
| `codebase-design` | Deep-module vocabulary. Required by `improve-codebase-architecture`. |
| `domain-modeling` | Glossary and ADRs. Required by `improve-codebase-architecture`. |

Not in this fleet: `implement`, `ask-matt`, `code-review`, `interrogate`, `tdd`. After `/grill-me`, implement in the conversation. Tests stay with the user.

Skills are opt-in until the agent reads `SKILL.md`. A `description` of "Must always apply" does nothing by itself in Cursor. Always-on behavior is a rule file that forces that read: Cursor `rules/*.mdc`, Claude Code `rules/*.md`. `unslop` and `unslop-ui` are still skills. They live in `skills/` with the rest, show up in `/skills`, and `/unslop` / `/unslop-ui` attach them on a message.

## Claude Code on Windows

Most of you. Git is optional. If Claude Code runs inside WSL, skip this and use the Linux section.

1. Download [this repo as a zip](https://github.com/bocho8/agent-skills/archive/refs/heads/main.zip) and extract it.
2. In that folder, PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1 -Mcp
```

`-Mcp` also installs [codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp). Skills only: `.\install.ps1`.

3. Restart Claude Code. Check `/skills` and `/mcp`.
4. Slash skills (`/grill-me`, `/handoff`, `/blast-radius`, `/bro`, `/unslop`, `/unslop-ui`) only run when the `/` name is on the message you send. `unslop` still applies every reply through the rule.

`install.ps1` junctions every skill, including `unslop` and `unslop-ui`, into `%USERPROFILE%\.claude\skills\`. It also copies `unslop.md` / `unslop-ui.md` into `%USERPROFILE%\.claude\rules\` so the short bans are always on. Existing real folders are left alone. Re-run after a pull.

If PowerShell blocks the script, `Unblock-File .\install.ps1` first.

Also on Cursor: `.\install.ps1 -Cursor` or `.\install.ps1 -Mcp -Cursor`.

Git instead of the zip:

```powershell
git clone https://github.com/bocho8/agent-skills.git $HOME\agent-skills
cd $HOME\agent-skills
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1 -Mcp
```

## Codebase MCP download

Native binary. No Node, Docker, or API key. After install, restart the agent and say "Index this project". Defender may flag the exe. Check `checksums.txt` on the [release](https://github.com/DeusData/codebase-memory-mcp/releases/latest) if you care.

| Machine | File |
|---|---|
| Windows x64 | [codebase-memory-mcp-windows-amd64.zip](https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-windows-amd64.zip) |
| Windows ARM64 | [codebase-memory-mcp-windows-arm64.zip](https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-windows-arm64.zip) |
| Linux x64 | [codebase-memory-mcp-linux-amd64.tar.gz](https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-linux-amd64.tar.gz) |
| macOS Apple Silicon | [codebase-memory-mcp-darwin-arm64.tar.gz](https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-darwin-arm64.tar.gz) |
| macOS Intel | [codebase-memory-mcp-darwin-amd64.tar.gz](https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-darwin-amd64.tar.gz) |

All files: [latest release](https://github.com/DeusData/codebase-memory-mcp/releases/latest).

Windows, inspect then install:

```powershell
Invoke-WebRequest -Uri https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-windows-amd64.zip -OutFile codebase-memory-mcp.zip
Expand-Archive codebase-memory-mcp.zip -DestinationPath .\codebase-memory-mcp
cd .\codebase-memory-mcp
Unblock-File .\install.ps1
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
```

Or the official one-liner, no zip on disk:

```powershell
irm https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/scripts/setup-windows.ps1 | iex
```

Already in Claude Code: ask it to `Install this MCP server: https://github.com/DeusData/codebase-memory-mcp`.

Linux / macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
```

The installer writes Claude Code's MCP entry in `~/.claude.json` and drops the `codebase-memory` skill. Then `/mcp`.

## Cursor on Linux / macOS

```bash
git clone git@github.com:bocho8/agent-skills.git ~/agent-skills
rm -rf ~/.agents/skills
mkdir -p ~/.agents ~/.cursor/rules
ln -sfn ~/agent-skills/skills ~/.agents/skills
ln -sfn ~/agent-skills/rules/unslop.mdc ~/.cursor/rules/unslop.mdc
ln -sfn ~/agent-skills/rules/unslop-ui.mdc ~/.cursor/rules/unslop-ui.mdc
```

Claude Code on Linux / macOS:

```bash
git clone https://github.com/bocho8/agent-skills.git ~/agent-skills
mkdir -p ~/.claude/skills ~/.claude/rules
for d in ~/agent-skills/skills/*/; do
  ln -sfn "$d" ~/.claude/skills/"$(basename "$d")"
done
ln -sfn ~/agent-skills/rules/unslop.md ~/.claude/rules/unslop.md
ln -sfn ~/agent-skills/rules/unslop-ui.md ~/.claude/rules/unslop-ui.md
```

Do not run `npx skills remove --all`. It deletes `~/.cursor/skills` too. Restart the agent.

## Upstream

Replace the skill folder from the source repo when you want their latest. Leave the rest of this repo alone.
