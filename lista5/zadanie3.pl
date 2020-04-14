browse(Term) :-
	write_term(Term),
	read_command(Command),
	execute(Command, Term, []).
	
% Path - ścieżka od danego wierzchołka do korzenia,
% pierwszy element tej listy jest ojcem aktualnie
% odwiedzanego wierzchołka
execute('i', Term, Path) :-
	Term =.. [_, FirstChild | _],
	!,
	write_term(FirstChild),
	read_command(Command),
	append([Term], Path, NewPath),
	execute(Command, FirstChild, NewPath).
execute('i', Term, Path) :-
	write_term(Term),
	read_command(Command),
	execute(Command, Term, Path).
execute('o', Term, []) :-
	write_term(Term).
execute('o', _, [Parent | Path]) :-
	write_term(Parent),
	read_command(Command),
	execute(Command, Parent, Path).
execute('n', Term, []) :-
	write_term(Term),
	read_command(Command),
	execute(Command, Term, []).
execute('n', Term, [Parent | Path]) :-
	Parent =.. [_ | Children],
	append(_, [Term | []], Children),
	!,
	write_term(Term),
	read_command(Command),
	execute(Command, Term, [Parent | Path]).
execute('n', Term, [Parent | Path]) :-
	Parent =.. [_ | Children],
	append(_, [Term | L2], Children),
	L2 = [NextSibling | _],
	write_term(NextSibling),
	read_command(Command),
	execute(Command, NextSibling, [Parent | Path]).
execute('p', Term, [Parent | Path]) :-
	Parent =.. [_ | Children],
	Children = [Term | _],
	!,
	write_term(Term),
	read_command(Command),
	execute(Command, Term, [Parent | Path]).
execute('p', Term, [Parent | Path]) :-
	Parent =.. [_ | Children],
	append(L1, [Term | _], Children),
	append(_, [PreviousSibling], L1),
	write_term(PreviousSibling),
	read_command(Command),
	execute(Command, PreviousSibling, [Parent | Path]).

read_command(Command) :-
	write('command: '),
	read(Command).
	
write_term(Term) :-
	write(Term),
	write('\n').
