% max_sum_pom(L, Sum, Max) jest prawdziwy, jeśli sumą elementów pewnej podlisty
% listy L oraz Max jest maksymalną taką sumą
max_sum_pom([], 0, 0).
max_sum_pom([X | L], Sum, Max) :-
	max_sum_pom(L, S, M),
	Sum_temp is S + X,
	porownaj(Sum_temp, M, Max),
	(Sum_temp < 0 -> Sum is 0; Sum is Sum_temp).

% porownaj(A, B, M) jest prawdziwy, jeśli M jest większym elementem z pary A, B
% lub jeśli M = A w przypadku A = B
porownaj(A, B, B) :-
	B > A.
porownaj(A, B, A) :-
	B =< A.

% max_sum(L, S) jest prawdziwy, jeśli S jest największą wartością spośród sum
% po wszystkich możliwych podlistach listy L
max_sum(L, S) :-
	max_sum_pom(L, _, S).