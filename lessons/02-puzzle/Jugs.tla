------------------------------- MODULE Jugs -------------------------------
(***************************************************************************)
(* Lesson 2: a puzzle as a spec.                                           *)
(*                                                                         *)
(* You have a 4-litre jug, a 7-litre jug, and a tap. No markings.          *)
(* Get exactly 5 litres into the big jug.                                  *)
(*                                                                         *)
(* New ideas:                                                              *)
(*   - two variables: a state is now a PAIR of values                      *)
(*   - Next is a \/ of named ACTIONS, one per kind of step                 *)
(*   - UNCHANGED x  ==  x' = x   (every action must say what EVERY         *)
(*     variable is in the next state, even the ones it doesn't touch)      *)
(***************************************************************************)
EXTENDS Naturals

VARIABLES small, big              \* litres in the 4L jug and the 7L jug

Goal == 5

Min(a, b) == IF a < b THEN a ELSE b    \* you can define your own operators

Init == small = 0 /\ big = 0

FillSmall  == small' = 4 /\ UNCHANGED big
EmptySmall == small' = 0 /\ UNCHANGED big

SmallToBig ==                     \* pour until small is empty or big is full
    LET amount == Min(small, 7 - big)     \* LET gives a local name
    IN  /\ small' = small - amount
        /\ big'   = big + amount

\* TODO (exercise 1): FillBig, EmptyBig, BigToSmall

Next == \/ FillSmall
        \/ EmptySmall
        \/ SmallToBig

Spec == Init /\ [][Next]_<<small, big>>   \* two variables -> a tuple

TypeOK == small \in 0..4 /\ big \in 0..7
=============================================================================
