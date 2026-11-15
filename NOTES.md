# Notes

## Lesson 1
- Ex 2: `NotThirteen` is redundant because `hr \in 1..12` implies `hr /= 13`
  (`TypeOK => NotThirteen`). Corollary: `TypeOK \/ NotThirteen` simplifies to just
  `NotThirteen`, which is a much weaker invariant (allows hr = 0, 50, ...).
