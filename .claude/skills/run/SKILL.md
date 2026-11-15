---
name: run
description: Run TLC on the user's current TLA+ exercise and explain the result. Use when the user says "run", "check it", "run the exercise", or asks how their current spec is doing.
---

# Run the current exercise

1. **Find the current spec.** Unless the user named a file, pick the most recently
   modified `.tla` file in the highest-numbered lesson directory:
   ```bash
   d=$(ls -d lessons/*/ | sort | tail -1); ls -t "$d"*.tla | grep -v _TTrace_ | head -1
   ```
   Say which file you're running in one short line.

2. **Run TLC** from the repo root: `bin/tlc <file>`.
   Show only what matters (errors, trace, state counts); don't paste the banner.

3. **Explain the result** following the tutoring rules in `CLAUDE.md`:
   - Parse/semantic error → point at the exact line and what's wrong; hint, don't rewrite
     the user's spec for them unless asked.
   - Invariant violation → read the trace as a behavior (states + action labels).
     If the violation is the intended outcome of the exercise (e.g. a `NotSolved`
     invariant), say so.
   - Pass → sanity-check the distinct-state count against what the exercise expects
     (`EXERCISES.md`); a suspiciously low count usually means an action is missing
     from `Next`.
   - Say which exercise in `EXERCISES.md` this completes, and what's next.

4. **Commit** per `CLAUDE.md`: if the working tree has the user's changes, commit them
   (one concern per commit, e.g. `Lesson 3 ex 1: add Empty(j)`), even if TLC failed.
   If the run completes the lesson, set up the next lesson as `CLAUDE.md` describes.
