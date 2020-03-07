% przykładowe fakty (relacja podzielności na zbiorze {2,3,6,9,12})

le(2,6).
le(3,6).
le(6,12).
le(2,12).
le(3,12).
le(9,12).
%le(5,5).
le(6,6).
le(2,2).
le(3,3).
le(9,9).
le(12,12).

% reguły

maksymalny(A) :-
	\+ ( ( le(X,X), X \= A, le(A,X) ); \+ le(A,A)).
	
najwiekszy(A) :-
	\+ ( ( le(X,X), \+le(X,A)); \+ le(A,A)).
	
minimalny(A) :-
	\+ ( ( le(X,X), X \= A, le(X,A) ); \+ le(A,A)).
	
najmniejszy(A) :-
	\+ ( ( le(X,X), \+le(A,X)); \+ le(A,A)).