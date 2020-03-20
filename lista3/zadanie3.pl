% insert_even(X, L, P) jest prawdziwy
% jeśli L jest listą, która jest parzystą permutacją pewnej listy L' i P jest
% parzystą permutacją listy L'+[X]
insert_even(X, L, P) :-  % wstawiamy element X tak, że za nim znajduje się
	append(L, [X], P).   % parzysta liczba elementów
insert_even(X, L, P) :-
	append(NewL, [A, B], L),
	insert_even(X, NewL, P1),
	append(P1, [A, B], P).

% insert_odd(X, L, P) - analogicznie do insert_even(X, L, P)
insert_odd(X, L, P) :-
	append(L1, [Y], L),
	append(L1, [X, Y], P).
insert_odd(X, L, P) :-
	append(NewL, [A, B], L),
	insert_odd(X, NewL, P1),
	append(P1, [A, B], P).
	
% even_permutation(Xs, Ys)
even_permutation([], []).
even_permutation(Xs, Ys) :-
	append(L, [X], Xs),
	even_permutation(L, P),
	insert_even(X, P, Ys).
even_permutation(Xs, Ys) :-
	append(L, [X], Xs),
	odd_permutation(L, P),
	insert_odd(X, P, Ys).

% odd_permutation(Xs, Ys)
odd_permutation(Xs, Ys) :-
	append(L, [X], Xs),
	odd_permutation(L, P),
	insert_even(X, P, Ys).
odd_permutation(Xs, Ys) :-
	append(L, [X], Xs),
	even_permutation(L, P),
	insert_odd(X, P, Ys).