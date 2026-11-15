# Lesson 5 — Exercises

Goal: see that PlusCal is only a shorthand. You'll write lesson 4's locked
counter in plain TLA+ and check that TLC sees exactly the same system.

Keep the generated code in `lessons/04-pluscal/Counter.tla` open for reference,
but try writing each action before peeking.

As given, TLC reports a deadlock after one step: `Next` only contains `Acquire`.

1. **The remaining steps.** Write `Read(self)`, `Write(self)` and `Release(self)`,
   modelled on `Acquire(self)`. Each must set `pc'` to the next label and say
   what happens to every other variable.
2. **Next.** Make `Next` allow any process to take any of its steps, plus a
   `Terminating` action that stutters once everyone is `"Done"`.
   - Without `Terminating`, what does TLC report? Why?
   - With it, you should get **17 distinct states** for `N = 2` and **61** for
     `N = 3`, exactly like lesson 4.
3. **Mutual exclusion, directly.** Add an invariant saying no two different
   processes are in `"Read"` or `"Write"` at the same time, and check it.
   Then delete the `lock = FALSE` line from `Acquire` and watch it fail.
