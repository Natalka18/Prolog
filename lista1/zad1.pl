% przykładowe fakty

mezczyzna(jan).
mezczyzna(adam).
mezczyzna(edward).
mezczyzna(albert).
mezczyzna(bogdan).

kobieta(alicja).
kobieta(kasia).
kobieta(ania).
kobieta(bogusia).
kobieta(marysia).

ojciec(jan, ania).
ojciec(adam, albert).
ojciec(adam, edward).
ojciec(albert, marysia).
ojciec(albert, bogdan).

matka(kasia, ania).
matka(alicja, albert).
matka(alicja, edward).
matka(bogusia, marysia).
matka(bogusia, bogdan).

rodzic(X,Y) :-
	matka(X,Y); ojciec(X,Y).

% reguły

jest_matka(X) :- 
	matka(X, _).
	
jest_ojcem(X) :- 
	ojciec(X, _).
	
jest_synem(X) :-
	rodzic(_, X), mezczyzna(X).
	
siostra(X,Y) :-
	kobieta(X), rodzic(Z,X), rodzic(Z,Y), X\=Y.
	
dziadek(X,Y) :-
	mezczyzna(X), rodzic(Z,Y), ojciec(X,Z).
	
rodzenstwo(X,Y) :-
	rodzic(Z,X), rodzic(Z,Y), X\=Y.
	
