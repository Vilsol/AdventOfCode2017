import System.IO

stringsToInts :: [String] -> [Int]
stringsToInts p = map read p

minMaxDiff :: String -> Int
minMaxDiff p =
    let x = stringsToInts $ words p
    in (maximum x) - (minimum x)

checksum :: [String] -> Int
checksum p = sum $ map minMaxDiff p

main = do
    contents <- readFile "input.txt"
    let spreadsheet = lines contents
    print $ checksum spreadsheet
