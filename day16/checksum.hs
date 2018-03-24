input :: String
input = "10001110011110000"

main :: IO()
main = do
    print (solve 272 input)
    print (solve 35651584 input)

solve :: Int -> String -> String
solve size =
    checksum . take size . head . filter (\l -> length l >= size) . iterate generate

generate :: String -> String
generate a =
    let b = reverse $ map (\x -> if x == '0' then '1' else '0') a
     in a ++ "0" ++ b

checksum :: String -> String
checksum xs =
    if odd (length xs)
       then xs
       else checksum (genChecksum xs)

genChecksum :: String -> String
genChecksum [] = []
genChecksum [_] = []
genChecksum (x:y:xs) =
    if x == y
        then '1':genChecksum xs
        else '0':genChecksum xs
