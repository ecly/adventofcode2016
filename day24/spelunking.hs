import Data.Char (digitToInt)
import Data.List (permutations, nub)
import Data.Map (Map)
import Data.Set (Set)
import qualified Data.Map as Map
import qualified Data.Set as Set

data Node = Open
          | Closed
          | Number Int deriving (Show, Eq)

type Coord = (Int, Int)

main :: IO()
main = do
    graph <- parse <$> getContents
    print (solve1 graph)

parse input =
    let rows = lines input
        parseChar '#' = Closed
        parseChar '.' = Open
        parseChar  n  = Number (digitToInt n)
     in Map.fromList [((x, y), parseChar c) | (y, s) <- zip [0..] rows, (x, c) <- zip [0..] s]

solve1 :: Map Coord Node -> Int
solve1 graph =
    let isNumber (Number _) = True
        isNumber _ = False
        numbers = (Map.toList . Map.filter isNumber) graph
     in minimum $ map (pathDist graph) (permutations $ map fst numbers)

pathDist :: Map Coord Node -> [Coord] -> Int
pathDist graph numbers =
    let pairs = zip numbers (tail numbers)
     in sum $ map (\(f, t) -> bfs graph f t) pairs

neighbours :: Map Coord Node -> Coord -> [Coord]
neighbours _ _ = []

bfs :: Map Coord Node -> Coord -> Coord -> Int
bfs graph from to = aux Set.empty [from] 0
  where
    aux _    []       d = -1
    aux seen frontier d
      | to `elem` frontier = d
      | otherwise = aux newSeen newFrontier d+1
        where
            newSeen = Set.union seen (Set.fromList frontier)
            newFrontier = filter (not . (flip Set.member) seen) (frontier >>= neighbours graph)
