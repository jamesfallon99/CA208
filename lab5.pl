class(0,zero):-!.
class(X, positive):- X > 0,!.
class(X, negative):- X < 0,!.

split([],[],[]).
split([H|T],P,N):-member(H,P),H >= 0;member(H,N),H < 0,split(T,P,N).
