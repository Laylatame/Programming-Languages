parent(cronus, hestia).
parent(cronus, demeter).
parent(cronus, poseidon).
parent(cronus, zeus).
parent(cronus, hades).

parent(zeus, persephone).
parent(zeus, ares).
parent(zeus, hebe).

parent(ares, eros).
parent(ares, harmonia).

parent(harmonia, semele).

parent(semele, dionysus).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
greatgrandparent(X, Y) :- parent(X, Z), grandparent(Z, Y).

/* greatgreatgrandparent ... */

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

/* Observen que da múltiples respuestas a una consulta, la correcta y otra que no es */

factorial(0, 1).
factorial(N, R) :- X is N-1, factorial(X, W), R is N*W.

/* El mismo caso con factorial. Si pedimos todas las posibles soluciones, cae en una recursividad infinita */