import Data.Bits
import Data.List

type Coord = (Int, Int)

input :: Int
input = 1362

main :: IO ()
main = do
    print $ bfs [] (31, 39) [(1, 1)] 0
    print $ bfsDistinct [] [(1, 1)] 0 50

isValidCoord :: Coord -> Bool
isValidCoord (x,y) = even (popCount (x*x + 3*x + 2*x*y + y + y*y + input))

nodes :: Coord -> [Coord]
nodes (x,y) =
    let list = [(x+1,y), (x-1,y), (x,y-1), (x,y+1)]
     in filter (\(x',y') -> x' >= 0 && y' >= 0) list

neighbours :: Coord -> [Coord]
neighbours (x, y) =
    filter isValidCoord $ nodes (x,y)

bfs :: [Coord] -> Coord -> [Coord] -> Int -> Int
bfs _seen _target [] _dist = -1
bfs seen target frontier dist
  | target `elem` frontier = dist
  | otherwise = bfs (seen ++ frontier) target newFrontier dist+1
    where
        localNeighbours = frontier >>= neighbours
        newFrontier = filter (`notElem` seen) (nub localNeighbours)

-- Counts how many unique Coords are available within maxDist
bfsDistinct :: [Coord] -> [Coord] -> Int -> Int -> Int
bfsDistinct _seen [] _dist _maxDist = -1
bfsDistinct seen frontier dist maxDist
  | dist == maxDist = length $ seen ++ frontier
  | otherwise = bfsDistinct (seen ++ frontier) newFrontier (dist+1) maxDist
    where
        localNeighbours = frontier >>= neighbours
        newFrontier = filter (`notElem` seen) (nub localNeighbours)
