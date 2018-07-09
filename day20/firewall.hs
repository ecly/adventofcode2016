import Data.List (sort)

main :: IO()
main = do
    ranges <- sort . parse <$> getContents
    print (findLowest 0 ranges)

-- https://stackoverflow.com/questions/4978578/how-to-split-a-string-in-haskell
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

parse :: String -> [[Int]]
parse = map (map read . wordsWhen (=='-')) . lines

findLowest :: Int -> [[Int]] -> Int
findLowest low [] = low
findLowest low ((l:h:_):t) =
    if low >= l && low <= h
       then findLowest (h+1) t
       else findLowest low t
