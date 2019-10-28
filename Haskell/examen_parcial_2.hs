import Data.Char

{-
Examen Parcial 2
Layla Tame
A01192934


PREGUNTAS DE RESCATE

1. Chile
2. Ley Estatal de Salud en la cual los doctores o personal de salud puede negar la atención a alguna persona de la comunidad LGTB con base en sus "creencias"
3. No clue
-}



{-
1. Vocales 

Escribe una función que recibe una cadena y regresa un entero con la diferencia entre la cantidad de 
vocales y la cantidad de consonantes. Todo caracter que no sea una letra es ignorado. 

isAlpha es una función que regresa True si el caracter en cuestión es una letra. 

-}

vocalesAux :: [Char] -> Int -> Int -> (Int,Int)
vocalesAux [] vocC consC = (vocC, consC)
vocalesAux (x:xs) vocC consC= case (isAlpha x) of
  True -> case x of
    'a' -> vocalesAux xs (vocC+1) consC
    'e' -> vocalesAux xs (vocC+1) consC
    'i' -> vocalesAux xs (vocC+1) consC
    'o' -> vocalesAux xs (vocC+1) consC
    'u' -> vocalesAux xs (vocC+1) consC
    _ -> vocalesAux xs vocC (consC+1)
  False -> vocalesAux xs vocC consC


vocales :: [Char] -> Int
vocales frase = 
  do
    let tupla = vocalesAux frase 0 0
    fst tupla - snd tupla


-- tc1 = vocales "parangaricutirimicuaro" == 0
-- tc2 = vocales "all your base is belong to us" == -3




{-
2. Maparbol 

Implementa una función que recibe un árbol y una función, y regresa otro arbol con la función
aplicada a cada nodo y respetando la estructura del árbol enviado como parámetro. 

-}

data Arbol a = Nodo a (Arbol a) (Arbol a) | Vacio deriving (Eq, Show)

maparbol :: (a -> a) -> Arbol a -> Arbol a
maparbol _ Vacio = Vacio
maparbol b (Nodo a ar1 ar2) = Nodo (b a) (maparbol b ar1) (maparbol b ar2)

-- tc3 = maparbol (+ 2) (Nodo 5 (Nodo 6 Vacio Vacio) (Nodo 7 Vacio Vacio)) == (Nodo 7 (Nodo 8 Vacio Vacio) (Nodo 9 Vacio Vacio)) 
-- tc4 = maparbol (\x -> x ^ x) (Nodo 10 (Nodo 4 (Nodo 0 (Nodo 3 Vacio Vacio) (Nodo 9 Vacio Vacio)) Vacio) (Nodo 7 Vacio (Nodo 3 Vacio (Nodo 1 Vacio Vacio)))) == (Nodo 10000000000 (Nodo 256 (Nodo 1 (Nodo 27 Vacio Vacio) (Nodo 387420489 Vacio Vacio)) Vacio) (Nodo 823543 Vacio (Nodo 27 Vacio (Nodo 1 Vacio Vacio))))



{-
3. Safebox 

Implementa una función que recibe una combinación (una lista de rotaciones) y una lista. Regresa una lista del mismo
tamaño con las rotaciones aplicadas. 

Una rotación puede ser en el sentido de las manecillas del reloj o en contra:

Clockwise = rotación derecha = el último se convierte en el primero
Counterclockwise = rotación izquierda = el primero se convierte en el último

-}

type Steps = Int
data Direction = Clockwise | Counterclockwise
data Rotation = Rotation Direction Steps
data Combination = Combination [Rotation]


clockwiseFunc :: [Int] -> Int -> [Int]
clockwiseFunc lista 0 = lista
clockwiseFunc lista num = 
  do
    let ultim = last lista--lista !! ((length lista)-1)
    clockwiseFunc (ultim : (init lista)) (num-1)

counterFunc :: [Int] -> Int -> [Int]
counterFunc lista 0 = lista
counterFunc (x:xs) num = 
  do
    counterFunc (xs++[x]) (num-1)

safebox :: Combination -> [Int] -> [Int]
safebox (Combination []) list = list
safebox (Combination (r:rs)) list = case r of
  (Rotation Clockwise n) -> safebox (Combination rs) (clockwiseFunc list n)
  (Rotation Counterclockwise n) -> safebox (Combination rs) (counterFunc list n)

-- tc5 = safebox (Combination [(Rotation Clockwise 5), (Rotation Counterclockwise 5)]) [0,1,2,3,4,5,6,7,8,9] == [0,1,2,3,4,5,6,7,8,9]
-- tc6 = safebox (Combination [(Rotation Clockwise 2), (Rotation Clockwise 2), (Rotation Counterclockwise 5), (Rotation Clockwise 2), (Rotation Counterclockwise 7)]) [0,1,2,3,4,5,6,7,8,9] == [6,7,8,9,0,1,2,3,4,5]


{-
4. Ciclos 

Programa una función que reciba un nodo inicial, una lista de visitados y un grafo dirigido, y determina si hay un ciclo en alguno de los caminos 
que inician con el nodo enviado como parámetro. Sólo debe un Bool.

El algoritmo consiste en realizar un recorrido Depth First Search, llevando control de los nodos visitados. Se dice que hay un ciclo si en alguno 
de los caminos individuales se visita un nodo más de una vez.  

El grafo dirigido está representado como una lista de arcos (startNode, endNode)

Hint: implementa una función auxiliar que encuentre los vecinos de un nodo. 
-}

type Grafo = [Arco]
type Arco = (Nodo, Nodo)
type Nodo = Int

-- ciclo :: Nodo -> [Nodo] -> Grafo -> Bool
-- tc7 = ciclo 1 [] [(1,0), (0,10), (1,2), (2,3), (3,4), (4,5), (4,6), (6,2), (1,8), (8,9)]
-- tc8 = not (ciclo 1 [] [(1,2), (2,3), (3,4), (4,5), (4,6), (6,7), (7,8), (9,9)])




{- 
5. Southdoku 4x4

Hay una versión infantil del Sudoku, que consiste en un tablero 4x4. Las reglas son las mismas:

No puede haber repetidos en un mismo renglón, columna o cuadrante. 

Se te da una función llamada cellAt, que regresa el elemento en las coordenadas enviadas
como parámetro.

Se te da otra función llamada quadrantAt, que dada una posición, identifica en qué cuadrante está
y te regresa los elementos de ese cuadrante. 

Se te pide implementar una función "candidatos" que recibe como parámetro una coordenada y un
tablero de Sudoku 4x4. Regresa una lista con los posibles valores que podría tomar esa celda. 
Si la celda ya está ocupada, debe regresa una lista vacía. 

Ejemplo:

tablero = 
  0          1           2           3
0[Kyle,      Empty,      Empty,      Stan] 
1[Empty,     Cartman,    Kenny,      Empty]
2[Empty,     Kyle,       Stan,       Empty]
3[Cartman,   Empty,      Empty,      Kenny]

coordenada = (renglon, columna)
(0,3) = Stan
(2,1) = Kyle
(3,0) = Cartman

candidatos (0,1) tablero == [Kenny]

-}

data Southdoku = Southdoku [[Cell]] deriving (Eq, Show)
data Cell = Empty | Kenny | Stan | Kyle | Cartman deriving (Eq, Show)

cellAt :: (Int, Int) -> Southdoku -> Cell
cellAt (0,0) (Southdoku (x:xs)) = head x
cellAt (x,0) (Southdoku xs) = head (head (drop x xs))
cellAt (0,y) (Southdoku (x:xs)) = head (drop y x)
cellAt (x,y) (Southdoku xs) = cellAt ((x - 1),(y - 1)) (Southdoku (map tail (drop 1 xs)))

quadrantAt :: (Int, Int) -> Southdoku -> [Cell]
quadrantAt (x,y) southdoku = map (\x -> cellAt x southdoku) quadrant
    where q1 = [(0,0), (0,1), (1,0), (1,1)]
          q2 = [(0,2), (0,3), (1,2), (2,3)]
          q3 = [(2,0), (2,1), (3,0), (3,1)]
          q4 = [(2,2), (2,3), (3,2), (3,3)]
          quadrant = head (filter (\q -> elem (x,y) q) [q1, q2, q3, q4])


showCol :: (Int, Int) -> Southdoku -> [Cell]
showCol (x,y) southdoku = map (\x -> cellAt x southdoku) col
    where q1 = [(0,0), (1,0), (2,0), (3,0)]
          q2 = [(0,1), (1,1), (2,1), (3,1)]
          q3 = [(0,2), (1,2), (2,2), (3,2)]
          q4 = [(0,3), (1,3), (2,3), (3,3)]
          col = head (filter (\q -> elem (x,y) q) [q1, q2, q3, q4])

showRow :: (Int, Int) -> Southdoku -> [Cell]
showRow (x,y) southdoku = map (\x -> cellAt x southdoku) row
    where q1 = [(0,0), (0,1), (0,2), (0,3)]
          q2 = [(1,0), (1,1), (1,2), (1,3)]
          q3 = [(2,0), (2,1), (2,3), (2,3)]
          q4 = [(3,0), (3,1), (3,2), (3,3)]
          row = head (filter (\q -> elem (x,y) q) [q1, q2, q3, q4])


addCandidates :: (Int, Int) -> Southdoku -> Cell -> [Cell] -> [Cell]
addCandidates coord tablero cand listPos = 
  do
    let reng = showRow coord tablero
    let col = showCol coord tablero
    let quad = quadrantAt coord tablero
    case (cand `elem` reng) of
      True -> []
      False -> case (cand `elem` col) of
        True -> []
        False -> case (cand `elem` quad) of
          True -> []
          False -> cand : listPos


callCand :: (Int, Int) -> Southdoku -> Int -> [Cell] -> [Cell] -> [Cell]
callCand coord tablero 0 candidatos listaP = listaP
callCand coord tablero cont candidatos listaP = (callCand coord tablero (cont-1) candidatos (addCandidates coord tablero (candidatos !! (cont-1)) listaP)) ++ listaP


candidates :: (Int, Int) -> Southdoku -> [Cell]
candidates coord tablero = 
  do
    let celda = cellAt coord tablero
    let candidatos = [Kenny, Stan, Kyle, Cartman]
    case celda of
      Empty -> callCand coord tablero 4 candidatos []
      _ -> []


-- tc9 = candidates (0, 1) (Southdoku [[Kyle, Empty, Empty, Stan], [Empty, Cartman, Kenny, Empty], [Empty, Kyle, Stan, Empty], [Cartman, Empty, Empty, Kenny]]) == [Kenny]
-- tc10 = candidates (0, 3) (Southdoku [[Kyle, Empty, Empty, Stan], [Empty, Cartman, Kenny, Empty], [Empty, Kyle, Stan, Empty], [Cartman, Empty, Empty, Kenny]]) == []
