module Main where
import Data.Char

getk :: Int -> Int -> Int
getk k n = digitToInt c
    where
        c = s !! (k-1)
        s = show n

dmap :: Int -> Char -> Float
dmap n c = case (n, c) of
    (n, 'A') -> 0.60 + 0.010 * (n2 + n3)
    (n, 'B') -> 0.68 + 0.005 * (n4)
    (n, 'C') -> 2.67 + 0.020 * (n5 + n6)
    (n, 'D') -> 1.50 + 0.010 * (n3 + n7)
    (n, 'E') -> 0.10 * n4 + 0.01 * n6
    (n, 'F') -> 0.01 * n2 + 0.1 * n5 + 1
    (n, 'G') -> 1.50 + 0.005 * n6
    (n, 'H') -> (fromIntegral 45) + n4 + n5
    (n, 'I') -> 0.80 + 0.060 * n7
    (n, 'J') -> 0.25 + 0.005 * n3
    (n, 'K') -> 0.01 * n7 + 0.1 * n6 + 1
    (n, 'L') -> 0.01 * n4 + 0.1 * n3 + 3
    (n, 'M') -> 0.01 * n6 + 0.1 * n4 + 2
    (n, 'N') -> 0.25 * ((+) 1 $ fromIntegral $ floor (0.3 * n5))
    (n, 'O') -> 2.00 * ((9 + n7) / (10 + n7))
    (n, 'P') -> 2.00 * (10 + n2 + n3) + 1
    (n, 'Q') -> 0.01 * n5 + 0.1 * n7 + 4
    (n, 'R') -> 0.01 * n3 + 0.1 * n4 + gQ
    (n, 'S') -> 0.01 * n6 + 0.1 * n2 + 1
    (n, 'T') -> 0.01 * n4 + 0.1 * n5 + gS
    (n, 'U') -> 0.01 * (n4 + n7) + 0.1
    where
        n2 = fromIntegral $ getk 2 n
        n3 = fromIntegral $ getk 3 n
        n4 = fromIntegral $ getk 4 n
        n5 = fromIntegral $ getk 5 n
        n6 = fromIntegral $ getk 6 n
        n7 = fromIntegral $ getk 7 n
        gQ = dmap n 'Q'
        gS = dmap n 'S'

splitMap :: [(Float,Char)] -> ([(Float,Char)],[(Float,Char)])
splitMap xs = (first, equalized)
    where
        equalized = if (length second) < (length first)
            then second ++ [(0.0, ' ')]
            else second
        first  = (\(a,b) -> a) splitted
        second = (\(a,b) -> b) splitted
        splitted = splitAt middle xs
        middle   = ((+) 1 $ length xs) `div` 2

column :: (Float,Char) -> (Float,Char) -> [Char]
column p1 p2 = (pair p1) ++ "\t&&\t" ++ (pair p2)
    where
        pair (f,' ') =        "\t&\t"
        pair (f, c ) = [c] ++ "\t&\t" ++ (show f)

main :: IO ()
main = putStrLn $ foldl func "" columns
    where
        func c col  = c ++ col ++ "\\\\\n"
        columns = zipWith (\a b -> column a b) first second
        first  = (\(a,b) -> a) splitted
        second = (\(a,b) -> b) splitted
        splitted = splitMap mapping
        mapping = [(dmap matricule l,l) | l <- letters]
        letters = "ABCDEFGHIJKLMNOPQRSTU"
        matricule = 1837776
