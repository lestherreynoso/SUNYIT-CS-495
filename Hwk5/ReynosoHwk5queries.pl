
:- findall( X, grandparent(X, laurie), L), write(L), nl.
   
:- findall( X, cousin(X, adam), L), write(L), nl.
   
:- findall( X, uncle(X, john), L), write(L), nl.
   
:- findall( X, nephew(X, bob), L), write(L), nl.

:- findall( X, grandparent(X, adam), L), write(L), nl.

:- findall( X, niece(X, bob), L), write(L), nl.

:- findall( X, aunt(X, john), L), write(L), nl.