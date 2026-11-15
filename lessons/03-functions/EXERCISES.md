# Lesson 3 — Exercises

Run: `bin/tlc lessons/03-functions/ManyJugs.tla`

The spec runs as given, but `Next` only ever fills the small jug.

1. **Empty(j).** Write it, modelled on `Fill(j)`.
2. **Next with \E.** Replace `Next` so that a step is a Fill or Empty of *some*
   jug, or a Pour between *some* two jugs. Use `\E j \in Jugs : ...`.
   You should get the same 22 distinct states as lesson 2.
3. **NotSolved with \A.** Write an invariant saying *no* jug holds `Goal`,
   add it to the `.cfg`, and check you get the 8-step solution again.
4. **Change the puzzle without touching the logic.**
   - Change `Goal` in the `.cfg` only (try 6, then 3).
   - Add a third jug to `Capacity`, e.g. `tiny |-> 2`. Nothing else should
     need to change. What happens to the state count and the solution?
