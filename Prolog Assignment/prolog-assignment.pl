route(dublin, cork, 200, 'fct').
route(cork, dublin, 200, 'fct').
route(cork, corkAirport, 20, 'fc').
route(corkAirport, cork, 25, 'fc').
route(dublin, dublinAirport, 10, 'fc').
route(dublinAirport, dublin, 20, 'fc').
route(dublinAirport, corkAirport, 225, 'p').
route(corkAirport, dublinAirport, 225, 'p').

/*S = Source
  D = Destination
  M = Modes
  List = List of passed locations
  Length = Distance
  X = Speed
  T = Time
  L = List of times
  Result = Quickest time in list of times*/


journey(S,D,M,List,Length,X,T,L,Result):-quickest_journey(S,D,List,Length,X,T,L,Result).
/*e.g. journey(dublin,cork,'fct',List,_,_,_,_,X).
       X = 2 */

quickest_journey(S,D,List,Length,X,T,L,Result):-
    list_of_times(S,D,List,Length,X,T,L), min_list(L,Result).
/*e.g. quickest_journey(dublin,cork,List,_,_,_,_,X).
       X = 2 */

min_list([X],X).
/*Base case, if X is the only element in the list, then X is the minimum of the list*/

min_list([H|T],X) :-
min_list(T,X1), (H =< X1,X is H; H > X1, X is X1).
/*Recursively call min_list with Tail(T) and value(X1),
  if H is less than X1, X1 is H, else it is the same. */



list_of_times(S,D,List,L,X,T,L):-findall(T,(time(S,D,List,L,X,T)),L).
/*e.g. list_of_times(dublin,cork,List,_,_,_,L).
       L = [40, 2.5, 2].*/


findall(T,(time(S,D,List,L,X,T)),L).
/*Finds all values for Time(T) and stores them in a list(L).
  e.g. findall(T,(time(dublin, cork, L, 200, X, Z)),Results).
  Results = [40, 2.5, 2] */

time(S,D,List,L,X,T) :- get_speed(S,D,List,L,X), T is L / X.
/*This predicate returns the time(T) of the journey by dividing the distance(L) by the speed(X). e.g. time(dublin, cork, List, Distance, Speed, Time).
   Distance = 200,
   Speed = 5,
   Time = 40;
   Distance = 200,
   Speed = 80,
   Time = 2.5;
   Distance = 200,
   Speed = 100,
   Time = 2 */

get_speed(S,D,List,L,X):-get_foot_speed(S,D,List,L,X); get_car_speed(S,D,List,L,X); get_train_speed(S,D,List,L,X); get_plane_speed(S,D,List,L,X).
/*This returns the foot speed(X)/car speed (X)/train speed(X)/plane speed(X) e.g.get_time(dublin, cork, List, 200, X).
  X = 5;
  X = 80;
  X = 100*/

get_foot_speed(S,D,List,L,X):- foot(X), get_distance_and_character(S,D,List,L,f).
/*If f is the character in "get_distance_and_character", X will then be the speed of f.
  e.g. get_foot_speed(dublin, cork, List, 200, X).
  X = 5 */

get_car_speed(S,D,List,L,X):-car(X), get_distance_and_character(S,D,List,L,c).
/*If c is the character in "get_distance_and_character", X will then be the speed of c.
 e.g. get_car_speed(dublin, cork, List, 200, X).
 X = 80 */

get_train_speed(S,D,List,L,X):-train(X), get_distance_and_character(S,D,List,L,t).
/*If t is the character in "get_distance_and_character", X will then be the speed of t.
 e.g.get_train_speed(dublin, cork, List, 200, X).
 X = 100 */

get_plane_speed(S,D,List,L,X):-plane(X), get_distance_and_character(S,D,List,L,p).
/*If p is the character in "get_distance_and_character", X will then be the speed of p.
 e.g.get_plane_speed(dublinAirport, corkAirport, List, 225, X).
 X = 500.*/


get_distance_and_character(S,D,List,L,X):- in_my_list_of_elements(S,D,List,L,X).
/*L is the Length(distance) and X is the character
 e.g.get_distance_and_character(dublin, cork, List, L, X).
 L = 200,
 X = f ;
 L = 200,
 X = c ;
 L = 200,
 X = t ;*/


foot(X):- X is 5. /*foot speed is 5km/h */
car(X):- X is 80. /*car speed is 80km/h */
train(X):- X is 100. /*train speed is 100km/h */
plane(X):- X is 500. /*plane speed is 500km/h */



in_my_list_of_elements(S,D,List,L,Character) :-
    list_of_my_elements(S,D,List,L,M),
    member(Character, M).

list_of_my_elements(S,D,List,L,M):- path_with_list_of_modes(S,D,List,L,M).


/*When you call the "in_my_list_of_elements" predicate and sub in the values for
  S(source),D(destination),List,L(Length),M(modes)
  this will get the associated list(M) of Modes e.g.[f,c,t].
  This predicate will then allow you to see what element is in the list. Sub in the value
  for Character to see if it is in the list(M).*/



path_with_list_of_modes(Source, Dest, List, Length, M) :-
   route_containing_list_of_modes(Source, Dest, [Source], Length, M).
/*  path_with_list_of_modes(dublin,dublinAirport,List,10,X).
    X = [f, c].*/

route_containing_list_of_modes(Source, Dest, Passed_locations, L, Modes):-
   from_string_to_list_of_modes(Source, Dest, Passed_locations, L, Modes).
/* route_containing_list_of_modes(dublin,cork,List,200,X).
   X = [f, c, t]

   Passed_locations contains all the locations from source and puts them in a list.*/

from_string_to_list_of_modes(Source, Dest, Passed_locations, L, Modes):-
   route(Source, Dest, L, S),string_to_list_of_characters(S, Modes).
   /*from_string_to_list_of_modes(dublin, cork, List,200, X).
     X = [f, c, t]*/




string_to_list_of_characters(String, Characters) :-
    name(String, Number), /*"name" gives the number value for each character entered in the     string. e.g.
    name('fct',X).
    X = [102, 99, 116]*/

    maplist(number_to_character,
       Number, Characters). /*"maplist" Maps the number to the character*/

number_to_character(Number, Character) :-
    name(Character, [Number]). /*This gets the number equivalent of the characters inputted*/

/*"string_to_list_of_characters" changes a string into a list containing those characters in the string. It uses the predicates "name", "maplist" and "number_to_character"
 string_to_list_of_characters('fct', X).
 X = [f, c, t].*/
