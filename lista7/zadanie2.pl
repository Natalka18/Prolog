split(IN, OUT1, OUT2) :-
	split(IN, OUT1, OUT2, 0).

merge_sort(IN, OUT) :-
	freeze(IN, % ukonkretniła się lista IN
			(	IN = [H | T]
			->	freeze(T,  % ukonkretnił się też jej ogon
						(	\+ (T = [])  % IN jest przynajmniej dwuelementowy
						->	split(IN, Part1, Part2),
							merge_sort(Part1, OUT1),
							merge_sort(Part2, OUT2),
							merge(OUT1, OUT2, OUT)
						;	OUT = [H]))  % ogon jest pusty - IN jest jednoelementowy
			;	OUT = [])).  % IN jest pusty
	
% jeśli Counter jest zerem, to dodajemy element
% do listy L1. Jeśli jest jedynką, to dodajemy
% do listy L2
split(IN, OUT1, OUT2, Counter) :-
	freeze(IN,
			(	IN = [H | T]
			->	(	Counter = 0
				->	OUT1 = [H | OUT1_],
					NewCounter1 is Counter + 1,
					NewCounter is NewCounter1 mod 2,
					split(T, OUT1_, OUT2, NewCounter)
				;	OUT2 = [H | OUT2_],
					NewCounter1 is Counter + 1,
					NewCounter is NewCounter1 mod 2,
					split(T, OUT1, OUT2_, NewCounter))
			;	OUT1 = [],
				OUT2 = [])).
