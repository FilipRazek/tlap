---------------------------- MODULE HourClock ----------------------------
(***************************************************************************)
(* Lesson 1: a system is a state machine.                                  *)
(*   - a STATE is an assignment of values to variables                     *)
(*   - a BEHAVIOR is a sequence of states                                  *)
(*   - Init says which states a behavior may start in                      *)
(*   - Next relates a state (hr) to the next state (hr')                   *)
(***************************************************************************)
EXTENDS Naturals

VARIABLE hr                       \* the hour shown on a 12-hour clock

Init == hr \in 1..12              \* start at ANY hour: a set of initial states

Next == hr' = IF hr = 12 THEN 1 ELSE hr + 1   \* hr' = value in the next state

Spec == Init /\ [][Next]_hr       \* "Init, and every step is a Next step
                                  \*  (or leaves hr unchanged)"

TypeOK == hr \in 1..12            \* an INVARIANT: true in every reachable state
=============================================================================
