---
name: setup-skills
description: "Configure this repo for the engineering skills: GitHub issues by default, and where the glossary lives. Run once per repo."
disable-model-invocation: true
---

# Setup skills

Write the per-repo config the engineering skills read. One pass. The only question is the glossary layout, and only when the repo contains several apps.

## Steps

### 1. Stop if this repo is already set up

Look for `docs/agents/issue-tracker.md`.

Done when that file exists and you have stopped, or it is missing and you continue. If it exists, say so and do not write anything.

### 2. Pick the issue tracker

Use the tracker's template as the body of `docs/agents/issue-tracker.md`. Copy it. Do not interview.

- The user named GitLab: [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)
- The user named local markdown: [issue-tracker-local.md](./issue-tracker-local.md)
- The user described some other tracker: write `docs/agents/issue-tracker.md` from that description. Include how to create, read, list, comment, and close.
- The user said nothing: run `git remote -v`. A GitHub remote uses [issue-tracker-github.md](./issue-tracker-github.md). Anything else, stop and say this setup writes a GitHub tracker unless they name one.

Done when `docs/agents/issue-tracker.md` is written, or you stopped because the remote is not GitHub and the user named no tracker.

### 3. Pick the glossary layout

Write [domain.md](./domain.md) to `docs/agents/domain.md`.

Several apps means any of these: a `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or a `packages/` directory with packages inside.

No match: single-context. One `GLOSSARY.md` at the repo root and `docs/adr/` beside it. Do not ask.

A match: ask one question. One glossary at the root, or a map at the root plus one glossary per app. Recommend the one root glossary. Wait for the answer, then record that layout.

Done when `docs/agents/domain.md` is written and you know which layout this repo uses.

### 4. Write the steering block into `AGENTS.md`

Create `AGENTS.md` if it is missing. If it already has an `## Agent skills` section, replace that section in place.

```markdown
## Agent skills

### Issue tracker

[one line on where issues live]. See `docs/agents/issue-tracker.md`.

### Domain docs

[one line: "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

If `CLAUDE.md` exists, make it pull `AGENTS.md` in with `@AGENTS.md` and remove any `## Agent skills` section from `CLAUDE.md`. Leave the rest of `CLAUDE.md` as it is.

Done when the block is only in `AGENTS.md`, and a `CLAUDE.md` that exists points at that file.
