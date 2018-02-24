import Data.Bits

data Entry = Wall | Open
    deriving (Show)

input :: Integer
input = 10

gridSize :: Integer
gridSize = 9

main :: IO ()
main = do
    let graph = [genGraphRow y | y <- [0..gridSize]]
    print graph

genGraphRow :: Integer -> [Entry]
genGraphRow y =
    let entryForCoord x' y' =
          if isValidCoord x' y'
             then Open
             else Wall
    in [entryForCoord x y | x <- [0..gridSize]]

isValidCoord :: Integer -> Integer -> Bool
isValidCoord x y = even (popCount (x*x + 3*x + 2*x*y + y + y*y + input))
