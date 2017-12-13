import Data.List

main :: IO()
main = do 
    input <- parse <$> getContents
    putStrLn $ show $ length $ filter isValidTriangle input

parse :: String -> [[Integer]]
parse x = map (\ l -> map read (words l)) (lines x)

isValidTriangle :: [Integer] -> Bool
isValidTriangle vals = let longest = maximum vals
                        in longest < (sum $ delete longest vals)
