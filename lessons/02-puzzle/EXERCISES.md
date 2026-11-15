# Lesson 2 — Exercises

Run: `bin/tlc lessons/02-puzzle/Jugs.tla`

1. **Finish the spec.** Write `FillBig`, `EmptyBig`, and `BigToSmall`, and add
   them to `Next`. Run TLC: it should pass `TypeOK`.
2. **Make TLC solve the puzzle.** Add an invariant that claims the puzzle
   *can't* be solved: `NotSolved == big /= Goal`. List it in the `.cfg`.
   TLC will "fail" — and its error trace is a solution. How many steps?
3. **Forget an UNCHANGED.** Delete `UNCHANGED big` from `FillSmall` and run
   TLC. Read the error. Then put it back.
4. **Change the goal.** Try `Goal == 6`, then `Goal == 8`. What does TLC
   say for 8, and what does that tell you?
