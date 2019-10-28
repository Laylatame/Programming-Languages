-- Tarea 5. Haskell
-- Layla Tame
-- A01192934

import Data.List
import System.IO


-- 1. Palíndromo
--Method 1
palAux :: Int -> Int -> String -> IO Bool
palAux 0 end word = return True
palAux end start word =
    do
        if word !! start == word !! end
            then palAux (end-1) (start+1) word
            else return False

palindromo :: String -> IO Bool
palindromo word = palAux ((length word)-1) 0 word

-- palindromo "xanax"
-- palindromo "dafa a afad"

-- 2. Comprime

comprimeAux :: [Char] -> [Char] -> [Char]
comprimeaux [] pal = pal
comprimeAux [x] pal = pal ++ [x]
comprimeAux (x:xs) pal = if (x == (xs !! 0))
                        then comprimeAux xs pal
                        else comprimeAux xs (pal ++ [x])

comprime :: String -> String
comprime pal = comprimeAux pal []

-- comprime "aaaabbbbcccddd"
-- comprime "rrrrrrrrrle"

-- 3. Anida-por-valor

anidadaAux :: Int -> Int ->[Int] -> [Int]
anidadaAux num cont lista = 
    if cont == 0
        then lista
        else anidadaAux num (cont-1) lista

desglosaSumaP numero suma = "(" ++ (show numero) ++ suma ++ ")"

sumatoriaDesde6 lista = "[" ++ foldr desglosaSumaP "0" lista ++ "]"

        {-
anidada-por-valor :: [Int] -> [Int]
anidada-por-valor (x:xs) = 
    if x == 0
        then ([] ++ anidadaAux x x []
-}

-- 4. eliminaCada


-- 5. rota

rota :: Int -> [Int] -> [Int]
rota x (y:ys)
    | x == 0 = (y:ys)
    | otherwise = rota (x-1) (ys ++ [y])


-- 6. esPrimo


-- 7. altitud


-- 8. hojas


