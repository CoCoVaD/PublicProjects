----- MODULE RecursiveFunctions2 -----

EXTENDS Integers
Sum[n \in Nat] == IF n = 0 THEN 0 ELSE n + Sum[n-1] 
ASSUME Sum[3] = 6

SumSet[S \in SUBSET Nat] == 
    IF S = {} 
    THEN 0 
    ELSE LET e == CHOOSE x \in S: TRUE
         IN  e + SumSet[S \ {e}] 
ASSUME SumSet[1..3] = 6
\* ASSUME SumSet[1..546] = 149331 \* TLC can still compute this; but SumSet[1..547] generates Stack Overflow

Fib[n \in Nat] == 
    IF n = 1 \/ n = 2 
    THEN 1
    ELSE Fib[n-1] + Fib[n-2]

ASSUME Fib[10] = 55
=======================

