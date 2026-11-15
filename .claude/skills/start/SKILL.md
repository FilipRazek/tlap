---
name: start
description: Start (run TLC on) the user's current TLA+ exercise and explain the result. Use when the user says "start", "run", "check it", "run the exercise", or asks how their current spec is doing.
---

# Run the current exercise

1. Run `bin/start` (or `bin/start <file>` if the user named one). It picks the
   newest spec in the latest lesson and prints, compactly: the file, its uncommitted
   diff, then `PASS` or the errors, a one-line-per-state trace, and state counts.
   Don't run anything else to gather context unless that output is insufficient.

2. Explain briefly, following `CLAUDE.md`:
   - Error → the exact line and what's wrong; hint, don't rewrite the user's spec.
   - Violation → read the trace as states + actions; say if it's the intended result.
   - Pass → sanity-check the distinct-state count against `EXERCISES.md`.
   - Say which exercise this completes and what's next.

3. Only when an exercise or experiment is complete: remove its TODO comments, commit
   (one concern per commit), run `bin/maybe-push`. If the lesson is complete, set up
   the next one as `CLAUDE.md` describes.
