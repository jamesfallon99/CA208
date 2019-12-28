/* FACTS *//* FACTS */

parents(david, george, noreen).
parents(jennifer, george, noreen).
parents(georgejr, george, noreen).
parents(scott, george, noreen).
parents(joanne, george, noreen).
parents(jessica, david, edel).
parents(clara, david, edel).
parents(michael, david, edel).
parents(laura, georgejr, susan).
parents(anna, scott, siobhan).


/* Relationships */

father(X, Y) :- parents(Y, X, _).
male(X) :- father(X, _).

mother(X, Y) :- parents(Y, _, X).
female(X) :- mother(X, _).

grandfather(X, Y) :- father(X, Z), father(Z, Y).
grandfather(X, Y) :- father(X, Z), mother(Z, Y).

grandmother(X, Y) :- mother(X, Z), mother(Z, Y).
grandmother(X, Y) :- mother(X, Z), father(Z, Y).

brother(X, Y) :- male(X), father(Z, X), father(Z, Y).

sister(X, Y) :- female(X), father(Z, X), father(Z, Y).

uncle(X, Y) :- male(X), brother(X, Z), father(Z, Y).
uncle(X, Y) :- male(X), brother(X, Z), mother(Z, Y).

aunt(X, Y) :-female(X), sister(X, Z), father(Z, Y).
aunt(X, Y) :-female(X), sister(X, Z), mother(Z, Y).
married(X, Y) :- father(X, Z), mother(Y, Z).

sibling(X, Y):- brother(X, Y), sister(X, Y).
sibling(X, Y):- brother(X, Y), brother(X, Y).
sibling(X, Y):- sister(X, Y), sister(X, Y).



cousin(X, Y) :- not(sibling(X, Y)), grandfather(Z, Y), grandfather(Z, X).

