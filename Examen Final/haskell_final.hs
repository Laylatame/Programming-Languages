import Data.Char

{-
Layla Tame A01192934

Problema 2. Naive Check

Alguien implementó un parser a medias para la siguiente gramática:

Program     -> Statement+
Statement   -> Expression ;
Expression  -> Expression Op Expression | ( Expression ) | id | num
Op          -> + | - | * | /

Se usó el sistema de tipos de Haskell para encapsular el resultado del parsing.
No obstante, falta realizar las siguientes verificaciones: 

1. El Char usado para representar el operador debe validarse: + | - | * | /
2. La literal entera está representada con un String. Debe validarse que cada caracter sea un número válido.
3. Los paréntesis fueron representados también con Char. Se debe validar que sean ( ) según el caso.
4. Cada estatuto debe terminar en ;, pero se usó un Char libre para esta terminación. Validar.
5. Los identificadores no pueden ser cadenas vacías.

Puedes apoyarte en los casos de prueba, pues verifican la correcta implementación de cada una de las validaciones
antes enumeradas. 

Escribe la función o funciones necesarias para que naiveCheck complemente a este parser incompleto. 

-}

type Program = [Statement]
data Statement = Statement Expression Char
    deriving (Eq, Show)
data Expression = Operation Expression Char Expression | Parenthesis Char Expression Char | Identifier String | IntegerLiteral String
    deriving (Eq, Show)

checkOperation :: [Expression] -> Bool
checkOperation oper = case oper of
    '+' -> True
    '-' -> True
    '*' -> True
    '/' -> True
    _ -> False

checkIdentifier :: [Expression] -> Bool
checkIdentifier id = case id of
    "" -> False
    _ -> True


checkParenthesis :: [Statement] -> Bool
checkParenthesis (Statement []) = True
checkParenthesis (Statement (r:rs)) = case r of
    (Operation Expression op Expression) -> checkOperation(op)
    (Operation Express)

    
naiveCheck :: [Statement] -> Bool
naiveCheck [] = True
naiveCheck sts = all (\_ -> True) sts


tc0 = naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '*' (IntegerLiteral "450")) ')' ) ';'), (Statement (Identifier "i") ';')]
tc1 = not (naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '*' (IntegerLiteral "450")) ']' ) ';'), (Statement (Identifier "i") ';')])
tc2 = not (naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '*' (IntegerLiteral "I0o0")) ')' ) ';'), (Statement (Identifier "i") ';')])
tc3 = not (naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '@' (IntegerLiteral "450")) ')' ) ';'), (Statement (Identifier "i") ';')])
tc4 = not (naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '@' (IntegerLiteral "450")) ')' ) ';'), (Statement (Identifier "i") '.')])
tc5 = not (naiveCheck [(Statement (Parenthesis '(' (Operation (Identifier "j") '*' (IntegerLiteral "450")) ')' ) ';'), (Statement (Identifier "") ';')])
