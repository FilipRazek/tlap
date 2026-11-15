# Lesson 4 — Exercises

Run: `/start` (or `bin/start lessons/04-pluscal/Counter.tla`).

`bin/tlc` translates the PlusCal algorithm into TLA+ and writes the result
between `BEGIN TRANSLATION` and `END TRANSLATION`. Don't edit that part by hand:
edit the algorithm, and it is regenerated on every run.

1. **Find the race.** Run it. `Correct` is violated: two workers each added 1,
   yet `count` ends at 1. Read the trace: which steps interleaved, in what order?
2. **Make the increment atomic.** Merge the two steps into one label
   (`Incr: count := count + 1;`). Run again: it should pass.
3. **Use a lock instead.** Go back to separate `Read` and `Write` steps, and
   protect them with a shared `lock = FALSE`:
   - a new first label that waits for the lock and takes it:
     `await ~lock; lock := TRUE;` (`await P` blocks the process until P is true)
   - a new last label that releases it.
   It should pass, even though Read and Write are separate steps again.
4. **More workers.** Set `N = 3` in the `.cfg`. How does the state count grow?
