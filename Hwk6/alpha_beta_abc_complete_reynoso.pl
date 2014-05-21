/* --------------------------------------------------------
 *
 *   The abcdefghklmno  game
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
*/

moves(a,[b,c]).                  % look at my slides
moves(b,[d,e]).
moves(c,[f,g]).
moves(d,[h,i]).
moves(e,[j,k]).
moves(f,[l,m]).
moves(g,[n,o]).


utility(P,V) :- 
    utility1(P,V), 
    write('utility at node '), writeln(P=V).


utility1(h,1).
utility1(i,4).
utility1(j,5).
utility1(k,6).
utility1(l,2).
utility1(m,1).
utility1(n,3).
utility1(o,1).


max(a).
max(d).
max(e).
max(f).
max(g).


min(b).
min(c).
min(h).
min(i).
min(j).
min(k).
min(l).
min(m).
min(n).
min(o).



/* ---------------------------------------------------------
 *
 *   An implementation of the
 *             alpha-beta prunning algorithm
 *   for adversarial game trees
 *
 *
 *   call: 
 *       alpha_beta( +CurrentBoard, +InitialAlpha, +InitialBeta,
 *                   -BestMove, -UtilityValue ).  
 *
 *   Note that
 *                alpha_beta
 *                next_move
 *                good_move
 *    
 *   are  MUTUALLY RECURSIVE
 *
 *---------------------------------------------------------
*/



/*  HOMEWORK 5

    write the two clauses for the alpha_beta predicate:

       alpha_beta( CurrentBoard, Alpha, Beta, BestMove, Util)

    it should be like the minimax predicate
    in the other files

    note that here I use
         next_move
    as you see below, instead of best_move
    
*/

alpha_beta(CurrentBoard, Alpha, Beta, BestMove, Util) :- 
    moves(CurrentBoard, SuccessorList),     % not a terminal board,
                                            % because CurrentBoard has
    !,                                      % successors listed;                            
                                            % note the cut    
    next_move(SuccessorList, Alpha, Beta, BestMove, Util).


alpha_beta(CurrentBoard, _ , _, _ , Util) :- % a terminal board otherwise;
    utility(CurrentBoard, Util).    % an explicit utility value
                                       % must have been provided
                                       % for such board configuration
   


next_move([P|Tail], Alpha, Beta, Next, Eval) :- 
    alpha_beta(P, Alpha, Beta, _ , V),
    good_move(Tail, Alpha, Beta, P, V, Next, Eval).


good_move([],_,_,P,V,P,V) :- !.

good_move(_,_,Beta,P,V,P,V) :-
    min(P),
    V > Beta, !.

good_move(_,Alpha,_,P,V,P,V) :-
    max(P),
    V < Alpha, !.

good_move(Ps,Alpha,Beta,P,V,GoodP,GoodV) :-
    newbounds(Alpha,Beta,P,V,NewAlpha,NewBeta),
    next_move(Ps,NewAlpha,NewBeta,P1,V1),
    select_better_move(P,V,P1,V1,GoodP,GoodV).


newbounds(Alpha,Beta,P,V,V,Beta) :-    % to update Alpha/Beta
    min(P),
    V > Alpha, !.

newbounds(Alpha,Beta,P,V,Alpha,V) :-
    max(P),
    V < Beta, !.

newbounds(Alpha,Beta,_,_,Alpha,Beta).



select_better_move( P1, V1, _ , V2, P1, V1) :-
    min(P1),                % if min plays in 
                            % successor configuration P1,
    V1 > V2, !.             % then max plays in parent CurrentBoard

select_better_move( P1, V1, _ , V2, P1, V1) :-
    max(P1),
    V1 < V2, !.

select_better_move(_,_,P2,V2,P2,V2).
