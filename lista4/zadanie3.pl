% ułożenie zapałek reprezentowane jest przez listę liczb,
% gdzie każda liczba od 1 do 24 odpowiada jednej zapałce

wszystkie_zapalki([1,2,3,4,5,6,7,8,9,10,11,12,13,
					14,15,16,17,18,19,20,21,22,23,24]).

% maly_kwadrat(L) jest prawdziwy, jeśli lista L zawiera tylko liczby
% odpowiadające zapałkom, które tworzą mały kwadrat
maly_kwadrat([1,4,5,8]).
maly_kwadrat([2,5,6,9]).
maly_kwadrat([3,6,7,10]).
maly_kwadrat([8,11,12,15]).
maly_kwadrat([9,12,13,16]).
maly_kwadrat([10,13,14,17]).
maly_kwadrat([15,18,19,22]).
maly_kwadrat([16,19,20,23]).
maly_kwadrat([17,20,21,24]).

% sredni_kwadrat(L) jest prawdziwy, jeśli lista L zawiera tylko liczby
% odpowiadające zapałkom, które tworzą średni kwadrat
sredni_kwadrat([1,2,4,6,11,13,15,16]).
sredni_kwadrat([2,3,5,7,12,14,16,17]).
sredni_kwadrat([8,9,11,13,18,20,22,23]).
sredni_kwadrat([9,10,12,14,19,21,23,24]).

% duzy_kwadrat(L) jest prawdziwy, jeśli lista L zawiera tylko liczby
% odpowiadające zapałkom, które tworzą duzy kwadrat
duzy_kwadrat([1,2,3,4,7,11,14,18,21,22,23,24]).

	
% predykat jest prawdziwy, jeśli lista Maly reprezentuje maly kwadrat
% należący do listy L
znajdz_maly(L, Maly) :-
	maly_kwadrat(Maly),
	subset(Maly, L).
	
% predykat jest prawdziwy, jeśli lista Sredni reprezentuje sredni kwadrat
% należący do listy L
znajdz_sredni(L, Sredni) :-
	sredni_kwadrat(Sredni),
	subset(Sredni, L).

% predykat zbior_malych(L, Male, N) jest prawdziwy, jeśli lista L zawiera 
% zapałki, które tworzą dokładnie N małych kwadratów zawartych w liście Male.
zbior_malych(L, Ms, Male, N, N_poczatkowe) :-
	znajdz_maly(L, M),
	\+ member(M, Ms),
	append([M], Ms, Ms2),
	N_poczatkowe2 is N_poczatkowe + 1,
	zbior_malych(L, Ms2 , Male, N, N_poczatkowe2), !.
zbior_malych(L, Ms, Male, N, N_poczatkowe) :-
	\+ (znajdz_maly(L, M), \+ member(M, Ms)),
	Male = Ms,
	N = N_poczatkowe.
zbior_malych(L, Male, N) :-
	zbior_malych(L, [], Male, N, 0).
	
% predykat zbior_srednich(L, Srednie, N) jest prawdziwy, jeśli lista L zawiera 
% zapałki, które tworzą dokładnie N średnich kwadratów zawartych w liście Srednie.
zbior_srednich(L, Ms, Srednie, N, N_poczatkowe) :-
	znajdz_sredni(L, M),
	\+ member(M, Ms),
	append([M], Ms, Ms2),
	N_poczatkowe2 is N_poczatkowe + 1,
	zbior_srednich(L, Ms2 , Srednie, N, N_poczatkowe2), !.
zbior_srednich(L, Ms, Srednie, N, N_poczatkowe) :-
	\+ (znajdz_sredni(L, M), \+ member(M, Ms)),
	Srednie = Ms,
	N = N_poczatkowe.
zbior_srednich(L, Srednie, N) :-
	zbior_srednich(L, [], Srednie, N, 0).
	
% predykat liczba_duzych(L, N) jest prawdziwy, jeśli lista L zawiera 
% zapałki, które tworzą dokładnie N dużych kwadratów
liczba_duzych(L, 1) :-
	duzy_kwadrat(Duzy),
	subset(Duzy, L),!.
liczba_duzych(L, 0) :-
	duzy_kwadrat(Duzy),
	\+ subset(Duzy, L).


% podzbior(Len, L1, L2) jest prawdziwy, jeśli L2 jest podzbiorem
% listy L1 o długości Len
podzbior(0, [], []).
podzbior(Len, [E|Tail], [E|NTail]):-
	PLen is Len - 1,
	(PLen > 0 -> podzbior(PLen, Tail, NTail) ; NTail=[]).
podzbior(Len, [_|Tail], NTail):-
	podzbior(Len, Tail, NTail).
	
	
kwadraty(L, N, 1, S, M) :-  % N - ilość zapałek, które zostały
	wszystkie_zapalki(Wszystkie),
	zbior_malych(Wszystkie, WszystkieMale, _),
	zbior_srednich(Wszystkie, WszystkieSrednie, _),
	duzy_kwadrat(ListaZapalekDuze),
	podzbior(M, WszystkieMale, Male),
	podzbior(S, WszystkieSrednie, Srednie),
	elementy(ListaZapalekMale, Male),
	elementy(ListaZapalekSrednie, Srednie),
	union(ListaZapalekDuze, ListaZapalekSrednie, Sum1),
	union(ListaZapalekMale, Sum1, Sum2),
	sort(Sum2, L),
	length(L, N),
	zbior_malych(L, _, M),
	zbior_srednich(L, _, S),
	liczba_duzych(L, 1),
	rysuj_kwadraty(L).
	
kwadraty(L, N, 0, S, M) :-
	wszystkie_zapalki(Wszystkie),
	zbior_malych(Wszystkie, WszystkieMale, _),
	zbior_srednich(Wszystkie, WszystkieSrednie, _),
	podzbior(M, WszystkieMale, Male),
	podzbior(S, WszystkieSrednie, Srednie),
	elementy(ListaZapalekMale, Male),
	elementy(ListaZapalekSrednie, Srednie),
	union(ListaZapalekMale, ListaZapalekSrednie, Sum1),
	sort(Sum1, L),
	length(L, N),
	zbior_malych(L, _, M),
	zbior_srednich(L, _, S),
	duzy_kwadrat(ListaZapalekDuze),
	\+ subset(ListaZapalekDuze, L),
	rysuj_kwadraty(L).
	

rysuj_kwadraty(L) :-
	wszystkie_zapalki(Wszystkie),
	rysuj_kwadraty(L, Wszystkie).
rysuj_kwadraty(L, Wszystkie) :-
	Wszystkie = [X | Rest],
	member(X, L),
	rysuj_zapalke(X),
	rysuj_kwadraty(L, Rest).
rysuj_kwadraty(_, []).
rysuj_kwadraty(L,Wszystkie) :-
	Wszystkie = [X | Rest],
	\+ member(X, L),
	rysuj_puste(X),
	rysuj_kwadraty(L, Rest).
	
rysuj_puste(X) :-
	member(X, [1,2,8,9,15,16,22,23]),
	write('+   ').
rysuj_puste(X) :-
	member(X, [3,10,17,24]),
	write('+   +'), nl.
rysuj_puste(X) :-
	member(X, [4,5,6,11,12,13,18,19,20]),
	write('    ').
rysuj_puste(X) :-
	member(X, [7,14,21]),
	write(' '), nl.


rysuj_zapalke(X) :-
	member(X, [1,2,8,9,15,16,22,23]),
	write(+---).
rysuj_zapalke(X) :-
	member(X, [3,10,17,24]),
	write(+---+), nl.
rysuj_zapalke(X) :-
	member(X, [4,5,6,11,12,13,18,19,20]),
	write('|   ').
rysuj_zapalke(X) :-
	member(X, [7,14,21]),
	write('|'), nl.

% elementy(Elems, L) jest prawdziwy, jeśli Elems jest listą o elementach
% należących do elementów listy L
elementy(Elems, L) :-
	elementy(Elems, [], L).
elementy(Elems, Elems_poczatkowe, L) :-
	L = [M | Rest],
	append(M, Elems_poczatkowe, Elems_poczatkowe2),
	elementy(Elems, Elems_poczatkowe2, Rest), !.
elementy(Elems, Elems_poczatkowe, []) :-
	Elems =  Elems_poczatkowe.

zapalki(N, (duze(D), srednie(S), male(M))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, D, S, M).
zapalki(N, (srednie(S), male(M))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, 0, S, M).
zapalki(N, (duze(D), male(M))) :-
	kwadraty(_, LiczbaZapalek, D, 0, M),
	N is 24 - LiczbaZapalek.
zapalki(N, (duze(D), srednie(S))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, D, S, 0).
zapalki(N, (duze(D))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, D, 0, 0).
zapalki(N, (srednie(S))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, 0, S, 0).
zapalki(N, (male(M))) :-
	LiczbaZapalek is 24 - N,
	kwadraty(_, LiczbaZapalek, 0, 0, M).
