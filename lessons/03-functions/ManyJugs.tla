----------------------------- MODULE ManyJugs -----------------------------
(***************************************************************************)
(* Lesson 3: the jug puzzle for ANY jugs.                                  *)
(*                                                                         *)
(* New ideas:                                                              *)
(*   - CONSTANT: a value the spec doesn't fix; the .cfg file chooses it    *)
(*   - FUNCTIONS: f[x] looks up x. One variable `contents` now holds the   *)
(*     amount in every jug: contents["small"], contents["big"], ...        *)
(*   - RECORDS are functions whose domain is a set of strings:             *)
(*     [small |-> 4, big |-> 7]  is the function  "small" -> 4, "big" -> 7 *)
(*   - EXCEPT: a copy of a function with some entries changed              *)
(*   - \E x \in S: P   "P holds for SOME x in S"   (there exists)          *)
(*     \A x \in S: P   "P holds for EVERY x in S"  (for all)               *)
(***************************************************************************)
EXTENDS Naturals

CONSTANT Goal                       \* set in ManyJugs.cfg

Capacity == [small |-> 4, big |-> 7]   \* a record: jug name -> size
Jugs == DOMAIN Capacity                \* the set {"small", "big"}

VARIABLE contents                   \* a function: jug name -> litres in it

Min(a, b) == IF a < b THEN a ELSE b

Init == contents = [j \in Jugs |-> 0]     \* the function mapping every jug to 0

\* An action with a parameter: Fill("big") fills the big jug.
Fill(j) == contents' = [contents EXCEPT ![j] = Capacity[j]]

\* Pour from jug `a` into jug `b`. In EXCEPT, @ means "the old value".
Pour(a, b) ==
    /\ a /= b
    /\ LET amount == Min(contents[a], Capacity[b] - contents[b])
       IN  contents' = [contents EXCEPT ![a] = @ - amount, ![b] = @ + amount]

\* TODO (exercise 1): Empty(j)

Empty(j) == contents' = [contents EXCEPT ![j] = 0]

\* TODO (exercise 2): a Next that allows Fill, Empty or Pour on any jug(s)
Next == Fill("small")

Spec == Init /\ [][Next]_contents

TypeOK == \A j \in Jugs : contents[j] \in 0..Capacity[j]
=============================================================================
