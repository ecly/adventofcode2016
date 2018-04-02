import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString.Lazy.Char8 as C8
import Data.Digest.Pure.MD5
import Data.List
import Data.Maybe
import Data.Char

type Coord = (Int, Int)

_input :: String
_input = "vkjiggvb"

main :: IO()
main = print $ solve _input

solve :: String -> String
solve s =
    let path = bfs [] (3, 3) [(0, 0)] _input
     in zipWith letterFromMove path (tail path)

md5Hash :: String  -> String
md5Hash = show . md5 . C8.pack

letterFromMove :: Coord -> Coord -> Char
letterFromMove (x1, y1) (x2, y2) =
  let dx = x1 - x2
      dy = y1 - y2
   in case (dx, dy) of
        (1,  _) -> 'R'
        (-1, _) -> 'L'
        (_,  1) -> 'D'
        (_, -1) -> 'U'

isOpen :: Char -> Bool
isOpen x
  | x == 'a'= True
  | otherwise = isAlpha x

isValidCoord :: Coord -> Bool
isValidCoord (x, y) = x >= 0 && y >= 0 && x < 4 && y < 4

neighbours :: Coord -> String -> [Coord]
neighbours (x, y) i =
    let hash = md5Hash i
        moves = [(x, y-1), (x, y+1), (x-1, y), (x+1, y)]
        candidates = zip (map isOpen (take 4 hash)) moves
     in map snd (filter (\(open, c) -> isValidCoord c && open) candidates)
