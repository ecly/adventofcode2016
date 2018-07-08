input :: Int
input = 3005290

main :: IO()
main = print $ solve input

-- https://stackoverflow.com/questions/7599777/how-to-select-every-n-th-element-from-a-list
dropEveryOther :: [a] -> [a]
dropEveryOther = map snd . filter ((==1) . fst) . zip (cycle [1,2])

findLastElf :: [Int] -> Int
findLastElf [] = -1
findLastElf [lastElf] = lastElf
findLastElf elves =
    if even (length elves)
       then findLastElf $ dropEveryOther elves
       else findLastElf $ drop 1 $ dropEveryOther elves

solve :: Int -> Int
solve amount = findLastElf [1..amount]
