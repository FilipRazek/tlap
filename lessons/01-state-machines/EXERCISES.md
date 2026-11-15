# Lesson 1 — Exercises

Run the model checker: `bin/tlc lessons/01-state-machines/HourClock.tla`

1. **Break it on purpose.** Change `Next` so the clock goes 12 → 13 (delete the IF).
   Run TLC. Read the error trace it prints: a behavior that ends in a bad state.
   Then fix it.
2. **Strengthen the invariant.** Add `NotThirteen == hr /= 13` and list it under
   `INVARIANT` in the .cfg. Why is it redundant with `TypeOK`?
3. **Your own spec.** In a new file `Traffic.tla`, describe a traffic light with
   one variable `color \in {"red", "green", "yellow"}` that cycles
   red → green → yellow → red. Add a `TypeOK` invariant and a `.cfg`, and run TLC.
4. **Nondeterminism.** Change `Next` in Traffic so that from green the light may
   go to *either* yellow or red. (Hint: `\/` means "or", and each branch is a
   possible step.) How many distinct states does TLC report now? Did it change? Why?

Questions to answer in your own words (write them in `NOTES.md`):
- What's the difference between `hr` and `hr'`?
- Why does `Init` give a *set* of starting states rather than one?
- What does `[][Next]_hr` allow besides `Next` steps, and why might that matter?
