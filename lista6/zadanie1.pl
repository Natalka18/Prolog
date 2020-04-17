program([]) --> [].
program([INSTRUKCJA | PROGRAM]) --> 
				instrukcja(INSTRUKCJA), ['sep(;)'], program(PROGRAM).

instrukcja(assign(ID, WYRAZENIE)) --> 
				identyfikator(ID), ['sep(:=)'], wyrazenie(WYRAZENIE).
instrukcja(read(ID)) --> ['key(read)'], identyfikator(ID).
instrukcja(write(WYRAZENIE)) --> ['key(write)'], wyrazenie(WYRAZENIE).
instrukcja(if(WARUNEK, PROGRAM)) --> 
				['key(if)'], warunek(WARUNEK), 
				['key(then)'], program(PROGRAM), ['key(fi)'].
instrukcja(if(WARUNEK, PROGRAM1, PROGRAM2)) --> 
				['key(if)'], warunek(WARUNEK), 
				['key(then)'], program(PROGRAM1), 
				['key(else)'], program(PROGRAM2),
				['key(fi)'].
instrukcja(while(WARUNEK, PROGRAM)) --> 
				['key(while)'], warunek(WARUNEK), 
				['key(do)'], program(PROGRAM), ['key(od)'].
				
wyrazenie(SKLADNIK + WYRAZENIE) --> 
				skladnik(SKLADNIK), ['sep(+)'], wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK - WYRAZENIE) --> 
				skladnik(SKLADNIK), ['sep(-)'], wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK) --> skladnik(SKLADNIK).
				
czynnik(id(ID)) --> identyfikator(ID).
czynnik(int(NUM)) --> liczba_naturalna(NUM).
czynnik((WYRAZENIE)) --> ['sep(()'], wyrazenie(WYRAZENIE), ['sep())'].

skladnik(SKLADNIK) --> czynnik(SKLADNIK).
skladnik(CZYNNIK * SKLADNIK) --> 
				czynnik(CZYNNIK), ['sep(*)'], skladnik(SKLADNIK).
skladnik(CZYNNIK / SKLADNIK) --> 
				czynnik(CZYNNIK), ['sep(/)'], skladnik(SKLADNIK).
skladnik(CZYNNIK mod SKLADNIK) --> 
				czynnik(CZYNNIK), ['key(mod)'], skladnik(SKLADNIK).
				
warunek(KONIUNKCJA ; WARUNEK) --> 
				koniunkcja(KONIUNKCJA), ['key(or)'], warunek(WARUNEK).
warunek(KONIUNKCJA) --> 
				koniunkcja(KONIUNKCJA).
		
koniunkcja(PROSTY) --> prosty(PROSTY).
koniunkcja(PROSTY , KONIUNKCJA) -->
				prosty(PROSTY), ['key(and)'], koniunkcja(KONIUNKCJA).
				
prosty(WYRAZENIE1 =:= WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(=)'], wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 =\= WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(/=)'], wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 < WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(<)'], wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 > WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(>)'], wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 >= WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(>=)'], wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 =< WYRAZENIE2) --> 
				wyrazenie(WYRAZENIE1), ['sep(=<)'], wyrazenie(WYRAZENIE2).
prosty((WARUNEK)) --> ['sep(()'], warunek(WARUNEK), ['sep())'].

% na podstawie "Prolog. Programowanie", 
% rozdział 9., Dodatkowe argumenty
identyfikator(ID, [IdToken | Rest], Rest) :-
	atom_concat('id(', IdWithBracket, IdToken),
	atom_concat(ID, ')', IdWithBracket).
	
liczba_naturalna(NUM, [NumToken | Rest], Rest) :-
	atom_concat('int(', NumWithBracket, NumToken),
	atom_concat(AtomNum, ')', NumWithBracket),
	atom_number(AtomNum, NUM).
