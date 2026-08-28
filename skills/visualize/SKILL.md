---
name: visualize
description: >-
  Add one correct, minimal diagram to a lesson or a chat explanation
  when an idea is genuinely clearer as a picture. Mermaid for
  relationships, SVG for geometry. Renders a PNG, looks at it, then
  embeds the source. Use when the user invokes /visualize, or when
  /teach needs a picture.
argument-hint: what to draw
disable-model-invocation: true
---

# Visualize

A picture earns its place only when it shows something words cannot: shape, structure, direction, relationship, geometry. One picture. Correct. Minimal.

You are the creative director. You decide the exact idea and cut it to the fewest carrying elements. A maker `Task` authors, renders, looks, and returns source. You never hand-author a diagram. Correctness depends on the maker's render-and-inspect loop.

Adapted from [amosblomqvist/learn](https://github.com/amosblomqvist/learn). Rewritten.

## mermaid-cli is required

Plan DAGs and mermaid pictures go through `@mermaid-js/mermaid-cli` and a Chrome or Chromium binary. Install:

```bash
npm install -g @mermaid-js/mermaid-cli
```

Chromium on Fedora: `sudo dnf install chromium`. The script also accepts `CHROME_PATH` or `PUPPETEER_EXECUTABLE_PATH`.

SVG pictures need `rsvg-convert` from `librsvg2-tools` on Fedora, or ImageMagick `magick`. Optional. Missing SVG renderer means no SVG picture. Teach continues.

If mermaid-cli cannot render, do not embed a mermaid fence. Nested list for a DAG. Tell them mermaid-cli is required. A missing visual is cheaper than a false one.

Scripts, relative to this skill directory:

- `scripts/render-mermaid.sh <input.mmd> <output.png>`
- `scripts/render-svg.sh <input.svg> <output.png>`

PNG files are checks. Write them under `$TMPDIR`. Fall back to `/tmp` if it is unset. Do not commit them. After the maker has looked, embed the **source** in the lesson or in chat.

## When to visualize

Reach for one when:

- The idea is a structure or relationship: dependencies, parts and arrows, a flow, a sequence, a state machine, a tree, a comparison, containment.
- The idea is spatial or geometric: coordinates, a number line, vectors, a function's shape, a physical layout.

Do not visualize when prose or a single equation already carries it. A decorative diagram that restates the sentence next to it adds noise and a chance to be wrong. When in doubt, don't.

## Choose the maker

- **Mermaid.** Nodes and edges, relationships. Default. Matches the dependency-graph pedagogy.
- **SVG.** Positions and shapes. Exact coordinates, geometry figures, number lines, vectors, plots. What Mermaid cannot lay out.

## Brief

The common failure is cramming. Before briefing, prune. For each element: if I delete this, is the idea still clear? If yes, delete it. If the brief lists more than about 7 elements, cut first.

Give the concept *and* the concrete elements. Not a vague topic.

Bad: "make a diagram about how TCP works"

Good: "graph TD: a node 'packet' at the top; arrows down to 'ordering' and 'retransmit on loss'; both arrows down into 'reliable stream'. No title. Show that reliability is built FROM packets, not alongside them."

## Invoke

Resolve this skill's directory. Pass the absolute path of the matching `scripts/render-*.sh` in the `Task` prompt.

Read [references/mermaid-maker.md](references/mermaid-maker.md) or [references/svg-maker.md](references/svg-maker.md). Put that file's full text in the `Task` prompt, then the brief, then the script path. `subagent_type`: `generalPurpose`.

```
Task(description="mermaid diagram", prompt=<maker file + brief + script path>)
```

The maker writes source under tmp, runs the script, `Read`s the PNG, iterates, returns:

```
RESULT:
kind: mermaid | svg
source: <fenced mermaid, or a complete <svg>…</svg>>
png: <absolute png path they looked at>
```

or `RESULT: NONE` plus a one-line reason.

If `NONE`, simplify or skip. Never fake a diagram yourself.

## Embed

Introduce the visual in one sentence, then let it carry the idea. Do not narrate every element back in prose.

**During `/teach`.** After the look-loop, put the source in the teaching reply *and* in `lessons/<slug>.md`. Mermaid as a ` ```mermaid ` fence. SVG inline.

**`/visualize` alone.** Picture in chat only. If they name an existing `lessons/*.md`, append there too.

## Why the PNG exists

Rendering success only proves the syntax parsed. The maker has to look at the pixels: wrong arrow, right-angle mark on the wrong corner, clipped label. The lesson keeps the source so the notes stay editable markdown. The PNG is how we know that source is not a lie.
