type Coord = (Int, Int)
data Node = Node { coords :: Coord
          , used :: Int
          , available :: Int } deriving (Show, Eq, Ord)

main :: IO()
main = do
    input <- parse <$> getContents
    print (solve1 input)
    -- visualizing the grid,
    -- helped a great lot for solving
    -- putStrLn (visualize2 input)
    print (solve2 input)


parse :: String -> [Node]
parse = map lineToNode . drop 2 . lines

-- https://stackoverflow.com/questions/4978578/how-to-split-a-string-in-haskell
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

coordFromFileSystem :: String -> Coord
coordFromFileSystem fs = (x, y)
    where xy = wordsWhen (=='-') (drop 15 fs)
          (x:y:_) = map (read . drop 1) xy

lineToNode :: String -> Node
lineToNode line = Node coords_ used_ available_
    where (fs:rest) = words line
          coords_ = coordFromFileSystem fs
          (_:used_:available_:_) = map (read . init) (init rest)

validPair :: Node -> Node -> Bool
validPair n1 n2 = notEmpty && notSame && fits
    where notEmpty = used n1 /= 0
          notSame = coords n1 /= coords n2
          fits = used n1 < available n2

solve1 :: [Node] -> Int
solve1 input = sum $ map (\n -> length $ filter (validPair n) input) input

visualize :: Node -> String
visualize n
  | coords n == (0, 0) = "S"
  | coords n == (36, 0) = "\nG"
  | snd (coords n) == 0 = "\n."
  | snd (coords n) == 27 = "." ++ show (fst $ coords n)
  | used n > 100 = "#"
  | used n == 0 = "_"
  | otherwise = "."

visualize2 :: [Node] -> String
visualize2 = foldl (\acc n -> acc ++ visualize n) ""

-- quite hardcoded for my specific input
solve2 :: [Node] -> Int
solve2 input = emptyToGoal + goalToStart
         -- first we find the empty node
   where (x0, y0) = coords $ head $ filter ((==0) . used) input
         -- then we need the maxX
         maxX = maximum $ map (fst. coords) input
         -- find coords for start of wall
         wall = coords $ head $ filter ((>100) . used) input
         -- since we want to go above
         wx = fst wall - 1
         wy = snd wall
         -- calculate moves needed to get _ to G
         emptyToGoal = abs (x0 - wx) + abs (y0 - wy) + abs (wx - maxX) + wy
         -- calculate moves needed to move G to S
         goalToStart = (maxX - 1) * 5
