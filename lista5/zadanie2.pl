board(L) :-
	length(L, N),
	(even_number(N) -> draw_board(L, N, white, N); draw_board(L, N, black, N)),
	!.
	
% rysuje szachownicę, zaczynając od pola
% o kolorze StartColor (pole w lewym górnym
% rogu ma kolor StartColor).
% Row - numer wiersza (liczony od dołu planszy)
% N - rozmiar szachownicy.
% jedno wywołanie draw_board rysuje jeden wiersz pól
draw_board(L, N, StartColor, 0) :-
	draw_edges(N).
draw_board(L, N, StartColor, Row) :-
	draw_edges(N),
	write('\n'),
	draw_fields(L, N, StartColor, Row, 1),
	write('\n'),
	draw_fields(L, N, StartColor, Row, 1),
	write('\n'),
	NewRow is Row - 1,
	(StartColor = white -> NewStartColor = black; NewStartColor = white),
	draw_board(L, N, NewStartColor, NewRow).
	
% rysuje jedną linię zawierającą środki pól w wierszu
% o numerze Row, zaczynając od pola o kolorze Color.
% pierwszy element listy L określa numer wiersza,
% w którym jest hetman w kolumnie o numerze Column
draw_fields(L, N, Color, Row, N) :-
	draw_last_field(L, N, Color, Row, N).
draw_fields(L, N, Color, Row, Column) :-
	draw_field(L, N, Color, Row, Column),
	NewColumn is Column + 1,
	(Color = white -> NewColor = black; NewColor = white),
	L = [First | Rest],
	draw_fields(Rest, N, NewColor, Row, NewColumn).

draw_last_field(L, N, white, Row, Column) :-
	hetman_on_field(L, Row, Column),
	!,
	write('| ### |').

draw_last_field(L, N, white, Row, Column) :-
	write('|     |').
	
draw_last_field(L, N, black, Row, Column) :-
	hetman_on_field(L, Row, Column),
	!,
	write('|:###:|').
	
draw_last_field(L, N, black, Row, Column) :-
	write('|:::::|').
	
draw_field(L, N, white, Row, Column) :-
	hetman_on_field(L, Row, Column),
	!,
	write('| ### ').
	
draw_field(L, N, white, Row, Column) :-
	write('|     ').
	
draw_field(L, N, black, Row, Column) :-
	hetman_on_field(L, Row, Column),
	!,
	write('|:###:').
	
draw_field(L, N, black, Row, Column) :-
	write('|:::::').

% rysuje górne lub dolne krawędzie dla N pól
draw_edges(1) :-
	draw_last_edge.
draw_edges(N) :-
	draw_edge,
	M is N - 1,
	draw_edges(M).
	
draw_edge :-
	write('+-----').
	
draw_last_edge :-
	write('+-----+').
	
% hetman_on_field([First | L], Row, Column) prawdziwy, jeśli na 
% polu o numerze wiersza Row i numerze kolumny Column stoi hetman.
% Do kolumny o indeksie Column odnosi się 
% pierwszy element listy
hetman_on_field([First | L], First, Column).

even_number(0) :-
	!.
even_number(1) :-
	!, fail.
even_number(N) :-
	M is N - 2,
	even_number(M).
	
% --------------------------------------------------------------------


hetmany(N, P) :-
	numlist(1, N, L),
	perm(L, P),
	dobra(P).

perm([], []).
perm(L1, [X | L3]) :-
	select(X, L1, L2),
	perm(L2, L3).

dobra(X) :-
	\+ zla(X).

zla(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K + 1.
