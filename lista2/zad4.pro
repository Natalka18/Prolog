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
	
% X*Y / Y -> X
regula(X*Y, /, Y, X) :-
	number(Y),
	Y =\= 0.
	
regula(X*Y, /, Y, X) :-
	\+ number(Y).
	
% X - X -> 0
regula(X, -, Y, 0) :-
	Y = X.
	
% X * 0 -> 0
regula(_, *, 0, 0).

% 0 * X -> 0
regula(0, *, _, 0).

% reguły

uprosc(Wyrazenie, Wynik) :-		% przypadki, dla których jest zdefiniowany regula/4 (bezpośrednio)
	Wyrazenie =.. L,
	L = [Operator | _],
	select(Operator, L, L1), % L1 oznacza listę L z usuniętym pierwszym elementem
	L1 = [Argument1 | _],
	select(Argument1, L1, L2),
	L2 = [Argument2 | _],
	regula(Argument1, Operator, Argument2, Wynik).
	


uprosc(Wyrazenie, Wyrazenie) :-		% jeśli wyrażenie jest pojedynczym symbolem,
	Wyrazenie =.. L,				% to wynikiem jest wyrażenie
	L = [_ | []].
	
	
uprosc(Wyrazenie, Wynik) :-		% przypadki, dla których jest zdefiniowany regula/4 (pośrednio)
	Wyrazenie =.. L,
	L = [Operator | _],
	select(Operator, L, L1), % L1 oznacza listę L z usuniętym pierwszym elementem
	L1 = [Argument1 | _],
	select(Argument1, L1, L2),
	L2 = [Argument2 | _],
	\+ regula(Argument1, Operator, Argument2, _),
	uprosc(Argument1, Nowy1),
	uprosc(Argument2, Nowy2),
	regula(Nowy1, Operator, Nowy2, Wynik).
	
	