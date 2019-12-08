%% @author laylatame
%% @doc @todo Add description to notes.


-module(notes).

%% ====================================================================
%% API functions
%% ====================================================================
-export([hello_world/0, add/3]).

hello_world() -> io:fwrite("hello world\n").



%% ====================================================================
%% Internal functions
%% ====================================================================


add(A, B, C) -> 
	D = A + B,
	E = D * C,
	hello_world(),
	E * 10.
