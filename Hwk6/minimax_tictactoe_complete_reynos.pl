/* --------------------------------------------------------
 *
 *   The tic-tac-toe game
 *
 * --------------------------------------------------------
 *
 *   Any other game will have to provide its own predicates
 *
 *             moves/2            
 *             utility/2
 *             utility1/2    as necessary
 *             max/1
 *             min/1
 *
 *   moves( BoardConfiguration, ListOfAllowedChildren )
 *   utility(  GameBoardConfiguration, UtilityValue )
 *   utility1(  EndGameBoardConfiguration, UtilityValue )
 *   max( BoardConfigThatMaxMayPlay )
 *   min( BoardConfigThatMinMayPlay )
 *
 *             see the code below
 *
 * -------------------------------------------------------
 *
 *   For tic-tac-toe, a board configuration
 *
 *        is a list  like [ Z, x, o, T, U, x, o, W, M ]
 *        where some members are already ground x (by max)
 *        and ground o (by min), while other members are
 *        not instantiated to x or o yet (still var(V))
 *
 * ------------------------------------------------------
*/




moves(Board, ListOfNextMoves) :-      % to generate MAX's moves
   max(Board),
   findall(Board, (member(V,Board),var(V), V=x) , ListOfNextMoves), 
   ListOfNextMoves \=[].


/*  HOMEWORK 5
*/
moves(Board,ListOfNextMoves) :-       % to generate MIN's moves
   min(Board), 
   findall(Board, (member(V,Board), var(V), V=o), ListOfNextMoves),
   ListOfNextMoves \=[].



utility([A,B,C,_,_,_,_,_,_],V) :- tictac(A,B,C,V), !.
utility([_,_,_,A,B,C,_,_,_],V) :- tictac(A,B,C,V), !.
utility([_,_,_,_,_,_,A,B,C],V) :- tictac(A,B,C,V), !.



/*  HOMEWORK 5

    other clauses for  utility/2 as above
    for other winning boards
*/

utility1([A,_,_,B,_,_,C,_,_],V) :- tictac(A,B,C,V), !.  %VERTICAL WINS
utility1([_,A,_,_,B,_,_,C,_],V) :- tictac(A,B,C,V), !.
utility1([_,_,A,_,_,B,_,_,C],V) :- tictac(A,B,C,V), !.

utility1([A,_,_,_,B,_,_,_,C],V) :- tictac(A,B,C,V), !.  %DIAGONAL WINS
utility1([_,_,A,_,B,_,C,_,_],V) :- tictac(A,B,C,V), !.



utility(A,0) :- ground(A).    %  this one for draws



tictac(A,B,C,1)  :-   A==x,B==x,C==x.   % for max (playing x) winning


/* HOMEWORK 5

   how about a clause tictac/4
   for min (playing o) winning?

*/
tictac(A,B,C,1) :- A==o,B==o,C==o.  %for min (playing o) winning



max(Board) :-                   % when it is MAX's turn to play,
                                % the board (a list; see above
                                % comment) has still
                                % an ODD number of variables
   findall( V,( member(V,Board), var(V)), L),
   length(L,N), 1 is N mod 2, !.


/* HOMEWORK 5
   how about a clause 
       min(Board)
   for min, similar to max(Board)?

*/

min(Board) :-      % when it is MIN's turn to play,
                   % the board (a list; see above
                   % comment) has still
                   % an EVEN number of variables
   findall( V,( member(V,Board), var(V)), L), 
   length(L,M), 0 is M mod 2, !.
     







/*  -----------------------------------------------------------
 *
 *  a  game tree minimax algorithm implementation
 *                                              
 *  call: 
 *           minimax( +CurrentPosition,-BestMove,-MinmaxValue).  
 *  i.e.
 *           minimax( +CurrentBoard,-BestMoveToPlay,-UtilityValue). 
 *            
 * -------------------------------------------------------------
 *
 *  Note that
 *                     minimax
 *                and  best_move
 *
 *  are MUTUALLY RECURSIVE.
 *
 * ------------------------------------------------------------
*/


minimax(CurrentBoard, BestMove, Utility) :-
    moves(CurrentBoard, SuccessorList),     % not a terminal board,
                                            % because CurrentBoard has
    !,                                      % successors listed;                            
                                            %   note the cut    
    best_move(SuccessorList, BestMove, Utility).


minimax(CurrentBoard, _ , Utility) :-  % a terminal board otherwise;

    utility(CurrentBoard, Utility).    % an explicit utility value
                                       % must have been provided
                                       % for such board configuration
                                                 



best_move( [P],P,V ) :-             %  if only move is allowed
    minimax( P,_,V ), !.

best_move( [P|Tail], BestMove, Value ) :-
    minimax( P, _ , Value1 ),
    best_move( Tail, BestMoveInTail, Value2 ),
    select_better_move( P, Value1, BestMoveInTail, Value2, 
                        BestMove, Value ).



select_better_move( P1, V1, _ , V2, P1, V1) :-
    min(P1),                % if min plays in 
                            % successor configuration P1,
    V1 > V2, !.             % then max plays in parent CurrentBoard

select_better_move( P1, V1, _ , V2, P1, V1) :-
    max(P1),
    V1 < V2, !.

select_better_move(_,_,P2,V2,P2,V2).

