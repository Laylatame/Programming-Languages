% Problema 3. Elimina NO Repetidos

% Dada una lista con elementos repetidos y no repetidos, hacer 'match' con una lista
% que sólo contenga elementos que se repiten al menos 1 vez. 


%elimina_no_repetidos(L, R):- auxElimina(L, L, [], R).

%count()

% NO PUDE LA HICE EN RACKET

auxElimina([], _, R, R).
auxElimina([E | RE], L, NL, R):- isMember(E, NL, R), auxElimina(RE, L, NL, R).
auxElimina([E | RE], L, NL, R):- isMember(E, RE, R), append(NL, (addElem(E, (count(E, L, C)), [], LI)), D), auxElimina(RE, L, D, R).
append(NL, [E], D), auxElimina() 

count(_, [], 0).
count(Num, [H|T], X) :- Num \= H, count(Num, T, X).
count(Num, [H|T], X) :- Num = H, count(Num, T, X1), X is X1 + 1.


addElem([], X, R, R).
addElem([E | RE], X, R, R):- E =:= X, append(R, [E], D), addElem(RE, X, D, R).
addElem([E | RE], X, R, R):- E =\= X, !.
    
    
isMember(X, [[W|Y]|T]) :- isMember(X, [W|Y]), !.
isMember(X, [[W|Y]|T]) :- isMember(X, T), !.
isMember(X, [Y|T]) :- X = Y; isMember(X, T).




tc0 :- elimina_no_repetidos([1,2,3,4,5], []).
tc1 :- elimina_no_repetidos([1,1,2,3,3,4,5,5,6,7,7,8], [1,1,3,3,5,5,7,7]).
tc2 :- elimina_no_repetidos([], []).
tc3 :- elimina_no_repetidos([1,1,2,2,3,3], [1,1,2,2,3,3]).
tc4 :- elimina_no_repetidos([1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1]).
