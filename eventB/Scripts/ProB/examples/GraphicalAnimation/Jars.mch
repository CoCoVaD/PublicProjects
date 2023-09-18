MACHINE Jars
/*
This is the B model of a puzzle from the movie "Die Hard with a Vengeance":
 https://www.youtube.com/watch?v=BVtQNK_ZUJg
 http://www.math.tamu.edu/~dallen/hollywood/diehard/diehard.htm
Input: one 3 gallon and one 5 gallon jug, and we need to measure precisely 4 gallons
*/
DEFINITIONS
  GOAL == (4:ran(level));
  ANIMATION_IMG1 == "images/Filled.gif";
  ANIMATION_IMG2 == "images/Empty.gif";
  ANIMATION_IMG3 == "images/Void.gif";
  gmax == max(ran(maxf));
  ANIMATION_FUNCTION_DEFAULT == {r,c,i | c:Jars & r:1..gmax & i=3};
  ri == (gmax+1-r);
  ANIMATION_FUNCTION == {r,c,i | c:Jars & ri:1..maxf(c) &
                                 (ri<=level(c) => i=1 ) & (ri>level(c) => i=2)};
  ANIMATION_RIGHT_CLICK(J,Fill) ==
               ANY J2,Amount WHERE J2:Jars & Amount:1..gmax THEN
                CHOICE EmptyJar({1|->j3,2|->j5}(J)) OR FillJar({1|->j3,2|->j5}(J)) OR
                       Transfer(J2,Amount,{1|->j3,2|->j5}(J))
                END
               END;
SETS
 Jars = {j3,j5}
CONSTANTS maxf
PROPERTIES maxf : Jars --> NATURAL &
           maxf = {j3 |-> 3, j5 |-> 5} /* in this puzzle we have two jars, with capacities 3 and 5 */
VARIABLES level
INVARIANT
  level: Jars --> NATURAL
INITIALISATION level := Jars * {0}  /* all jars start out empty */
OPERATIONS
  FillJar(j) = /* we can completely fill a jar j */
   PRE j:Jars & level(j)<maxf(j) THEN
    level(j) := maxf(j)
   END;
  EmptyJar(j) = /* we can completely empty a jar j */
   PRE j:Jars & level(j)>0 THEN
    level(j) := 0
   END;
  Transfer(j1,amount,j2) = /* we can transfer from jar j1 to j2 until either j2 is full or j1 is empty */
   PRE j1:Jars & j2:Jars & j1 /= j2 & amount>0 &
                               amount = min({level(j1), maxf(j2)-level(j2)}) THEN
      level := level <+ { j1|-> level(j1)-amount, j2 |-> level(j2)+amount }
   END
END

