# Notes

## Lesson 1: State machines

### Temporal formulas
- `[]` means "always": true at every point of the behavior.
- `[Next]_hr` means either a `Next` step or a stuttering step (`hr` doesn't change).

### Invariants (Ex 2)
- `NotThirteen` is redundant: `hr \in 1..12` implies `hr /= 13`, i.e. `TypeOK => NotThirteen`.
- Corollary: `TypeOK \/ NotThirteen` simplifies to just `NotThirteen`, a much weaker
  invariant (it allows hr = 0, 50, ...).
