MACHINE           Club(capacity)
/* This B Machine is taken from the book: The B-Method: An Introduction
   (Editor Palgrave, ISBN 0-33-79284-X, Year 2002) by Steve Schneider.
   This machine is distributed with kind permission by Steve Schneider.
*/
CONSTRAINTS       capacity : NAT1 & capacity <= 2

SETS              REPORT = {yes, no}; NAME

CONSTANTS         total

PROPERTIES        // card(NAME) > capacity &  // not allowed in Atelier-B
                  total : NAT1 & total > 2

VARIABLES         member, waiting

INVARIANT         member <: NAME & waiting <: NAME 
                  & member /\ waiting = {}
                  & card(member) <= 4096
                  & card(waiting) <= total

INITIALISATION    member := {} || waiting := {}

OPERATIONS

  join(nn) =
  PRE nn : waiting & card(member) < capacity
  THEN member := member \/ {nn} || waiting := waiting - {nn} 
  END;

  join_queue(nn) =
  PRE nn : NAME & nn /: member & nn /: waiting
      & card(waiting) < total
  THEN waiting := waiting \/ {nn}
  END;

  remove(nn) =
  PRE nn : member
  THEN member := member - {nn}
  END;

  semi_reset = member, waiting := {}, member;

ans <-- query_membership(nn) =
  PRE nn : NAME
  THEN 
    IF nn : member 
    THEN ans := yes
    ELSE ans := no
    END
  END

END
