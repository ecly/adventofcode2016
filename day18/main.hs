import Data.List(tails)

input :: String
input = ".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^"

type Trap = Bool
type Row = [Trap]

main :: IO()
main = do
    print $ solve 40 (map toBool input)
    print $ solve 400000 (map toBool input)

toBool :: Char -> Bool
toBool =  ('^'==)

solve :: Int -> Row -> Int
solve iterations =
    length . filter not . concat . take iterations . iterate step

step :: Row -> Row
step row =
    let extended = (False:row) ++ [False]
        inp = [(x,y,z) | x:y:z:_ <- tails extended]
     in map isTrap inp

isTrap :: (Trap, Trap, Trap) -> Bool
isTrap (True, True, False) = True
isTrap (False, True, True) = True
isTrap (True, False, False) = True
isTrap (False, False, True) = True
isTrap _ = False

