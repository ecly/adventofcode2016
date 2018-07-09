import Data.List (sort)

-- Implement ranges as a list.
-- We expect it to have 2 members.
-- Really should have been a tuples, but oh well :-)
type Range = [Int]

main :: IO()
main = do
    ranges <- sort . parse <$> getContents
    -- This worked for me for part 1,
    -- but I imagine there may be inputs where this does not work
    print $ findLowest 0 ranges
    -- Added one to given number, since its inclusive in both ends
    print $ 4294967296 - excludedAddressCount ranges

-- https://stackoverflow.com/questions/4978578/how-to-split-a-string-in-haskell
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

parse :: String -> [Range]
parse = map (map read . wordsWhen (=='-')) . lines

findLowest :: Int -> [Range] -> Int
findLowest low [] = low
findLowest low ((l:h:_):t) =
    if low >= l && low <= h
       then findLowest (h+1) t
       else findLowest low t

merge :: [Range] -> [Range]
merge ((l1:h1:_):(l2:h2:_):t)
    | h1 >= l2 = merge ([l1, max h1 h2]:t)
merge (x:xs) = x:merge xs
merge [] = []

excludedAddressCount :: [Range] -> Int
excludedAddressCount = sum . map (\(l:h:_) -> h-l+1) . merge
