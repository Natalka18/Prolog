% S - strumień wejściowy, X - lista tokenów ze strumienia S
% jeśli strumień znaków S zawiera tokeny niewystępujące
% w gramatyce, to scanner(S, X) jest false
scanner(S, X) :-
	get_char(S, C),
	czytaj_dalej(S, C, X),
	!.

% S - strumień wejściowy
czytaj_dalej(_, end_of_file, []) :-
	!.
czytaj_dalej(S, C1, X) :-
	bialy(C1),
	!,
	get_char(S, C2),
	czytaj_dalej(S, C2, X).
czytaj_dalej(S, C1, [Token | T]) :-
	lower_case_letter(C1),
	czytaj_slowo_kluczowe(S, C1, C2, '', H),
	!,
	key(H),
	atom_concat('key(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	czytaj_dalej(S, C2, T).
czytaj_dalej(S, C1, [Token | T]) :-
	int(C1),
	czytaj_liczbe(S, C1, C2, '', H),
	!,
	int(H),
	atom_concat('int(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	czytaj_dalej(S, C2, T).
czytaj_dalej(S, C1, [Token | T]) :-
	id(C1),
	czytaj_id(S, C1, C2, '', H),
	!,
	id(H),
	atom_concat('id(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	czytaj_dalej(S, C2, T).
czytaj_dalej(S, C1, [Token | T]) :-
	sep_elem(C1),
	czytaj_sep(S, C1, C2, '', H),
	!,
	sep(H),
	atom_concat('sep(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	czytaj_dalej(S, C2, T).
	
czytaj_slowo_kluczowe(_, end_of_file, end_of_file, N, N) :-
	!.
czytaj_slowo_kluczowe(_, C, C, N, N) :-
	\+ lower_case_letter(C),
	!.
czytaj_slowo_kluczowe(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	czytaj_slowo_kluczowe(S, C2, C3, N2, N).
	
czytaj_liczbe(_, end_of_file, end_of_file, N, N) :-
	!.
czytaj_liczbe(_, C, C, N, N) :-
	\+ int(C),
	!.
czytaj_liczbe(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	czytaj_liczbe(S, C2, C3, N2, N).
	
czytaj_liczbe(_, end_of_file, end_of_file, N, N) :-
	!.
czytaj_liczbe(_, C, C, N, N) :-
	\+ int(C),
	!.
czytaj_liczbe(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	czytaj_liczbe(S, C2, C3, N2, N).
	
czytaj_id(_, end_of_file, end_of_file, N, N) :-
	!.
czytaj_id(_, C, C, N, N) :-
	\+ id(C),
	!.
czytaj_id(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	czytaj_id(S, C2, C3, N2, N).
	
czytaj_sep(_, end_of_file, end_of_file, N, N) :-
	!.
czytaj_sep(_, C, C, N, N) :-
	\+ sep_elem(C),
	!.
czytaj_sep(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	czytaj_sep(S, C2, C3, N2, N).

bialy(' ').
bialy('\t').
bialy('\n').

key('read').
key('write').
key('if').
key('then').
key('else').
key('fi').
key('while').
key('do').
key('od').
key('and').
key('or').
key('mod').

int('0') :-
	!.
int(C) :-
	atom_number(C, N),
	M is N - 1,
	atom_number(StringM, M),
	int(StringM).
	
id(Letter) :-
	string_length(Letter, 1),
	char_type(Letter, upper), !.
id(ID) :-
	get_string_code(1, ID, FirstCode),
	char_type(FirstCode, upper),
	atom_concat(FirstChar, Rest, ID),
	string_length(FirstChar, 1),
	id(Rest), !.
	
sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

sep_elem(C) :-
	sep(C).
sep_elem(':').

lower_case_letter(Letter) :-
	string_length(Letter, 1),
	char_type(Letter, lower), !.
