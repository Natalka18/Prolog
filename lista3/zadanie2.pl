% max_sum_pom(L, PrevSum, Sum, PrevMax, Max) jest prawdziwy, gdy:
% - PrevSum jest sumą pewnej podlisty listy L bez pierwszego elementu,
% - PrevMax jest największą wartością spośród sum po wszystkich możliwych
% podlistach listy L bez pierwszego elementu,
% - Max jest największą wartością spośród sum po wszystkich możliwych
% podlistach listy L
max_sum_pom([], PrevSum, PrevMax, Max) :-
	porownaj(PrevSum, PrevMax, Max).
max_sum_pom([X | L], PrevSum, PrevMax, Max) :-
	Sum_temp is PrevSum + X,
	porownaj(Sum_temp, PrevMax, NewPrevMax),
	(Sum_temp < 0 -> NewPrevSum is 0; NewPrevSum is Sum_temp),
	max_sum_pom(L, NewPrevSum, NewPrevMax, Max).
	
% max_sum(L, S)
max_sum(L, S) :-
	max_sum_pom(L, 0, 0, S).

% porownaj(A, B, M) jest prawdziwy, jeśli M jest większym elementem z pary A, B
% lub jeśli M = A w przypadku A = B
porownaj(A, B, B) :-
	B > A.
porownaj(A, B, A) :-
	B =< A.
