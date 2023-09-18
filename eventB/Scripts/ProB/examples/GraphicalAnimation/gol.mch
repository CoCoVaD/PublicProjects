MACHINE gol
 /* A simple B model of the Game of Life */
 /* by Jens Bendisposto and Michael Leuschel */
 /* Nov 2019, v2: improved version with more elegant neighbour relation */
ABSTRACT_CONSTANTS nc, neigh
PROPERTIES
  /* neighbour relation: */
  neigh = {x,y,nb | x:COORD & y:COORD & (x,y)/= nb & 
                    prj1(COORD,COORD)(nb):(x-1)..(x+1) &
                    prj2(COORD,COORD)(nb) :(y-1)..(y+1) } &
  /* neighbour count function: */
  nc = %(ab,alive).(ab:COORD*COORD & alive <: COORD*COORD
                      | card(neigh[{ab}] /\ alive)) 
VARIABLES alive
DEFINITIONS 
      COORD == INTEGER;
      /* some simple GOL patterns : */
      blinker == {(2,1),(2,2),(2,3)} ; glider == {(1,2),(2,3),(3,1),(3,2),(3,3)} ;
      SET_PREF_CLPFD == TRUE;
      
      /* describing the animation function for the graphical visualization : */
      wmin == min(dom(alive)\/{1}); wmax == max(dom(alive)\/{1});
      hmin == min(ran(alive)\/{1}); hmax == max(ran(alive)\/{1});
      ANIMATION_FUNCTION_DEFAULT == ( (wmin..wmax)*(hmin..hmax)*{0}  );
      ANIMATION_FUNCTION == ( alive * {1} );
      ANIMATION_RIGHT_CLICK(I,J) == BEGIN step END;
      ANIMATION_IMG0 == "images/sm_empty_box.gif";
      ANIMATION_IMG1 == "images/sm_gray_box.gif"
INVARIANT
    alive <: COORD * COORD & alive /= {}
INITIALISATION 
	alive := glider
OPERATIONS 
    step  =  alive := { uv | uv:alive & nc(uv,alive) : {2,3} }
                   \/
                   { uv2 |  uv2:neigh[alive] & /* restrict enumeration to neighbours of alive */
                            uv2/:alive & nc(uv2,alive)=3 }
END
