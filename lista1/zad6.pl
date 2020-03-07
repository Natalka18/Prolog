is_prime(N) :-
	\+ (Root is floor(sqrt(N)), between(2, Root, X), N mod X =:= 0).
	
prime(LO, HI, N) :-
	between(LO, HI, N),
	is_prime(N).