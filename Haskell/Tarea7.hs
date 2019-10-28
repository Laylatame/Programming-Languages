-- Tarea 7. Haskell
-- Layla Tame
-- A01192934

import Data.Char

-- 1. Triangulo de Pascal

pascalAux :: [Int] -> [Int] -> Int -> [Int]
pascalAux listaAnt nuevLista 0 = 1:nuevLista
pascalAux listaAnt nuevLista num = 
    do
        let lista = ((listaAnt !! num) + (listaAnt !! (num-1))) : nuevLista
        pascalAux listaAnt lista (num-1)

pascal :: [[Int]] -> [Int]
pascal arbol = pascalAux (arbol !! ((length arbol)-1)) [1] ((length (arbol !! ((length arbol)-1)))-1)


--pascal [[1], [1,1], [1,2,1]]
--pascal [[1], [1,1], [1,2,1], [1,3,3,1]] 


-- 2. Cambios

cambiosAux :: [Int] -> [Int] -> Int -> [Int]
cambiosAux lista nueva 0 = nueva
cambiosAux lista nueva ind = 
    do
        if (lista !! ind) /= (lista !! (ind-1))
            then cambiosAux lista ((lista !! (ind-1)) : nueva) (ind-1)
            else cambiosAux lista nueva (ind-1)


cambios :: [Int] -> [Int]
cambios lista = cambiosAux lista [] ((length lista)-1)



--cambios [1,2,2,1,1,3,3,3]
--cambios [3,3,3]
--cambios [1,2,1,3]


-- 3. Muy Ordenados

ordAux :: [Int] -> Int -> Bool
ordAux lista 0 = True
ordAux lista cont =
    do
        let num1 = lista !! (cont-1)
        if num1 < 0
            then
                if (lista !! cont) >= (num1 `div` 2)
                    then ordAux lista (cont-1)
                    else False
            else
                if (lista !! cont) > (num1 * 2)
                    then ordAux lista (cont-1)
                    else False

muyOrdenados :: [Int] -> Bool
muyOrdenados lista = ordAux lista ((length lista)-1)


--muyOrdenados [-4, -1, 1, 3, 9]
--muyOrdenados [-4, -1, 1, 2, 9]


-- 4. El Camino

allPaths :: Int -> [(Int,Int)] -> [[Int]]
allPaths start graph = nextLists
    where
      curNodes = filter (\(f,_) -> f == start) graph
      nextStarts = map snd curNodes
      nextLists = if curNodes == []
                  then [[start]]
                  else map ((:) start) $ concat $ map (\nextStart -> allPaths nextStart graph) nextStarts

caminoAux :: Int -> Int -> [(Int, Int)] -> [[Int]] -> [[Int]] -> [[Int]]
caminoAux start end graph ([]) listaF = listaF
caminoAux start end graph (x:xs) listaF =
    do
        let ult = last x
        if (ult == end)
            then caminoAux start end graph (xs) (x:listaF)
            else caminoAux start end graph (xs) listaF
            

camino :: Int -> Int -> [(Int, Int)] -> [[Int]]
camino start end graph = 
    caminoAux start end graph (allPaths start graph) []

-- camino 1 4 [(1,2), (2,3), (3,4), (1,4), (1,5)]
-- camino 2 5 [(1,2), (3,5), (2,3), (2,6), (6,5)]


-- 5. Sudo Q

cellAt :: (Int, Int) -> [[Int]] -> Int
cellAt (0,0) ((x:xs)) = head x
cellAt (x,0) (xs) = head (head (drop x xs))
cellAt (0,y) ((x:xs)) = head (drop y x)
cellAt (x,y) (xs) = cellAt ((x - 1),(y - 1)) ((map tail (drop 1 xs)))


checkRows :: [[Int]] -> Int -> Int -> (Int, Int) -> Bool
checkRows lista num 0 (x,y)= True
checkRows lista num ind (x,y) = 
    do
        if ((ind-1) == y)
            then checkRows lista num (ind-1) (x,y)
            else 
                if ((lista !! (ind-1)) !! x) == num
                    then False
                    else 
                        if ((lista !! (ind-1)) !! x) == 0
                            then False
                            else checkRows lista num (ind-1) (x,y)


checkColumns :: [Int] -> Int -> Int -> Int -> Bool
checkColumns lista num 0 lug = True
checkColumns lista num ind lug = 
    do
        if ((ind-1) == lug)
            then checkColumns lista num (ind-1) lug
            else
                if (lista !! (ind-1)) == num
                    then False
                    else 
                        if (lista !! (ind-1)) == 0
                            then False
                            else checkColumns lista num (ind-1) lug

checkSquare :: (Int,Int) -> [[Int]] -> [Int]
checkSquare (x,y) tablero = map (\x -> cellAt x tablero) square
    where q1 = [(0,0), (0,1), (0,2), (1,0), (1,1), (1,2), (2,0), (2,1), (2,2)]
          q2 = [(0,3), (0,4), (0,5), (1,3), (1,4), (1,5), (2,3), (2,4), (2,5)]
          q3 = [(0,6), (0,7), (0,8), (1,6), (1,7), (1,8), (2,6), (2,7), (2,8)]
          q4 = [(3,0), (3,1), (3,2), (4,0), (4,1), (4,2), (5,0), (5,1), (5,2)]
          q5 = [(3,3), (3,4), (3,5), (4,3), (4,4), (4,5), (5,3), (5,4), (5,5)]
          q6 = [(3,6), (3,7), (3,8), (4,6), (4,7), (4,8), (5,6), (5,7), (5,8)]
          q7 = [(6,0), (6,1), (6,2), (7,0), (7,1), (7,2), (8,0), (8,1), (8,2)]
          q8 = [(6,3), (6,4), (6,5), (7,3), (7,4), (7,5), (8,3), (8,4), (8,5)]
          q9 = [(6,6), (6,7), (6,8), (7,6), (7,7), (7,8), (8,6), (8,7), (8,8)]
          square = head (filter (\q -> elem (x,y) q) [q1, q2, q3, q4, q5, q6, q7, q8, q9])


sudokuAux :: [[Int]] -> Int -> Int -> Bool
sudokuAux lista 0  row = True
sudokuAux lista ind row = 
    do
        let num = ((lista !! row) !! (ind-1))
        let resRow = checkRows lista num 9 ((ind-1), row)
        let resCol = checkColumns (lista !! row) num 9 (ind-1)
        case resRow of
            True -> case resCol of
                True -> sudokuAux lista (ind-1) row
                False -> False
            False -> False

 
sudoku :: [[Int]] -> Int -> Bool
sudoku lista 0 = True
sudoku lista col = case (sudokuAux lista 9 (col-1)) of
    True -> sudoku lista (col-1)
    False -> False

sudoQ :: [[Int]] -> Bool
sudoQ tablero = sudoku tablero 9

-- sudoQ [[1,5,2,4,8,9,3,7,6], [7,3,9,2,5,6,8,4,1], [4,6,8,3,7,1,2,9,5], [3,8,7,1,2,4,6,5,9], [5,9,1,7,6,3,4,2,8], [2,4,6,8,9,5,7,1,3], [9,1,4,6,3,7,5,8,2], [6,2,5,9,4,8,1,3,7], [8,7,3,5,1,2,9,6,4]]
-- sudoQ [[1,5,2,4,8,9,3,7,6], [7,3,9,2,5,6,8,4,1], [4,6,8,3,7,1,2,9,5], [3,8,7,1,2,4,6,5,9], [5,9,1,7,9,3,4,2,8], [2,4,6,8,9,5,7,1,3], [9,1,4,6,3,7,5,8,2], [6,2,5,9,4,8,1,3,7], [8,7,3,5,1,2,9,6,4]]
-- sudoQ [[1,5,2,4,0,9,3,7,6], [7,3,9,2,5,6,0,4,1], [4,0,8,3,7,1,0,9,5], [3,8,7,1,2,0,6,0,9], [5,9,1,7,0,3,4,2,8], [2,4,6,8,0,5,7,1,3], [9,0,4,6,3,7,5,8,2], [6,2,5,9,4,8,1,3,7], [8,7,3,0,1,2,9,6,4]]