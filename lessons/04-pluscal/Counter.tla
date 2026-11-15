------------------------------ MODULE Counter ------------------------------
(***************************************************************************)
(* Lesson 4: concurrency in PlusCal.                                       *)
(*                                                                         *)
(* PlusCal is a pseudocode-like language that bin/tlc translates into      *)
(* TLA+ (Init, Next, ...) before checking. It's written inside a comment.  *)
(*                                                                         *)
(* New ideas:                                                              *)
(*   - process P \in S : one copy of the process for each element of S     *)
(*   - LABELS (Read:, Write:) mark ATOMIC STEPS. Everything between two    *)
(*     labels happens in one step; other processes can run between steps. *)
(*   - TLC explores EVERY interleaving of the processes' steps.            *)
(*   - pc[p] is the label process p will execute next ("Done" at the end). *)
(***************************************************************************)
EXTENDS Naturals

CONSTANT N                          \* number of worker processes

(* --algorithm Counter
variables count = 0;                \* shared by all workers

process Worker \in 1..N
variables tmp = 0;                  \* local: each worker has its own
begin
  Read:  tmp := count;              \* step 1: read the shared counter
  Write: count := tmp + 1;          \* step 2: write back the incremented value
end process;
end algorithm; *)

\* BEGIN TRANSLATION
VARIABLES pc, count, tmp

vars == << pc, count, tmp >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ count = 0
        (* Process Worker *)
        /\ tmp = [self \in 1..N |-> 0]
        /\ pc = [self \in ProcSet |-> "Read"]

Read(self) == /\ pc[self] = "Read"
              /\ tmp' = [tmp EXCEPT ![self] = count]
              /\ pc' = [pc EXCEPT ![self] = "Write"]
              /\ count' = count

Write(self) == /\ pc[self] = "Write"
               /\ count' = tmp[self] + 1
               /\ pc' = [pc EXCEPT ![self] = "Done"]
               /\ tmp' = tmp

Worker(self) == Read(self) \/ Write(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in 1..N: Worker(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION

AllDone == \A p \in 1..N : pc[p] = "Done"

\* Once every worker has finished, the counter should equal N.
Correct == AllDone => count = N
=============================================================================
