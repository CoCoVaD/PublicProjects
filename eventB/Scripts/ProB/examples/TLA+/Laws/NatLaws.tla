----- MODULE NatLaws -----
EXTENDS Naturals
CONSTANTS mx
ASSUME mx=10
VARIABLES x,y,z
Init == x = 0 /\ y = 0 /\ z= 0
Invariant ==
   /\ x+y = y+x
   /\ x*y = y*x
   /\ x*(y+z) = x*y+x*z
   /\ (x+y)*z = x*z+y*z
   /\ x*1 = x
   /\ 1*x = x
   /\ x*0 = 0
   /\ 0*x = 0
   /\ 2*x = x+x
   /\ 3*x = x+x+x
   /\ 1 \div 1 = 1
   /\ 0 \div 2 = 0
   /\ 4 \div 2 = 2
   /\ 5 \div 2 = 2
   /\ (x % 2 = 0) <=> (2*(x \div 2)=x)
   /\ (y>0 => y*(x \div y) + (x % y) = x)
   /\ x^1 = x
   /\ (x+1)^0 = 1 \* warning 0^0 is undefined for TLC
   /\ x>y \/ x <= y
   /\ x>y \/ x=y \/ x<y
   /\ x=y \/ x#y
   /\ x=y <=> \lnot x#y
   /\ x>y <=> \lnot x<=y
   /\ x=y <=> x-y = 0
   /\ x-x = 0
   /\ x-y-x+y = 0
   /\ x*x=0 <=> x=0
   /\ x^2 = x*x
   /\ 2^(x+1) = 2*2^x \* this fails in TLC for x >= 30 !
   /\ x+y >= x
   /\ (y>0 /\ z>0) => x^(y+z) = x^y * x^z \* this fails in TLC for x=29 /\ y=29
Incx ==
   /\ x < mx /\  x' = x  + 1
   /\ UNCHANGED <<y,z>>
Maxx == 
   /\ x' = 29
   /\ UNCHANGED <<y,z>>
Incy ==
   /\ y < mx /\ y' = y + 1
   /\ UNCHANGED <<x,z>>
Maxy == 
   /\ y' = 29
   /\ UNCHANGED <<x,z>>
Incz ==
   /\ z < mx /\ z' = z + 1
   /\ UNCHANGED <<x,y>>
Next == Incx \/ Incy \/ Incz \/ Maxx \/ Maxy
=======================

