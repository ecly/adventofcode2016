import Data.Char
import Data.Set ( Set )
import Data.Digest.Pure.MD5
import qualified Data.Set as Set
import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString.Lazy.Char8 as C8

type State = (Int, Int, String)

_input :: String
_input = "vkjiggvb"

main :: IO()
main = do
    let paths = [path | (3,3,path) <- bfs (0,0, _input)]
    print (head paths)
    -- kills pc
    -- print (length $ last paths)

md5Hash :: String  -> String
md5Hash = show . md5 . C8.pack

isOpen :: Char -> Bool
isOpen x = x `elem` "bcdef"

isValidState :: State -> Bool
isValidState (x, y, _) = x >= 0 && y >= 0 && x < 4 && y < 4

neighbours :: State -> [State]
neighbours (x, y, i) =
    let hash = md5Hash i
        up = (x, y-1, i ++ "U")
        down = (x, y+1, i ++ "D")
        left = (x-1, y, i ++ "L")
        right = (x+1, y, i ++ "R")
        moves = [up, down, left, right]
        candidates = zip (map isOpen (take 4 hash)) moves
     in map snd (filter (\(open, c) -> isValidState c && open) candidates)

bfs :: State -> [State]
bfs initial = aux Set.empty [initial] []
  where
    aux _    [] [] = []
    aux seen [] ys = aux seen (reverse ys) []
    aux seen (x:xs) ys
      | Set.member x seen = aux seen xs ys
      | otherwise = x : aux (Set.insert x seen) xs (neighbours x ++ ys)
