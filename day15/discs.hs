-- (Position, Positions, Number)
type Disc = (Int, Int, Int)

main :: IO()
main = do
    let discs = [(11, 13, 1), (0, 5, 2), (11, 17, 3),
                 (0,   3, 4), (2, 7, 5), (17, 19, 6)]
    print (solve discs 0)

solve :: [Disc] -> Integer -> Integer
solve discs time =
    if isFinished discs
       then time
       else solve (incrementDiscs discs) (time+1)

incrementDiscs :: [Disc] -> [Disc]
incrementDiscs = map (\(x, y, z) -> ((x+1) `mod` y, y, z))

isFinished :: [Disc] -> Bool
isFinished = all (\(x,y,z) -> (x+z) `mod` y == 0)
