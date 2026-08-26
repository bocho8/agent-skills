# agent-skills

Personal fleet. Cursor reads `~/.agents/skills`, which is a symlink to `skills/` in this repo.

Do **not** `npx skills add -g`. That is how 54 unused skills landed on this machine. Edit this repo instead.

`codebase-memory` is not here. It stays in `~/.cursor/skills` (Cursor + MCP).

## Why each skill is here

Audited against chat history (Specter / TEE / fermentito). Cherry-picked from [mattpocock/skills](https://github.com/mattpocock/skills) and [pstack](https://github.com/cursor/plugins/tree/main/pstack/skills). Upstream text is unmodified.

| Skill | Source | Why |
|---|---|---|
| `grill-me` | Matt | Default planning loop. Most-used slash skill. |
| `grilling` | Matt | Primitive `grill-me` and ICA both call. |
| `handoff` | Matt | Multi-session Specter / TEE / adb work. |
| `unslop` | pstack | Kill AI sludge. Same job as ponytail, for prose. |
| `diagnosing-bugs` | Matt | User reports and device logs. High fit, unused before. |
| `research` | Matt | Upstream parity (PIF, Tricky, OhMy, TEESimulator). |
| `blast-radius` | pstack | Small Magisk change: prove what else breaks. |
| `how` | pstack | "How does this work?" walkthroughs. |
| `why` | pstack | "Why is it this way?" from git/issues/docs. |
| `bro` | pstack | Restate the last message in plain language. |
| `improve-codebase-architecture` | Matt | Deepening scan. Used twice, kept on purpose. |
| `codebase-design` | Matt | ICA's vocabulary. Not optional if ICA stays. |
| `domain-modeling` | Matt | ICA writes `CONTEXT.md` / ADRs through this. |

Not here on purpose: `/implement` (fights no-TDD), `/ask-matt`, `/code-review`, `/interrogate`, `/tdd`, Better Auth, Alvar, `find-skills`.

Project-only skills (fermentito `prototype`, `grill-with-docs`, …) live in those repos, not this fleet.

## Install on a machine

```bash
git clone git@github.com:bocho8/agent-skills.git ~/agent-skills
# wipe any npx global install first, then:
rm -rf ~/.agents/skills ~/.agents/.skill-lock.json
mkdir -p ~/.agents
ln -sfn ~/agent-skills/skills ~/.agents/skills
```

Restart Cursor.

## Update from upstream

Copy the skill folder again from the source repo when you mean to. Do not `npx skills update`.
