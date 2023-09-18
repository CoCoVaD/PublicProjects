----- MODULE SetLaws -----
EXTENDS Naturals, FiniteSets
CONSTANTS mx
ASSUME mx=5
VARIABLES x,y,z
Init == x = {} /\ y = {} /\ z= {}
Maximal(s) == {v \in s : \A w \in s : v >= w} 
Invariant ==
   /\ x \subseteq 1..mx
   /\ y \subseteq 1..mx
   /\ z \subseteq 1..mx
   /\ x \cup y = y \cup x
   /\ x \cap y = y \cap x
   /\ (x \cup (y \cup z)) = ((x \cup y) \cup z)
   /\ Cardinality((x \cap y)) <= (Cardinality(x)+Cardinality(y))
   /\ (x \cup y) = (x \cap y) \cup (x \ y) \cup (y \ x)
   /\ (x \cup y) = {n \in 1..mx : n\in x \/ n \in y}
   /\ (x \cap y) = {n \in 1..mx : n\in x /\ n \in y}
   /\ (x \ y) = {n \in 1..mx : n\in x /\ n \notin y}
   /\ {n \in x : n \in y} = x \cap y
   /\ {n \in x : n \in y  \/ n \in z} = x \cap (y \cup z)
   /\ {n \in 1..mx : n\in x /\ (n \in y  \/ n \in z)} = x \cap (y \cup z)
   /\ (Cardinality(x \cup y ) = Cardinality(x)+Cardinality(y)) <=> (x \cap y = {})
   /\ (Maximal(x \cup y) = Maximal(x) \/ Maximal(x \cup y) = Maximal(y))
   /\ Cardinality(1..Cardinality(x)) = Cardinality(x)
   /\ Cardinality(x \cap y) <= Cardinality(x)
   /\ Cardinality(x \cup y) >= Cardinality(x)
   /\ (x \cup y) = {n \in 1..mx : (\E xx \in x : xx=n) \/ (\E yy \in y : n=yy)}
   /\ (x \cap y) = {n \in 1..mx : (\E xx \in x : xx=n) /\ (\E yy \in y : n=yy)}
   /\ (x#{} \/ y=1..mx) <=> (x \cup ((1..mx) \ y) = {n \in 1..mx : \E xx \in x : xx=n \/ \A yy \in y : n # yy})
   /\ x \cup ((1..mx) \ y) = {n \in 1..mx : (\E xx \in x : xx=n) \/ \A yy \in y : n # yy}
   /\ x=y \/ x#y
   /\ x=y <=> \lnot x#y
Addx ==
   /\ \E n \in (1..mx)\ x : x' = x \cup {n}
   /\ UNCHANGED <<y,z>>
Addy ==
   /\ \E n \in (1..mx)\ y : y' = y \cup {n}
   /\ UNCHANGED <<x,z>>
Addz ==
   /\ \E n \in (1..mx)\ z : z' = z \cup {n}
   /\ UNCHANGED <<x,y>>
Next == Addx \/ Addy \/ Addz
=======================

