---- MODULE Traffic ----

VARIABLE color

Init == color \in {"red", "green", "yellow"}
Next == color' = IF color = "red" THEN "green" ELSE IF color = "green" THEN "yellow" ELSE "red"
Spec == Init /\ [][Next]_color
OneOfColors == color \in {"red", "green", "yellow"}           \* an INVARIANT: true in every reachable state

====