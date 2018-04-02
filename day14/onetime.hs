import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString.Lazy.Char8 as C8
import Data.Digest.Pure.MD5
import Data.List
import Data.Maybe

input :: String
input = "ihaygndm"

main :: IO()
main = do
    print $ solve 1
    -- second solve takes a couple of minutes as the
    -- hash function in pureMD5 is somewhat slow
    print $ solve 2017

solve :: Int -> Maybe Int
solve n =
    let digests = [show $ repeatHash n (input ++ show i) | i <- [0..]]
        keys = [ x | x:xs <- tails digests, isValidKey x xs ]
    in keys!!63 `elemIndex` digests

md5Hash :: String  -> String
md5Hash = show . md5 . C8.pack

repeatHash :: Int -> String -> String
repeatHash n s
    | n == 0 = s
    | otherwise = repeatHash (n-1) (md5Hash s)

isValidKey :: String -> [String] -> Bool
isValidKey h hs =
     if null value
           then False
           else any (replicate 5 (head value) `isInfixOf`) (take 1000 hs :: [String])
     where  value = [ x :: Char | x:y:z:_ <- tails h, x==y && y==z ]
