% fakty

left_of(bicycle, camera).
left_of(pencil, hourglass).
left_of(hourglass, butterfly).
left_of(butterfly, fish).

above(bicycle, pencil).
above(camera, butterfly).

% reguły

right_of(A,B) :-
	left_of(B,A).
	
below(A,B) :-
	above(B,A).
	
% reguły rekurencyjne dla left_of i above

left_of_indirect(A,B) :-
	left_of(A,B);
	(left_of(A,Z), left_of_indirect(Z,B)).
	
above_indirect(A,B) :-
	above(A,B);
	(above(A,Z), above_indirect(Z,B)).
	
	
% definicja higher

higher(A,B) :- 
	above_indirect(A,B).
	
higher(A,B) :-
	left_of_indirect(Z,B), above_indirect(A,Z).
	
higher(A,B) :-
	left_of_indirect(B,Z), above_indirect(A,Z).