import Data.List

data Object = Generator Int | Chip Int
    deriving (Show, Eq)

type State = [[Object]]

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
