% przykładowe fakty

arc(a,b).
arc(b,a).
arc(b,c).
arc(c,d).

% reguły

osiagalny(X,X).

osiagalny(X,Y) :-
	path(X,Y,[]).
	
path(X,Y,V) :-		% istnieje (pośrednia) ścieżka od X do Y nie przechodząca przez wierzchołki z V
	arc(X,A),
	\+ member(A,V),
	path(A,Y,[X | V]).
	
path(X,Y,V) :- 		% istnieje (bezpośrednia) ścieżka od X do Y nie przechodząca przez wierzchołki z V
	arc(X,Y),
	\+ member(Y,V).