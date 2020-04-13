browse(Term) :-
	write_term(Term),
	read_command(Command),
	execute(Command, Term, []).
	
% Path - ścieżka od danego wierzchołka do korzenia,
% pierwszy element tej listy jest ojcem aktualnie
% odwiedzanego wierzchołka
execute('i', Term, Path) :-
	Term =.. [Functor, FirstChild | L],
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
execute('o', Term, [Parent | Path]) :-
	write_term(Parent),
	read_command(Command),
	execute(Command, Parent, Path).
execute('n', Term, []) :-
	write_term(Term),
	read_command(Command),
	execute(Command, Term, []).
execute('n', Term, [Parent | Path]) :-
	Parent =.. [Functor | Children],
	append(L1, [Term | []], Children),
	!,
	write_term(Term),
	read_command(Command),
	execute(Command, Term, [Parent | Path]).
execute('n', Term, [Parent | Path]) :-
	Parent =.. [Functor | Children],
	append(L1, [Term | L2], Children),
	L2 = [NextSibling | Rest],
	write_term(NextSibling),
	read_command(Command),
	execute(Command, NextSibling, [Parent | Path]).
%execute('p'

read_command(Command) :-
	write('command: '),
	read(Command).
	
write_term(Term) :-
	write(Term),
	write('\n').
