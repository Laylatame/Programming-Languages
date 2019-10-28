type Lugar = [Int]

nReinas :: Int -> [Lugar]
nReinas numR = revIt [[]] 0 where
    revIt :: [Lugar] -> Int -> [Lugar]
    revIt arrLug i
      | i == numR = arrLug
      | otherwise = revIt (concatMap expand arrLug) (i+1)

    expand :: Lugar -> [Lugar]
    expand arr = [x : arr | x <- [1..numR], safe x arr 1]

    safe x [] _ = True
    safe x (c:y) numR = and [x /= c , x /= c + numR , x /= c - numR , safe x y (numR+1)]
