import Data.List

data Object = Generator Int | Chip Int
    deriving (Show, Eq)

type Floor = [Object]
type State = [Floor]

input :: State
input = [[Generator 1, Chip 1, Generator 2, Generator 3],
         [Chip 2, Chip 3],
         [Generator 4, Chip 4, Generator 5, Chip 4],
         []]

goal :: State
goal = [[Generator 1, Chip 1, Generator 2, Generator 3, Chip 2,
          Chip 3, Generator 4, Chip 4, Generator 5, Chip 4],
          [], [], []]

main :: IO ()
main = print $ bfs [] goal [input] 0

isChip :: Object -> Bool
isChip (Chip _) = True
isChip _ = False

isGenerator :: Object -> Bool
isGenerator (Generator _) = True
isGenerator _ = False

isValidGenerator :: Object -> Object -> Bool
isValidGenerator (Chip x) g =
    case g of
      Chip _ -> False
      Generator y -> x==y
isValidGenerator _ _ = False

-- A floor is valid if all chips are connected to their Generator
-- or there are no Generators on the floor
isValidFloor :: Floor -> Bool
isValidFloor floor =
    let chips = filter isChip floor
        hasValidGenerator x = any (isValidGenerator x) floor
     in all hasValidGenerator chips || all isChip floor

-- Compute the valid elevators that can leave a floor.
-- This means the floor should be left valid
-- and the elevator should not contain conflicting Objects
validElevators :: Floor -> [Floor]
validElevators fl =
    let pairs = [[x,y] | (x:ys) <- tails fl, y <- ys]
        singles = [[x] | x <- fl]
        allElevators = filter isValidFloor $ pairs ++ singles
     in filter (isValidFloor . (\\ fl)) allElevators

neighbours :: State -> [State]
neighbours x = [x]

bfs :: [State] -> State -> [State] -> Int -> Int
bfs _seen _target [] _dist = -1
bfs seen target frontier dist
  | target `elem` seen = dist
  | otherwise = bfs (seen ++ frontier) target newFrontier dist+1
    where
        localNeighbours = frontier >>= neighbours
        newFrontier = filter (`notElem` seen) (nub localNeighbours)
