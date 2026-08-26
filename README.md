# agent-skills

Global Cursor skills. `~/.agents/skills` is a symlink to `skills/` here.

Edit this repo to change skills. Do not `npx skills add -g` or `npx skills update`.

`codebase-memory` lives in `~/.cursor/skills`. Project skills live in the project.

Copied from [mattpocock/skills](https://github.com/mattpocock/skills) and [pstack](https://github.com/cursor/plugins/tree/main/pstack/skills). `unslop-ui` tells adapted from [Nutlope/hallmark](https://github.com/Nutlope/hallmark). Not tracked as submodules.

## Skills

| Skill | When to use |
|---|---|
| `grill-me` | Plan or decision before building. `/` |
| `grilling` | Interview primitive. Called by `grill-me` and `improve-codebase-architecture`. |
| `handoff` | Compact this session so another agent can continue. `/` |
| `unslop` | Strip AI tells from writing. Always-on via `rules/unslop.mdc`, not via the skill. |
| `unslop-ui` | Strip AI tells from UI. Always-on bans via `rules/unslop-ui.mdc`; full tells when building UI. |
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

Skills are opt-in. Cursor injects them only when the agent reads `SKILL.md`. A `description` of "Must always apply" does nothing by itself. Always-on behavior is a Cursor rule with `alwaysApply: true`.

## New machine

```bash
git clone git@github.com:bocho8/agent-skills.git ~/agent-skills
rm -rf ~/.agents/skills
mkdir -p ~/.agents ~/.cursor/rules
ln -sfn ~/agent-skills/skills ~/.agents/skills
ln -sfn ~/agent-skills/rules/unslop.mdc ~/.cursor/rules/unslop.mdc
ln -sfn ~/agent-skills/rules/unslop-ui.mdc ~/.cursor/rules/unslop-ui.mdc
```

Do not run `npx skills remove --all`. It deletes `~/.cursor/skills` too. Restart Cursor.

## Upstream

Replace the skill folder from the source repo when you want their latest. Leave the rest of this repo alone.
