same_length([],[]).
same_length([_|L1], [_|L2]) :-
	same_length(L1,L2).
	
srodkowy(L,X) :-
	append(L1, [X|L2], L),
	same_length(L1,L2).