import Data.Sequence (Seq)
import qualified Data.Sequence as Seq

input :: Int
input = 3005290

main :: IO()
main = do
    let elves = [1..input]
    print $ findLastElf elves
    print $ findLastElf2 (Seq.fromList elves)

-- https://stackoverflow.com/questions/7599777/how-to-select-every-n-th-element-from-a-list
dropEveryOther :: [Int] -> [Int]
dropEveryOther = map snd . filter ((==1) . fst) . zip (cycle [1,2])

findLastElf :: [Int] -> Maybe Int
findLastElf [] = Nothing
findLastElf [lastElf] = Just lastElf
findLastElf elves =
    if even (length elves)
       then findLastElf $ dropEveryOther elves
       else findLastElf $ drop 1 $ dropEveryOther elves

-- Part 2 literally killed my computer using Lists, so have to use Sequence instead.
findLastElf2 :: Seq Int -> Maybe Int
findLastElf2 elves =
    case Seq.viewl elves of
      Seq.EmptyL -> Nothing
      h Seq.:< t
        -- element in left, but not in right means only a single element is left
        | Seq.null t -> Just h
        | otherwise ->
            let tailSize = length t
                (l,r) = Seq.splitAt ((tailSize-1) `div` 2) t
             in findLastElf2 ((l Seq.>< Seq.drop 1 r) Seq.|> h)
