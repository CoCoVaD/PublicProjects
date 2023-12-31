MACHINE           Hotelguests(sze)
/* This B Machine is taken from the book: The B-Method: An Introduction
   (Editor Palgrave, ISBN 0-33-79284-X, Year 2002) by Steve Schneider.
   This machine is distributed with kind permission by Steve Schneider.
*/
CONSTRAINTS       sze : NAT1

SETS              ROOM; NAME; REPORT = {present, notpresent}

CONSTANTS         empty

PROPERTIES        card(ROOM) = sze & empty : NAME

VARIABLES         guests

INVARIANT         guests : ROOM --> NAME

INITIALISATION    guests := ROOM * {empty}

OPERATIONS

  guestcheckin(rr,nn) =
  PRE rr : ROOM & nn : NAME & nn /= empty
  THEN guests(rr) := nn
  END;

  guestcheckout(rr) = 
  PRE rr : ROOM
  THEN guests(rr) := empty 
  END;

nn <-- guestquery(rr) = 
  PRE rr : ROOM
  THEN nn := guests(rr) 
  END;

rr <-- presentquery(nn) =
  PRE nn : NAME & nn /= empty
  THEN IF nn : ran(guests)
       THEN rr := present
       ELSE rr := notpresent
       END
  END;

guestswap(rr,ss) = 
  PRE rr : ROOM & ss : ROOM
  THEN guests := guests <+ {rr |-> guests(ss),ss|-> guests(rr)}
  END

END


