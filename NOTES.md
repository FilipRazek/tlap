# Notes

## Lesson 1
- `[]` means all the time
- `[Next]_hr` means either next or stuttering (no state change on hr)
- Ex 2: `NotThirteen` is redundant because `hr \in 1..12` implies `hr /= 13`
  (`TypeOK => NotThirteen`). Corollary: `TypeOK \/ NotThirteen` simplifies to just
  `NotThirteen`, which is a much weaker invariant (allows hr = 0, 50, ...).
