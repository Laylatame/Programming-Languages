-- Tarea 7
-- Otras solucioness

--NOTAS
-- (x:xs) saca x de la lista y deja xs
-- init xs manda todos menos el último de la lista
-- tuplas (x,y) fst saca el primero de la tupla, snd saca el segundo
-- zip de dos listas pone en tupla los elementos del mismo índice
-- _ indica todo lo demas en case of
-- filter + funcionTrueFlase de una lista y regresa una lista de los true
-- map (3*)[1,2,3]
-- foldl siempre agarra el de afuera primero
-- foldr siempre agarra el de adentro primero


lengthP :: (Num b) => [a] -> b
lengthP [] = 0
lengthP size = sum [1 | _ <- size]


batAvgRating :: Double -> Double -> String
batAvgRating num1 num2
    | avg <= 0.2 = "Terrible"
    | avg <= 0.25 = "Average"
    | avg <= 0.8 = "Good"
    | otherwise = "Excellent" 
    where avg = num1/num2


-- Triangulo de Pascal
pascalHelper::[Int] -> [Int]
pascalHelper (x:y:zs) = if (length zs) == 0 then 
                            [x+y]
                        else
                            [x+y] ++ (pascalHelper (y:zs))

siguiente::[[Int]] -> [Int]
siguiente [[]] = [1]
siguiente [[1]] = [1, 1]
siguiente x = [1] ++ (pascalHelper (last x)) ++ [1]


--Cambios -- 

cambios::[Int] -> [Int]
cambios[] = []
cambios (x:[]) = []
cambios (x:y:zs) = if x /= y then
                        [x] ++ (cambios(y:zs))
                    else
                        cambios(y:zs)


-- 2 Cambios
cambios1 :: [Int] -> [Int]
cambios1 [] = []
cambios1 [x] = []
cambios1 (x:xs) | x == (head xs) = cambios1(xs)
               | otherwise = x:cambios1(xs)
               

--2
cambios2 :: [Int] -> [Int]
cambios2 [] = []
cambios2 [x] = []
cambios2 (x:xs)
    | x /= head xs = x:cambios2 xs
    | otherwise = cambios2 xs


--3 
muyordenados :: [Int] -> Bool
muyordenados [] = True
muyordenados [x] = True
muyordenados (x:xs)
    | x > 0 = if (head xs) >= (2*x) then muyordenados xs else False
    | x < 0 = if (head xs) >= (x`div`2) then muyordenados xs else False

--3

muyordenadosHelper:: Int -> Int -> Bool
muyordenadosHelper x y = (x > 0 && y >= 2 * x) || (x < 0 && y >= (quot x 2))

muyordenados::[Int] -> Bool
muyordenados [] = True
muyordenados (x:[]) = True
muyordenados (x:y:[]) = muyordenadosHelper x y
muyordenados (x:y:zs) = if ok then
                            ok && (muyordenados(y:zs))
                        else 
                            False
                        where ok = muyordenadosHelper x y