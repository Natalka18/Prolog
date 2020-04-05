% predykat expression(L, E) jest prawdziwy, jeśli E jest wyrażeniem 
% arytmetyczym zbudowanym z liczb z listy L oraz operatorów +, -, *,
% / i nawiasów
expression([Number], Number).

expression(List, Expression) :-
	List = [Number1, Number2 | Rest],
	short_expression([Number1, Number2], E),
	append([E], Rest, NewList),
	expression(NewList, Expression).

% short_expression([Number1, Number2], E) jest prawdziwy jeśli E jest wyrażeniem
% arytmetycznym przedstawiającym sumę, różnicę, iloczyn lub iloraz liczb Number1
% i Number2
short_expression([Number1, Number2], Number1 + Number2).
short_expression([Number1, Number2], Number1 - Number2).
short_expression([Number1, Number2], Number1 * Number2).
short_expression([Number1, Number2], E) :-
	E = Number1 / Number2,
	\+ Number2 is 0.
	
wyrażenie(Lista, Wartosc, Wyrazenie) :-
	expression(Lista, Wyrazenie),
	Wartosc is Wyrazenie, !.
