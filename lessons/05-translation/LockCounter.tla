---------------------------- MODULE LockCounter ----------------------------
(***************************************************************************)
(* Lesson 5: PlusCal is just TLA+.                                         *)
(*                                                                         *)
(* This is lesson 4's locked counter written BY HAND in plain TLA+, the    *)
(* way the PlusCal translator writes it. Compare with the generated part   *)
(* of lessons/04-pluscal/Counter.tla.                                      *)
(*                                                                         *)
(* The translation recipe:                                                 *)
(*   - every label becomes an action  Label(self)                          *)
(*   - pc[self] records which label process `self` runs next; an action    *)
(*     is enabled only when pc[self] is its label, and sets pc' to the     *)
(*     next label                                                          *)
(*   - process-local variables become functions over the process ids      *)
(***************************************************************************)
EXTENDS Naturals

CONSTANT N
Procs == 1..N

VARIABLES count, lock, tmp, pc
vars == <<count, lock, tmp, pc>>

AllDone == \A p \in Procs : pc[p] = "Done"   \* defined before use: TLA+ requires it

Init == /\ count = 0
        /\ lock = FALSE
        /\ tmp = [p \in Procs |-> 0]
        /\ pc = [p \in Procs |-> "Acquire"]

Acquire(self) == /\ pc[self] = "Acquire"
                 /\ lock = FALSE                         \* the `await`
                 /\ lock' = TRUE
                 /\ pc' = [pc EXCEPT ![self] = "Read"]
                 /\ UNCHANGED <<count, tmp>>

\* TODO (exercise 1): Read(self), Write(self), Release(self)

\* TODO (exercise 2): Terminating, and a Next that lets some process take a step
Next == \E self \in Procs : Acquire(self)

Spec == Init /\ [][Next]_vars

Correct == AllDone => count = N
=============================================================================
