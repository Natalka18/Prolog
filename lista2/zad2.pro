jednokrotnie(X,[X | L]) :-		% na początku listy jest X, a pozostała jej część nie zawiera X
	\+ member(X,L).
	
jednokrotnie(X,[Y | L]) :-		% dopisujemy znak różny od X na początku listy
	jednokrotnie(X,L),
	Y \= X.
	


dwukrotnie(X,[X | L]) :-		% na początku listy jest X, a pozostała jej część zawiera dokładnie jeden X
	jednokrotnie(X,L).
	
dwukrotnie(X,[Y | L]) :-		% dopisujemy znak różny od X na początku listy
	dwukrotnie(X,L),
	Y \= X.