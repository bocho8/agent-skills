---
name: implement
description: "Implement one ticket, or the slice the user names. Stops when the diff is ready."
disable-model-invocation: true
---

Implement the one ticket or slice the user names.

A whole spec with a set of tickets is `/implement-spec`. Tell the user to run that. Do not build the set here.

Call the Skill tool with `tdd` at the seams the ticket already names.

Run typechecking as you go, the test file for this slice as you go, and the full test suite once at the end.

Call the Skill tool with `code-review` on the diff. Fix the issues it raises.

Leave the commit to the user. The work is done when the suite has been run, the review findings are fixed, and the diff is uncommitted.
