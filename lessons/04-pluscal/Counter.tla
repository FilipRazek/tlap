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
variables count = 0;   lock = FALSE;             \* shared by all workers

process Worker \in 1..N
variables tmp = 0;                  \* local: each worker has its own
begin
  Acquire: await ~lock; lock := TRUE;
  Read: tmp := count;
  Write: count := tmp + 1;
  Release: lock := FALSE;
end process;
end algorithm; *)

\* BEGIN TRANSLATION
VARIABLES pc, count, lock, tmp

vars == << pc, count, lock, tmp >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ count = 0
        /\ lock = FALSE
        (* Process Worker *)
        /\ tmp = [self \in 1..N |-> 0]
        /\ pc = [self \in ProcSet |-> "Acquire"]

Acquire(self) == /\ pc[self] = "Acquire"
                 /\ ~lock
                 /\ lock' = TRUE
                 /\ pc' = [pc EXCEPT ![self] = "Read"]
                 /\ UNCHANGED << count, tmp >>

Read(self) == /\ pc[self] = "Read"
              /\ tmp' = [tmp EXCEPT ![self] = count]
              /\ pc' = [pc EXCEPT ![self] = "Write"]
              /\ UNCHANGED << count, lock >>

Write(self) == /\ pc[self] = "Write"
               /\ count' = tmp[self] + 1
               /\ pc' = [pc EXCEPT ![self] = "Release"]
               /\ UNCHANGED << lock, tmp >>

Release(self) == /\ pc[self] = "Release"
                 /\ lock' = FALSE
                 /\ pc' = [pc EXCEPT ![self] = "Done"]
                 /\ UNCHANGED << count, tmp >>

Worker(self) == Acquire(self) \/ Read(self) \/ Write(self) \/ Release(self)

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
