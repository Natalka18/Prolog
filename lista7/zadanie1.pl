merge(IN1, IN2, OUT) :-
	when((nonvar(IN1), nonvar(IN2)), 
		(	(IN1 = [H1 | T1], IN2 = [H2 | T2])
		->	(	(H1 < H2)
			->	OUT = [H1 | OUT2],
				merge(T1, IN2, OUT2)
			;	OUT = [H2 | OUT2],
				merge(IN1, T2, OUT2)
		)
		;	(	IN1 = [H1 | T1]
			->	OUT = IN1
			;	(	IN2 = [H2 | T2]
				->	OUT = IN2
				;	OUT = []
			)
		)
		)
	).
	