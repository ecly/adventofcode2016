import Debug.Trace (trace)

type Coord = (Int, Int)
data Node = Node { coords :: Coord
          , size :: Int
          , used :: Int
          , available :: Int } deriving (Show)

main :: IO()
main = do
    input <- parse <$> getContents
    print (take 5 input)


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
lineToNode line = Node coords_ size_ used_ available_
    where (fs:rest) = words line
          coords_ = coordFromFileSystem fs
          (size_:used_:available_:_) = map (read . init) (init rest)

