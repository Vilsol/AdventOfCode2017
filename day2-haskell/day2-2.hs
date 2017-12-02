import System.IO

stringsToInts :: [String] -> [Int]
stringsToInts p = map read p

isDivisibleBy :: Int -> [Int] -> [Int]
isDivisibleBy p z = filter (\x -> x `mod` p == 0) z

getDivisable :: [Int] -> [Int]
getDivisable p = (filter (\x -> length x > 1) (map (\x -> isDivisibleBy x p) p)) !! 0

getDivision :: [Int] -> Int
getDivision p = (maximum p) `div` (minimum p)

checksum :: [String] -> Int
checksum p = sum $ map (\x -> getDivision $ getDivisable (stringsToInts $ words x)) p

main = do
    contents <- readFile "input.txt"
    let spreadsheet = lines contents
    print $ checksum spreadsheet