%% @author laylatame A01192934
%% @doc @todo Add description to erlang_final.


-module(erlang_final).
-export([reverse/1, palindromo/1, print_server/1,palindromo_wrapper/1]).

% Problema 4. Palindromo "concurrente"

% Ejemplo
% PID_PW ! ['l','u','z','a','z','u','l'].
% El resultado es: true


% 1. Escribe una función en erlang que aplique el reverso de una lista

reverse([]) -> [];
reverse([X | XS]) -> reverse(XS) ++ [X].

% 2. Escribe una función que regresa true/false si una lista es palíndromo usando reversa del paso 1.

palindromo(L) -> L =:= reverse(L).

% 3. Escribe una función que imprima en consola cualquier cosa que reciba. print_server/0

print_server(X) -> io:fwrite(X).

% 4. Escribe una función palindromo_wrapper que aplica el palíndromo a cualquier cosa que reciba y le manda el resultado a print_server del paso 3. 

palindromo_wrapper(X) ->
	R = palindromo(X),
	print_server(R).