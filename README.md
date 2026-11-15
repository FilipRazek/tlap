# Learning TLA+

Based on Leslie Lamport's [high-level view](https://lamport.azurewebsites.net/tla/high-level-view.html):
a system is a **state machine** = an initial condition + a next-state relation
(+ fairness, later). We check **invariants** (true in every state) and, later,
**liveness** (something eventually happens) with the TLC model checker.

## Run a spec
```
bin/tlc path/to/Spec.tla        # uses Spec.cfg next to it; translates PlusCal automatically
```
Tools: `tools/tla2tools.jar` (downloaded automatically on first run; git-ignored) (TLC, SANY parser, PlusCal translator), Java 21.
Optional editor support: VS Code extension `tlaplus.vscode-ide`.

## Plan
| # | Topic | Key ideas |
|---|-------|-----------|
| 01 | State machines | variables, `Init`, `Next`, primes, `[][Next]_v`, invariants, TLC |
| 02 | A puzzle as a spec | nondeterminism, `\/`, `UNCHANGED`, using an invariant to *find* a solution |
| 03 | Functions & constants | `CONSTANT`, functions, records, `EXCEPT`, `\E`, `\A`, parameterized actions |
| 04 | Concurrency in PlusCal | processes, labels = atomic steps, interleavings, race conditions, `await`, locks |
| 05 | PlusCal is just TLA+ | hand-write the translation: `pc`, one action per label, `Terminating`, direct mutual-exclusion invariant |
| 06 | Liveness & fairness | `<>`, `~>`, weak/strong fairness, stuttering, deadlock vs. starvation |
| 07 | A distributed protocol | message sets, failures, e.g. two-phase commit |
| 08 | Refinement | one spec implements another, refinement mappings |

## Further resources
- Lamport's [video course](https://lamport.azurewebsites.net/video/videos.html)
- [Learn TLA+](https://learntla.com) (Hillel Wayne) — PlusCal-first, practical
- *Specifying Systems* (Lamport, free PDF) — the reference
- [tlaplus/Examples](https://github.com/tlaplus/Examples)
