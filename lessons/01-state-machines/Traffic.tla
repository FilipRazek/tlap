---- MODULE Traffic ----

VARIABLE color

Init == color = "red"
Next == \/ (color = "red"    /\ color' = "green")
        \/ (color = "green"  /\ color' = "yellow")
        \/ (color = "green"  /\ color' = "red")
        \/ (color = "yellow" /\ color' = "red")
Spec == Init /\ [][Next]_color
OneOfColors == color \in {"red", "green", "yellow"}           \* an INVARIANT: true in every reachable state

====