import sys
import scanner as scanner

# Empata y obtiene el siguiente token
def match(tokenEsperado):
    global token
    if token == tokenEsperado:
        token = scanner.obten_token()
    else:
        error("token equivocado")

# Funcion principal: implementa el analisis sintactico
def parser():
    global token
    token = scanner.obten_token() # inicializa con el primer token
    exp()
    if token == scanner.END:
        print "Expresion bien construida!!"
    else:
        error("expresion mal terminada")

# Modulo que reconoce expresiones
def exp():
    if token == scanner.INT or token == scanner.FLT:
        match(token) # reconoce Constantes
        exp1()
    elif token == scanner.VAR :
        match(token)
        exp1()
    elif token == scanner.LRP:
        match(token) # reconoce Delimitador (
        exp()
        match(scanner.RRP)
        exp1()
    else:
        error("expresion mal iniciada")

# Modulo auxiliar para reconocimiento de expresiones
def exp1():
    if token == scanner.OPB or token == scanner.COM:
        match(token) # reconoce operador
        exp()
        exp1()
    elif token == scanner.LRP:
        exp()

# Termina con un mensaje de error
def error(mensaje):
    print "ERROR:", mensaje
    sys.exit(1)