import Data.Bits
import Data.List

type Coord = (Int, Int)

input :: Int
input = 1362

main :: IO ()
main = print $ bfs [] (31, 39) [(1, 1)] 0

isValidCoord :: Coord -> Bool
isValidCoord (x,y) = even (popCount (x*x + 3*x + 2*x*y + y + y*y + input))

nodes :: Coord -> [Coord]
nodes (0,0) = [(0,1), (1,1)]
nodes (1,0) = [(0,0), (1,1), (2,0)]
nodes (0,1) = [(0,0), (1,1), (0,2)]
nodes (x,y) = [(x+1,y), (x-1,y), (x,y-1), (x,y+1)]

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
