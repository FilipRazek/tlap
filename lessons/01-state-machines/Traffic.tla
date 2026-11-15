---- MODULE Traffic ----

VARIABLE color

Init == color = "red"
Next == IF color = "red" THEN color' = "green" ELSE IF color = "green" THEN color' = "yellow" \/ color' = "red" ELSE color' = "red"
Spec == Init /\ [][Next]_color
OneOfColors == color \in {"red", "green", "yellow"}           \* an INVARIANT: true in every reachable state

====