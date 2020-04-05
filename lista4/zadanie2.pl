% lista [Number, Color, Nationality, Animal, Drink, Cigarette] opisuje dom
% lista [ [Number1, Color1, Nationality1, Animal1, Drink1, Cigarette1], [Number2, Color2, Nationality2, Animal2, Drink2, Cigarette2],
% [Number3, Color3, Nationality3, Animal3, Drink3, Cigarette3], [Number4, Color4, Nationality4, Animal4, Drink4, Cigarette4],
% [Number5, Color5, Nationality5, Animal5, Drink5, Cigarette5] ] przedstawia wszystkie domy występujące w zagadce w kolejności
% zgodnej z treścią zadania


% predykat jest prawdziwy, jeśli dom o numerze Dom1 jest bezpośrednio po lewej stronie
% domu z numerem Dom2
lewa_strona(Dom1, Dom2) :-
	Dom2 is Dom1 + 1.
	
% predykat jest spełniony, jeśli dom o numerze Dom1 znajduje się obok domu o numerze Dom2
sasiad(Dom1, Dom2) :-
	Dom2 is Dom1 + 1.
sasiad(Dom1, Dom2) :-
	Dom2 is Dom1 - 1.

% predykat jest spełniony, jeśli osoba narodowości Kto hoduje rybki
rybki(Kto) :-
	domy(L),
	member([_, _, Kto, rybki, _, _], L), !.

% predykat jest prawdziwy, jeśli lista domów jest zgodna z treścią zagadki
domy(Domy) :-
	Domy = [ [1, _, _, _, _, _], [2, _, _, _, _, _], [3, _, _, _, _, _], 
			[4, _, _, _, _, _], [5, _, _, _, _, _] ],
	% punkt 1.
	%Nationality1 = norweg,
	member([1, _, norweg, _, _, _], Domy),
	% punkt 2.
	member([_, czerwony, anglik, _, _, _], Domy),
	% punkt 3.
	member([NumerZielony, zielony, _, _, _, _], Domy),
	member([NumerBialy, bialy, _, _, _, _], Domy),
	lewa_strona(NumerZielony, NumerBialy),
	% punkt 4.
	member([_, _, dunczyk, _, herbata, _], Domy),
	% punkt 5.
	member([NumerLight, _, _, _, _, light],Domy),
	member([NumerKoty, _, _, koty, _, _], Domy),
	sasiad(NumerLight, NumerKoty),
	% punkt 6.
	member([_, zolty, _, _, _, cygaro], Domy),
	% punkt 7.
	member([_, _, niemiec, _, _, fajka], Domy),
	% punkt 8.
	member([3, _, _, _, mleko, _], Domy),
	% punkt 9.
	sasiad(NumerLight, SasiadLight),
	member([SasiadLight, _, _, _, woda, _], Domy),
	% punkt 10.
	member([_, _, _, ptaki, _, bez_filtra], Domy),
	% punkt 11.
	member([_, _, szwed, psy, _, _], Domy),
	% punkt 12.
	member([2, niebieski, _, _, _, _], Domy),
	% punkt 13.
	member([NumerKonie, _, _, konie, _, _], Domy),
	sasiad(NumerKonie, NumerZolty),
	member([NumerZolty, zolty, _, _, _, _], Domy),
	% punkt 14.
	member([_, _, _, _, piwo, mentolowe], Domy),
	% punkt 15.
	member([_, zielony, _, _, kawa, _], Domy).