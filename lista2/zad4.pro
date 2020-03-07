% fakty

% X / X -> 1
regula(X, /, X, 1) :-
	number(X),
	X =\= 0.
	
regula(X, /, X, 1) :-
	\+ number(X).

% 0 + X -> X
regula(X,+,Y,Y) :-
	number(X),
	X =:= 0, !.

% reguły

uprosc(Wyrazenie, Wynik) :-
	Wyrazenie =.. L,
	L = [Operator | _],
	select(Operator, L, L1), % L1 oznacza listę L z usuniętym pierwszym elementem
	L1 = [Argument1 | _],
	select(Argument1, L1, L2),
	L2 = [Argument2 | _],
	regula(Argument1, Operator, Argument2, Wynik).