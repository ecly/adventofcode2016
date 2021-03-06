import Data.List
import Data.List.Split

main :: IO()
main = do 
    input <- parse <$> getContents
    putStrLn $ show $ length $ filter isValidTriangle input
    putStrLn $ show $ length $ filter isValidTriangle (adjustGroups input)

parse :: String -> [[Integer]]
parse x = map (\ l -> map read (words l)) (lines x)

adjustGroups :: [[Integer]] -> [[Integer]]
adjustGroups = chunksOf 3 . concat . transpose

isValidTriangle :: [Integer] -> Bool
isValidTriangle vals = let longest = maximum vals
                        in longest < (sum $ delete longest vals)
