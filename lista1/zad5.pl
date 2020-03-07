% przykładowe fakty (relacja podzielności na zbiorze {2,3,6,9,12})

%le(2,6).
%le(3,6).
%le(6,12).
%le(2,12).
%le(3,12).
%le(9,12).
%le(5,5).
%le(6,6).
%le(2,2).
%le(3,3).
%le(9,9).
%le(12,12).

% relacja, która nie jest częściowym porządkiem (brakuje słabej antysymetrii)

%le(a,b).
%le(b,a).
%le(a,a).
%le(b,b).

% mosty eulera

le(1,5).
le(1,2).
le(1,3).
le(1,6).
le(1,1).

le(2,3).
le(2,5).
le(2,6).
le(2,2).

le(3,5).
le(3,6).
le(3,3).

le(6,6).

le(5,6).
le(5,5).

le(3,4).
le(3,7).

le(4,4).
le(4,7).

le(7,7).

le(5,7).
le(6,7).


% reguły pomocnicze

w_dziedzinie(X) :-
	le(X, _); le(_, X).

zwrotna :-
	\+ (w_dziedzinie(X), \+ le(X, X)).
	
przechodnia :-
	\+ (w_dziedzinie(X), w_dziedzinie(Y), w_dziedzinie(Z),
	le(X,Y), le(Y,Z), \+ le(X,Z)
	).
	
antysymetria :-
	\+ (w_dziedzinie(X), w_dziedzinie(Y),
	le(X,Y), le(Y,X), X \= Y
	).
	
% częściowym porządek

czesciowy_porzadek :-
	antysymetria, zwrotna, przechodnia.