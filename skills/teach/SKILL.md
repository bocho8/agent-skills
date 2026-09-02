---
name: teach
description: >-
  Teach a topic so it locks in as understanding, not memorized facts.
  Unconditional truths first, then motivated discovery. Probe the edge,
  present a plan, teach node by node. Use when the user invokes /teach.
argument-hint: topic to learn
disable-model-invocation: true
---

# Teach

Slash only. Do not turn an ordinary explanation into a lesson.

Pedagogy adapted from [amosblomqvist/learn](https://github.com/amosblomqvist/learn). Rewritten. Do not paste that SKILL.md.

Two principles, every time. Read [references/philosophy.md](references/philosophy.md) before you plan. Reciting a fact is a failed lesson. The fact should follow from foundations they already accept.

**mermaid-cli is required** for the plan DAG and any mermaid picture. Chrome or Chromium too. See the visualize skill. If mermaid-cli cannot render, the DAG is a nested list, no mermaid fence, and you tell them to install it. Do not embed mermaid you have not looked at as a PNG.

## Tools

| Job | Tool |
|---|---|
| Gradable check | `AskQuestion`. Then in chat: right or wrong, the correct claim, the explanation. |
| No-right-answer fork | Chat. Preferences, direction, what they want next. |
| Fact check, field map | Directory first. Web `Task` only for a hole. No local course: web `Task` maps the topic. Short brief. No research file unless they asked for one. Do not call the `research` skill. |
| Picture | Local figure if it carries the idea. Else read `../visualize/SKILL.md` and follow it. |

"Let them attempt the discovery" is about who speaks first. If the question has a right answer, it is still `AskQuestion`.

## `/teach` arguments

`$ARGUMENTS` seeds Phase 1b. `/teach` with nothing asks for the goal in chat. Neither skips the probe.

Slug the lesson from the *concrete* Phase 1b goal, kebab-case, not from the slash argument. `/teach rust` that becomes "ownership" is `lessons/rust-ownership.md`.

## Directory

The workspace is the course when it can be a syllabus. Survey it before Phase 1. `lessons/` is resume state, not material.

Survey with `ls` or `find`, then `Read` the files. Glob is not absence. It misses binaries. If `Read` returns nothing useful, that file cannot carry a node. Those files are the course. Web research is only for a hole they cannot carry.

Then `/teach` with nothing means this material. `$ARGUMENTS` is a zoom that must be in the files. If it is not, stop. They pick a real slice, or they say they want a web lesson off the syllabus.

If nothing here can be a syllabus, ignore this section. Arguments, probe, and researcher run as written everywhere else.

A node is local only if the files can carry the teach loop. A mention is not coverage. Web that node.

Local wins against the web. Mention a conflict only if it would confuse them. Two local files disagree: stop and ask.

## Lesson file

`lessons/<slug>.md` in the current workspace.

Create it when they okay the plan. Append a node when its quiz-check passes. Quiz back-and-forth stays in chat.

```markdown
# <goal>

## Approach

## Map

## Nodes
```

Map is a nested list until a mermaid look-loop has passed. Then replace the list with a mermaid fence. Each node heading is the claim, then the motivated path and the connection to what already landed. Inline mermaid or SVG from visualize, after that look-loop.

If the file already exists, read it first. Landed nodes are a floor. Probe holes and drift, not a from-scratch edge search. Confirm the goal still matches. Update in place.

## Quiz options

Build them so evenness is automatic. Do not write a good answer plus throwaways and audit later.

1. Every option is a bare claim. No justification in any option. All reasoning goes in the explanation you give *after* they answer.
2. Draft the correct claim. Mutate it into each distractor: one real misconception, same skeleton, grain, and register. The correct option is just the claim under the correct belief.
3. Each distractor is an error they might actually make, and unambiguously wrong on the intended reading.
4. No asymmetric bolding. Bold nothing, or the parallel term in every option.
5. Drafting order is not display order. Count quizzes this lesson, 1-based, probe included. With k options, put the correct claim at 0-based index `(n mod k)`. Fill the other slots from the distractors in draft order. Do not leave the correct claim first by habit.

If you can tell which is right without knowing the material, regenerate. Do not patch.

After `AskQuestion` returns, say whether they got it, name the correct claim, explain. Then the next question or the next node.

## Phase 1. Probe

Never skip. Scale the size to the topic, not the shape.

**1a. Level. `AskQuestion` only.** Locate the edge of their understanding along every strand the lesson will depend on. The edge is located when it is bracketed: something they get right (floor) and something they get wrong or do not know (ceiling).

- All-correct means the questions were too easy. Escalate until something breaks. If they never miss, you never found the edge.
- Binary-search. Nail it, jump difficulty up sharply. Miss, you have a ceiling. Narrow in.
- One miss is not a cue to start teaching. Probe around it. A confidently held wrong model has to be dislodged, not topped up.
- Map every strand the explanation will lean on. Bound this by relevance to the goal. When Directory ran, those strands come from the files.

Do not start Phase 2 until you can state, for each goal-relevant strand, what they have and where it ends.

**1b. Goal. Chat.** What they actually want taught. "I want to understand LLMs" can mean ten things. Interrogate until it is concrete. No right answer, so not `AskQuestion`.

On resume, if the file's stated goal matches, do not re-interrogate the vision from scratch. Confirm it is the same goal.

## Phase 2. Plan

Read [references/philosophy.md](references/philosophy.md). Do not plan from memory of it.

If Directory ran, plan from those files. Spawn a web `Task` only for a node they cannot carry. Put the path list, the gap, and what local already covers in the prompt. Never tell it the folder is only an outline.

If Directory did not run, spawn a researcher `Task` to map the topic: core concepts, real first principles, standard framings, common gotchas. Cheap, and it stops you planning around a half-remembered version.

Then, against the philosophy:

- What are the unconditional truths this rests on? Is there a clean atomic unit?
- Which of those do they already hold from Phase 1a? Build from there.
- What is the motivated discovery path from those truths to their goal?
- Socratic or expository for each stretch?

Stress-test every root. Is this genuinely an unconditional truth *for them*, or a disguised theorem that itself derives from something simpler they would accept at face value? If it derives, push it down. Do not rest the lesson on a mid-level fact.

Present the plan in chat, always, before any teaching.

1. The approach, in prose. What we will cover, in what order, and why, given their edge and their goal.
2. The dependency map. Unconditional truths at the roots, derived nodes hanging off them, their goal as the sink. Mermaid after a look-loop. Nested list if mermaid-cli failed.
3. Provenance. Each node tagged with the path it rests on, or marked as a web gap. Skip this line when there is no syllabus.

Stop. Wait for go-ahead. Do not begin Phase 3 until they okay the plan. Then create `lessons/<slug>.md` with the approach and the map.

## Phase 3. Teach

One node at a time. Every node, foundation or derived, gets the same loop:

1. **Motivate.** Why this node, now.
2. **Establish.** Unconditional truth: state it plainly, no caveats. Atomic unit if one fits. Derived step: build it from what is already established, Socratic or expository. Gradable Socratic steps are `AskQuestion`.
3. **Connect.** Make the dependency edge explicit.
4. **Quiz-check.** `AskQuestion`. If they miss, that node is not solid. Stop and fix it before building on it.

If you catch yourself asserting a fact they would have to take on faith, stop. Motivate and confirm it, or ground it in something already established.

When a picture would show structure or geometry that prose cannot, use a local figure if it carries the idea. Else follow `../visualize/SKILL.md`. One idea. If visualize cannot look at a render, skip the picture.

When unsure of a claim, check the directory first. Spawn a researcher `Task` before you say it only if the files cannot carry that node. If the check corrects you, say so.

## Researcher `Task`

Isolated. All context in the prompt. Web search and fetch. Primary sources over blogs. When Directory ran, this is a hole fill, not a field map. Include the missing claim and what local already established. Do not re-map the local syllabus.

Return a short stand-alone brief:

- Direct answer, a few sentences
- Numbered findings with source URLs or local paths
- Gaps

Do not write a file. You teach from the brief.

## Math

If the lesson needs notation, write LaTeX. Never `f(x) = x^2` as plain text.

Cursor chat does not typeset `$...$`. Those dollars stay on the page. In the teaching reply: `\(f(x)\)` inline, `\[...\]` or `$$` for display. Never `$f(x)$`.

In `lessons/<slug>.md`: `$f(x)$` inline, `$$` for display. That file is markdown. Do not copy the chat delimiters into it.

`AskQuestion` option labels are plain text. Write `15 + 10 - 5 = 20` there, no delimiters.

## Pictures

Read `../visualize/SKILL.md`. mermaid-cli is required there too. `/visualize` is chat-only unless they name this lesson file.
