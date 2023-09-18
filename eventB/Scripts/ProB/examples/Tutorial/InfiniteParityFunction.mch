MACHINE InfiniteParityFunction
CONSTANTS parity
PROPERTIES
   parity : NATURAL --> INTEGER & 
   parity = %x.(x:NATURAL|x mod 2)
VARIABLES c
INVARIANT
 c: NATURAL
INITIALISATION c:=0
OPERATIONS
  Inc = BEGIN c:=c+1 END;
  r <-- Parity = BEGIN r:= parity(c) END;
  r <-- ParityImage = BEGIN r:= parity[0..c] END;
  r <-- ParityHistory = BEGIN r:= (%i.(i:1..c+1|i-1) ; parity) END
END

