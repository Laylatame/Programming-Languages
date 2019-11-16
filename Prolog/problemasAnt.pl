% Problema 1
padece(pedro, gripe).
padece(pedro, hepatitis).
padece(juan, hepatitis).
padece(maria, gripe).
padece(carlos, intoxicacion).
sintoma(fiebre, gripe).
sintoma(cansancio, hepatitis).
sintoma(diarrea, intoxicacion).
sintoma(cansancio, gripe).
suprime(aspirina, fiebre).
suprime(lomotil, diarrea).
alivia(X, Y):- sintoma(S, Y), suprime(X, S).
tomar(P, X):- padece(P, Y), alivia(X, Y).
padeceSintoma(P, S):- padece(P, X), sintoma(S, X).
comparten(P1, P2, S):- padeceSintoma(P1, S), padeceSintoma(P2, S).

% Queries
% a) ¿Podemos conocer qué dolencia tiene Pedro? ¿Y María?
% padece(pedro,D).
% D = gripe
% D = hepatitis.
% padece(maria,D).
% D = gripe.

% b) ¿Quién padece gripe?
% padece(Q,gripe).
% Q = pedro
% Q = maria.

% c) ¿Qué síntomas tiene Pedro?
% Por separado
% sintoma(S, gripe).
% S = fiebre
% S = cansancio.
% sintoma(S, hepatitis).
% S = cansancio.

% Con nueva regla
% padeceSintoma(pedro, S).
% S = fiebre ;
% S = cansancio ;
% S = cansancio.

% d) ¿Quién padece diarrea?
% padeceSintoma(Q, diarrea).
% Q = carlos.

% e) ¿Y quién está cansado?
% padeceSintoma(Q, cansancio).
% Q = pedro ;
% Q = pedro ;
% Q = juan ;
% Q = maria.

% f) ¿Hay algún fármaco que alivie a Pedro?
% tomar(pedro, F).
% F = aspirina.

% g) ¿Hay algún síntoma que compartan Juan y María?
% comparten(juan, maria, S).
% S = cansancio.


% Problema 2
% 2. Implementar el predicado intersectan en Prolog que verifique si
% dos listas planas pasadas como sus argumentos tienen elementos en común.
% Probar con:
%      ?- intersectan([a,b,c],[d,f,a])     => yes
%      ?- intersectan([1,2,b],[a,3,c,d,4]) => no
member(X, [Y|T]) :- X = Y; member(X, T).
intersectan([X|Y],[W|Z]):- member(X, [W|Z]), !.
intersectan([X|Y],[W|Z]):- member(W, [X|Y]), !.
intersectan([X|Y],[W|Z]):- intersectan(Y,Z).


% Problema 3
% rango utiliza una función auxiliar para agregar los valores a la lista a la lista
rango(N, M, R):- auxRango(N, M, [], R).
auxRango(N, M, L, R):- N =:= M, append(L, [N], D), =(R, D), !.
auxRango(N, M, L, R):- N =\= M, append(L, [N], D), N1 is N+1, auxRango(N1, M, D, R).

% Problema 4
% Programa que hace el producto cartesiano de dos listas
cartesiano(L1, L2, R):- auxCartesiano(L1, L2, [], R).
auxCartesiano([], _, P, R):- =(R, P), !.
auxCartesiano(_, [], P, R):- =(R, P), !.
auxCartesiano([X|Y], L2, P, R):- agrega(X, L2, [], D), append(P, D, L),auxCartesiano(Y, L2, L, R).
% funcion auxiliar que hace el producto de un atomo con todos los elementos de una listima
agrega(N, [], D, L):-  =(L, D), !.
agrega(N, [X|Y], D, L):- append(D, [[N,X]], R), agrega(N, Y, R, L).


% Problema 5
% programa que cuenta las veces que aparece un número en una lista imbricada
cuenta_profundo(N,L,R):- auxCuenta(N, L, 0, R).
% función auxiliar que cunado el primer elemento de la lista es igual a N suma 1 al contador
% si el primer elemento es otra lista entonces llama a la función con ese elemento y con el resto
auxCuenta(N, [], M, R):- R is M, !.
auxCuenta(N, [X|Y], M, R):- N == X, M1 is M+1, auxCuenta(N, Y, M1, R), !.
auxCuenta(N, [[X|Y]|Z], M, R):- auxCuenta(N, [X|Y], M, L), auxCuenta(N, Z, L, R), !.
auxCuenta(N, [X|Y], M, R):- auxCuenta(N, Y, M, R).


% 6. (10 puntos) Implementar el predicado tabla en Prolog que obtenga la tabla
% de multiplicar de un número, como una lista de pares, donde el primer elemento
% del par contiene los multiplicandos y el segundo el producto
% Probar con:

% ?- tabla(1,R) => R = [ [[1,1],1] ,[[1,2],2] ... [[1,10],10]]
% ?- tabla(4,R) => R = [[[4,1],4],[[4,2],8] ... [[4,10],40]]
tabla(N, R):- auxTabla(1, N, [], R).
auxTabla(N, M, L, R):- N =:= 10, NM is N*M, append(L, [[[M,N], NM]], D), =(R, D), !.
auxTabla(N, M, L, R):- N =\= 10, NM is N*M, append(L, [[[M,N], NM]], D), N1 is N+1, auxTabla(N1, M, D, R).


% 7. Implementar el predicado lista_unicos en Prolog que obtenga una
% lista con los elementos que no aparecen repetidos dentro de una lista imbricada.
% Problema 7
% hace una lista con los elementos únicos en una lista
lista_unicos(L, R) :- auxLista_unicos(L, [], [], R).
% si es lista mandas llamar auxLista_unicos(Y, L, R).
% si es atomo metes a la lista
member(X, [[W|Y]|T]) :- member(X, [W|Y]), !.
member(X, [[W|Y]|T]) :- member(X, T), !.
member(X, [Y|T]) :- X = Y; member(X, T).
auxLista_unicos([], U, E, R):- =(R, U), !.

auxLista_unicos([[X|Y]|Z], U, E, R):- auxLista_unicos([X|Y], U, E, D), auxLista_unicos(Z, D, E, R), !.
auxLista_unicos([X|Y], U, E, R):- member(X, E), !, auxLista_unicos(Y, U, E, R).
auxLista_unicos([X|Y], U, E, R):- member(X, Y), !, append(E, [X], D), auxLista_unicos(Y, U, D, R).
auxLista_unicos([X|Y], U, E, R):- append(U, [X], L), auxLista_unicos(Y, L, E, R).


%8 mayores
% umbral
mayores(_,nil,[]):-!.
mayores(X,arbol(Raiz,L,R), [Raiz|L]):- X < Raiz, mayores(X,L,W), mayores(X,R,Z), append(W,Z,Li).
mayores(X,arbol(_,L,D), L):- mayores(X,L,W), mayores(X,R,Z),!,append(W,Z,Li).


% 9
% Agrega a arbol
siembraAux(X, nil, arbol(X,nil,nil)).
siembraAux(X, arbol(Raiz,L,R), arbol(Raiz,L1,R)) :- X @< Raiz, siembraAux(X,L,L1).
siembraAux(X,arbol(Raiz,L,R),arbol(Raiz,L,R1)) :- X @> Raiz, siembraAux(X,R,R1).

% Funcion siembra que construye arbol
siembra(L,A) :- siembra(L,A,nil).
siembra([],A,A).
siembra([X|Y],A,A0) :- siembraAux(X,A0,A1), siembra(Y,A,A1).