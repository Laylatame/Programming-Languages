import string
import sys
from enum import IntEnum
from anytree import Node, RenderTree


#AEF - tokens

class Symbol(IntEnum):
    parenAbierto = 0
    parenCerrado = 1
    function = 2
    operator = 3
    Params = 4
    Param = 5
    boolV = 6
    listV = 7
    ERR = 200



charset_symbol = {
    Symbol.parenAbierto: ['('],
    Symbol.parenCerrado: [')'],
    Symbol.function: ['OP', 'ID'],
    Symbol.operator ['+', '-', '*', '/', '%'],
    Symbol.Params: ['PARAM', 'PARAMS'],
    Symbol.Param: ['EXP', 'ID', 'INT', 'BOOL', 'LIST'],
    Symbol.boolV: ['#t', '#f']
}

ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

class State(IntEnum):
    Zero = 0
    One = 1     # Identificadores
    Two = 2     # Literales Enteras
    Three = 3   # Operadores
    Four = 4    # Parentesis Abierto
    Five = 5    # Parentesis Cerrado
    Six = 6
    Error = 6


class Action(IntEnum):
    Shift = 0
    Reduce = 1
    Dispose = 2


#Investigar que hacer aqui???

# Inicializar con errores
rows = range(len(State))
cols = range(len(Symbol))
tt = [[(State.Error, Action.Dispose) for col in cols] for row in rows]

# Estado 0 - Comiendo espacios en blanco
tt[State.Zero][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Zero][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Zero][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Zero][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Zero][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Zero][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Zero][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 1 - Reconociendo identificadores
tt[State.One][Symbol.Param] = (State.One, Action.Dispose)
tt[State.One][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.One][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.One][Symbol.function] = (State.Three, Action.Dispose)
tt[State.One][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.One][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 2 - Reconociendo literales enteras
tt[State.Two][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Two][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Two][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Two][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Two][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Two][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Two][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 3 - Reconociendo operadores
tt[State.Three][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Three][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Three][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Three][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Three][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Three][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Three][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 4 - Reconociendo parentesis abierto
tt[State.Four][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Four][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Four][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Four][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Four][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Four][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Four][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 5 - Reconociendo parentesis cerrado
tt[State.Five][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Five][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Five][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Five][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Five][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Five][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Five][Symbol.boolV] = (State.Six Action.Dispose)

# Estado 6 - 
tt[State.Six][Symbol.Param] = (State.One, Action.Dispose)
tt[State.Six][Symbol.Params] = (State.Two, Action.Dispose)
tt[State.Six][Symbol.operator] = (State.Zero, Action.Dispose)
tt[State.Six][Symbol.function] = (State.Three, Action.Dispose)
tt[State.Six][Symbol.parenAbierto] = (State.Four, Action.Dispose)
tt[State.Six][Symbol.parenCerrado] = (State.Five, Action.Dispose)
tt[State.Six][Symbol.boolV] = (State.Six Action.Dispose)


def filtro(c):
    if c == '0' or c == '1' or c == '2' or \
       c == '3' or c == '4' or c == '5' or \
       c == '6' or c == '7' or c == '8' or c == '9': # dígitos
        return 0
    elif c in Symbol.operator #== '+' or c == '–' or c == '%' or c == '*' or c == '/': # operadores
        return 1
    elif c == '(': # delimitador (
        return 2
    elif c == ')': # delimitador )
        return 3
    elif c == ' ' or ord(c) == 9 or ord(c) == 10 or ord(c) == 13: # blancos
        return 5
    elif c in Symbol.function #== 'OP' or c == 'ID'
        return 6
    elif c == 'PARAM' or 'PARAMS'
        return 7
    elif c == 'EXP' or c in ALPHABET or c in Symbol.boolV
        return 8
    else: # caracter raro
        return 4



def scanner():
    edo = 0 # número de estado en el autómata
    lexema = "" # palabra que genera el token
    tokens = []
    leer = True # indica si se requiere leer un caracter de la entrada estándar
    while (True):
        while edo < 100: # mientras el estado no sea ACEPTOR ni ERROR
            if leer: c = sys.stdin.read(1)
            else: leer = True
            edo = MT[edo][filtro(c)]
            if edo < 100 and edo != 0: lexema += c
        if edo == Param:
            leer = False # ya se leyó el siguiente caracter
            print( "Parametro" , lexema)
        elif edo == Params:
            leer = False # ya se leyó el siguiente caracter
            print( "Params" , lexema)
        elif edo == operator:
            lexema += c # el último caracter forma el lexema
            print( "Operador" , lexema)
        elif edo == parenAbierto:
            lexema += c # el último caracter forma el lexema
            print( "EXP" , lexema)
        elif edo == parenCerrado:
            lexema += c # el último caracter forma el lexema
            print( "EXP" , lexema)
        elif edo == function
            lexema += c
            print("FUN" , lexema)
        elif edo == boolV
            lexema += c
            print("Bool", lexema)
        elif edo == listV
            lexema += c
            print("Lista" , lexema)
        elif edo == ERR:
            leer = False # el último caracter no es raro
            print( "ERROR! palabra ilegal“ , lexema)
    tokens.append(edo)
    if edo == END: return tokens
    lexema = ""
    edo = 0