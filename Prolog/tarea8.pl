%Tarea 8. Prolog
%Layla Tame A01192934

% 1. Elemento K
% Escribe una regla que recibe una variable K, una lista y una variable X.

elementK(K, L, X):- auxElement(K, L, 0, X).
auxElement(K, [X | _], C, X):- K =:= C, !.
auxElement(K, [_ | R], C, X):- C1 is C+1, auxElement(K, R, C1, X).

%elementK(2, [1,2,3,4,5], X).
%elementK(4, [9,8,7,6,5,4,3,2], X).


% 2. Rango
% Escribe una regla que recibe una variable S y una F y genera una lista L con el rango de números entre S y F.

rango(S, F, R):- auxRango(S, F, [], R).
auxRango(S, F, L, R):- S =:= F, append(L, [S], D), =(R, D), !.
auxRango(S, F, L, R):- S =\= F, append(L, [S], D), S1 is S+1, auxRango(S1, F, D, R).

%rango(5, 9, L).
%rango(1, 8, L).


% 3. Duplica D
% Escribe una regla que recibe una lista L, una variable numérica D y regresa una lista con cada uno de 
% los elementos de L duplicados D veces. 

duplicaD(L, D, R):- auxDuplica(L, D, [], R).

auxDuplica([], _, L, L).
auxDuplica([E | []], D, L, R):- addElem(L, D, 0, E, R), !.
auxDuplica([E | RE], D, L, R):- addElem(L, D, 0, E, X), auxDuplica(RE, D, X, R).

addElem(L, D, C, _, R):- D =:= C, =(R, L), !.
addElem(L, D, C, E, R):- D =\= C, append(L, [E], X), C1 is C+1, addElem(X, D, C1, E, R).

%duplicaD([a,b,c,d,e], 4, L).
%duplicaD([1,2,3,4,5], 2, L).

% 4. Intercala
% Escribe una regla que intercale dos listas L1 y L2 en L.

intercala(L1, L2, L):-  intercalaAux(L1, L2, [], L).
intercalaAux([], [], L, L).
intercalaAux([], L2, L, R):- append(L, L2, D), =(R, D), !.
intercalaAux(L1, [], L, R):- append(L, L1, D), =(R, D), !.
intercalaAux([H1 | []], [H2 | []], L, R):- append(L, [H1], D), append(D, [H2], G), =(R, G), !.
intercalaAux([H1 | []], L2, L, R):- append(L, [H1], D), append(D, [L2], G), =(R, G), !.
intercalaAux([H1 | F1], [H2 | []], L, R):- append(L, [H1], D), append(D, [H2], G), append(G, [F1], A), =(R, A), !.
intercalaAux([H1 | F1], [H2 | F2], L, R):- append(L, [H1], D), append(D, [H2], G), intercalaAux(F1, F2, G, R).

%intercala([1,3,5], [2,4,6], L).
%intercala([c, f, e], [sharp, sharp, flat], L).