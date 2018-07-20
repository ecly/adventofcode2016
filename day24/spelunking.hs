import Data.Char (isDigit)
import Data.List (permutations, nub, tails, (\\))
import Data.Map (Map, (!))
import Data.Set (Set)
import qualified Data.Map as Map
import qualified Data.Set as Set
type Coord = (Int, Int)

main :: IO()
main = do
    graph <- parse <$> getContents
    let (first, second) = solve graph
    print first
    print second

parse :: String -> Map Coord Char
parse input =
    let rows = lines input
     in Map.fromList [((x, y), c) | (y, s) <- zip [0..] rows, (x, c) <- zip [0..] s]

pairs :: [a] -> [(a, a)]
pairs l = [(x,y) | (x:ys) <- tails l, y <- ys]

insertBoth :: (Coord, Coord) -> Int -> Map (Coord, Coord) Int -> Map (Coord, Coord) Int
insertBoth (x,y) v m = Map.insert (y,x) v m'
    where m' = Map.insert (x,y) v m

calcAllDists :: Map Coord Char -> Map (Coord, Coord) Int
calcAllDists graph =
    let digitCoords = map fst $ (Map.toList . Map.filter isDigit) graph
        allPairs = pairs digitCoords
     in foldl (\acc -> \(f,t) -> let d = bfs graph f t in insertBoth (f,t) d acc) Map.empty allPairs

solve :: Map Coord Char -> (Int, Int)
solve graph =
    let numbers = (Map.toList . Map.filter isDigit) graph
        zero = head $ filter ((=='0') . snd) numbers
        tailPerms = permutations $ map fst (numbers \\ [zero])
        perms1 = map (fst zero:) tailPerms
        perms2 = map (++[fst zero]) perms1
        allDists = calcAllDists graph
        first = minimum $ map (pathDist allDists) perms1
        second = minimum $ map (pathDist allDists) perms2
    in (first, second)


pathDist :: Map (Coord, Coord) Int -> [Coord] -> Int
pathDist dists numbers =
    let pairs = zip numbers (tail numbers)
     in sum $ map (\k -> dists ! k) pairs

neighbours :: Map Coord Char -> Coord -> [Coord]
neighbours graph (x,y) =
    let potentials = [(x-1,y), (x+1,y), (x,y-1), (x,y+1)]
        isOpen '#' = False
        isOpen _   = True
     in filter (\n -> isOpen $ Map.findWithDefault '#' n graph) potentials

bfs :: Map Coord Char -> Coord -> Coord -> Int
bfs graph from to = aux Set.empty [from] 0
  where
    aux _    []       d = 0
    aux seen frontier d
      | to `elem` frontier = d
      | otherwise = aux newSeen newFrontier d+1
        where
            newSeen = Set.union seen (Set.fromList frontier)
            newFrontier = filter (\n -> Set.notMember n seen) (nub $ frontier >>= neighbours graph)
