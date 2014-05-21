% ----------------------------------------------------------------------
%
%   a Prolog  (Programming in Logic)  source program
%   specifies knowledge by means of
%
%               1.  facts
%               2.  rules
%
%   in the syntax of predicates (functions that returns true or false)
%
%                   refer to your DISCRETE MATH
%
%
%   variables start with an underscore or upper-case letter
%
%   actual values (objects) start with a lower case [or is a literal 
%                  number, string, ...]
%
%   no declarations
%
%
%   comments to end-of-line obviously start with %
%
%
%   note the period at the end of each clause (statement)
%



% ----------------------------------------------------------------------
% a Prolog program specifying facts and rules about humans
% ----------------------------------------------------------------------


%  predicate female( X ) has the intended semantics that X is female
%
% 

female(jill).
female(sue).
female(claire).
female(janet).
female(kathy).
female(laurie).



%  predicate male( X ) has the intended semantics that X is male
%
% 

male(bob).
male(tom).
male(john).
male(cliff).
male(bill).
male(ed).


%  predicate parent( X, Y ) has the intended semantics that 
%            X is a parent of Y
%



parent(bill, tom).
parent(kathy, tom).
parent(tom, sue).
parent(tom, john).
parent(tom, laurie).
parent(jill, sue).
parent(jill, john).
parent(jill, laurie).
parent(janet, adam).
parent(cliff, adam).
parent(claire, jill).
parent(claire, janet).
parent(ed, jill).
parent(ed, janet).
parent(kathy, bob).



%  predicate husband( X, Y ) has the intended semantics that 
%            X is the husband of Y
%

husband(tom, jill).
husband(cliff, janet).
husband(bill, kathy).
husband(ed, claire).



% ----------------------------------------------------------------------
%
%     the above base is all facts
%
%     of course, for most problems, such a fact base is much larger
%
%
%
%
% ----------------------------------------------------------------------


% ----------------------------------------------------------------------
%
%    now, a few rules of interest
%
%    again, the rule base is usually much larger than what is shown
%
%  
%    the rules have an obvious intended semantics
%
% ----------------------------------------------------------------------



mother(X,Y) :- female(X), parent(X,Y).


father(X,Y) :- male(X), parent(X,Y).


wife(X,Y) :- husband(Y,X).  


spouse(X,Y) :- husband(X,Y). 
                          

spouse(X,Y) :- wife(X,Y).    
                          

sibling(X,Y) :- mother(Z,X), mother(Z,Y), X \== Y.


brother(X,Y) :- male(X), sibling(X,Y).


sister(X,Y) :- female(X), sibling(X,Y).


sister_in_law(X,Y) :- sister(X, Z), spouse(Z, Y).
sister_in_law(X,Y) :- wife(X, Z), brother(Z, Y).


brother_in_law(X,Y) :- brother(X, Z), spouse(Z, Y).
brother_in_law(X,Y) :- husband(X, Z), sister(Z, Y).

uncle(X,Y) :- brother(X, Z), parent(Z, Y).
nephew(X,Y) :- male(X), parent(Z, X), sibling(Z, Y).
grandparent(X,Y) :- parent(X, Z), parent(Z, Y).
cousin(X,Y) :- parent(Z, X), parent(W, Y), sibling(Z, W).
niece(X,Y) :- female(X), parent(Z, X), sibling(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).


