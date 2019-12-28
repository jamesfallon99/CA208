myElem(X,[H|T]):- H == X; myElem(X,T).

myHead(X, [H|_]):- H == X.

myLast(X, [X]).
myLast(X, [_|T]):- myLast(X,T).

myTail(X, [_|X]).

myAppend([], L, L).
myAppend([H|T], L, [H|L2]) :- myAppend(T,L,L2).

myReverse([],[]).
myReverse([H|T],R):- myReverse(T,RevT), myAppend(RevT,[H],R).

myDelete(X,[X|T],T).
myDelete(X,[Y|T],[Y|L]):-myDelete(X,T,L).
