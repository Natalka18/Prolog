% predykat sum(L, S, N) jest prawdziwy, jeśli S jest sumą elementów listy L,
% a N jest liczbą elementów w liście
sum([], 0, 0).
sum([X | L], S, N) :-
	sum(L, S1, N1),
	S is X + S1,
	N is N1 + 1.

% mean(L, M, N) jest prawdziwy, jeśli M jest średnią arytmetyczną elementów listy L,
% a N jest liczbą elementów w liście
mean([], 0, 0).
mean(L, M, N) :-
	\+ L = [],
	sum(L, S, N),
	M is S / N.

% variance_sum(L, S, M) jest prawdziwy, jeśli S jest sumą kwadratów różnic elementów
% listy L i liczby M
variance_sum([], 0, _).
variance_sum([X | L], S, M) :-
	variance_sum(L, S1, M),
	S is S1 + (M - X)*(M - X).

% wariancja(L, D) jest prawdziwy, jeśli D jest wariancją elementów listy L
wariancja([], 0).
wariancja(L, D) :-
	mean(L, M, N),
	variance_sum(L, S, M),
	D is S / N.