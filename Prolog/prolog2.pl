% Continuación de listas y recursividad en Prolog
% Algunas funciones interesantes: member, length, append, nth1

% 0. Remover duplicados de una lista usando un auxiliar


% 1. Remover duplicados de una lista sin auxiliar

remover([], []). %si es vacia
remover([H | T], R) :- member(H, T), remover(T, R), !. %si es member
remover([H | T], [X | R]) :- remover(T, R). %si no se cumplen ninguna de las anteriores

%remover([1,2,3,4,4,4,5,5,5], R).

% 2. Intersección

intersec([], _, []). % el _ significa que es una variable que no me importa, algo que no voy a utilizar
intersec([H | T], L, R) :- member(H, L), !, intersec(T, L, R) !. %checar si la cabeza de la primera lista esta en la segunda
intersec([_ | T], L, R) :- intersec(T, L, R).

% L1 = [1,2,3], L2 = [3,4,5], R = [3]

% 3. Append (anexa)

anexa([], L2, L2).
anexa([H | T], L, [H | R]) :- anexa(T, L, R).

%anexa(L1, L2, R).

% 4. Particiona

particiona(_, [], [], []).
particiona(P, [H | T], [H | Men], May) :- H =< P, particiona(P, T, Men, May), !. %mandar pivote, resto de la lista, menor y mayor
particiona(P, [H | T], Men, [H | May]) :- particiona (P, T, Men, May).

%particiona(P, L, Men, May).


% 5. qsort

qsort([], []).
qsort([H | T], R) :- particiona(H, T, Men, May), 
    qsort(Men, Men0), 
    qsort(May, May0), 
    anexa(Men0, [H | May0], R), !.

%qsort([4,5,7,8,9,10,11,1], R).

% Árboles
% arbol(6, arbol(4, vacio, vacio), arbol(8, vacio, 10)) ?

% 6. cuentaNodos

cuentaN(vacio, 0).
cuentaN(Arbol(_, Izq, Der), N) :- 
    cuentaN(Izq, CountIzq),
    cuentaN(Der, CountDer),
    N is 1 + CountIzq + CountDer.

%cuentaN(vacio, R).
%cuentaN(arbol(5, arbol(3, 1, 4), arbol(8, 6, 10)), R).
%cuentaN(arbol(5, vacio, vacio), R).
%cuentaN(arbol(5, arbol(2, vacio, 1), vacio), R).
%cuentaN(arbol(5, arbol(2, vacio, arbol(1, vacio, vacio)), vacio)).

% 7. miembroArbol




% 8. preorden



% Acertijos lógicos

/*
Israel’s population is smaller than Japan’s. Philippines is more crowded than
Japan. The population is England is smaller than Israel’s, but larger than
Cuba.
*/

% before(X, Y, L) :- 
% after(X, Y, L) :- 

/*
solve(Solution) :-
    length(Solution, 5),
    member(israel, Solution),
    member(japan, Solution),
    member(philippines, Solution),
    member(england, Solution),
    member(cuba, Solution),
    before(israel, japan, Solution),
    before(japan, philippines, Solution),
    before(england, israel, Solution),
    before(cuba, england, Solution), !.
*/

/*
Coloreo de vértices de un grafo
*/
% (a,b), (b,c), (a,d), (c,d), (b,d)

/*
solveColors(A, B, C, D) :- 
    L = [azul, rojo, amarillo],
    member(A, L),
    member(B, L),
    member(C, L),
    member(D, L),
    A \= B,
    A \= D,
    B \= C,
    B \= D,
    C \= D.
*/

/*
Einsten's riddle

There are 5 houses in five different colors.
In each house lives a person with a different nationality.
These five owners drink a certain type of beverage, smoke a certain
brand of cigar and keep a certain pet.
No owners have the same pet, smoke the same brand of cigar or drink
the same beverage.

The Brit lives in the red house.
The Swede keeps dogs as pets.
The Dane drinks tea.
The green house is on the left of the white house.
The green house’s owner drinks coffee.
The person who smokes Pall Mall rears birds.
The owner of the yellow house smokes Dunhill.
The man living in the center house drinks milk.
The Norwegian lives in the first house.
The man who smokes blends lives next to the one who keeps cats.
The man who keeps horses lives next to the man who smokes Dunhill.
The owner who smokes BlueMaster drinks beer.
The German smokes Prince.
The Norwegian lives next to the blue house.
The man who smokes blend has a neighbor who drinks water.
*/

% right(X, Y, L) :-
% next(X, Y, L) :-

/*
solveEinstein(Solution) :-
    length(Solution, 5),
    member([red, _, _, _, englishman], Solution),
    member([_, dogs, _, _, sweede], Solution),
    member([_, _, tea, _, dane], Solution),
    right([green, _, _, _, _], [white, _, _, _, _], Solution),
    member([green, _, coffee, _, _], Solution),
    member([_, birds, _, pallmall, _], Solution),
    member([yellow, _, _, dunhills, _], Solution),
    Solution = [_, _, [_, _, milk, _, _], _, _],
    Solution = [[_, _, _, _, norwegian], _, _, _, _],
    next([_, cats, _, _, _], [_, _, _, blend, _], Solution),
    member([_, _, beer, bluemaesters, _], Solution),
    next([_, _, _, dunhills, _], [_, horses, _, _, _], Solution),
    member([_, _, _, prince, german], Solution),
    next([_, _, _, _, norwegian], [blue, _, _, _, _], Solution),
    next([_, _, water, _, _], [_, _, _, blend, _], Solution),
    member([_, fish, _, _, _], Solution), !.



print([]) :- !.
print([[Color, Pet, Drink, Cigar, Nationality]|T]) :-
    write("The "), write(Nationality), write(" lives in the "), 
    write(Color),
    write(" house, has "), write(Pet), write(", drinks "), write(Drink),
    write(" and smokes "), write(Cigar), write("."), print(T).
*/