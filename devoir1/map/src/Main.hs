module Main where
import Data.Char

getk :: Int -> Int -> Int
getk k n = digitToInt c
    where
        c = s !! (k-1)
        s = show n

dmap :: Int -> Char -> Float
dmap n c = case (n, c) of
    (n, 'A') -> fromIntegral $ (+) 30 $ (*) 2 $ floor $ 0.3 * n3
    (n, 'B') -> fromIntegral $ (+) 10 $ floor $ 0.3 * n4
    (n, 'C') -> (+) (1+(gA/2)) $ fromIntegral $ floor $ 0.3 * n5
    (n, 'D') -> fromIntegral $ (-) 4  $ floor $ 0.3 * n5
    (n, 'E') -> fromIntegral $ (+) 15 $ floor $ 0.3 * n6
    (n, 'F') -> fromIntegral $ (+) 2  $ floor $ 0.3 * n7
    (n, 'G') -> fromIntegral $ (+) 7  $ floor $ 0.3 * n3
    (n, 'H') -> 3.00 + (0.05 * n4)
    (n, 'I') -> 2.20 + (0.05 * n5)
    (n, 'J') -> gH   + (0.03 * (1.0 + n6))
    (n, 'K') -> 2.40 + (0.05 * n2)
    (n, 'L') -> gH   + (0.02 * (1.0 + n7))
    (n, 'M') -> 0.16 + (0.02 * n3)
    (n, 'N') -> 0.50 - gM
    (n, 'O') -> 1.30 + (0.01 * n7)
    (n, 'P') -> 1.90 + (0.02 * n5)
    (n, 'Q') -> 56.0 + n2 + n3
    (n, 'R') -> 17.0 + n3
    (n, 'S') -> 15.0 + n4
    (n, 'T') -> 0.30 + (0.03 * n6)
    (n, 'U') -> 0.20 + (0.02 * n7)
    (n, 'V') -> minimum [gR, gS, gQ - gR, gS] - gD
    (n, 'W') -> 0.88 + (0.01 * n2)
    (n, 'X') -> 7.00 + n5
    (n, 'Y') -> 61.0 + n3 + n4
    (n, 'p') -> 2000.0 * (gX -gD)
    (n, 'o') -> gY - gF - 1
    where
        n2 = fromIntegral $ getk 2 n
        n3 = fromIntegral $ getk 3 n
        n4 = fromIntegral $ getk 4 n
        n5 = fromIntegral $ getk 5 n
        n6 = fromIntegral $ getk 6 n
        n7 = fromIntegral $ getk 7 n
        gA = dmap n 'A'
        gD = dmap n 'D'
        gF = dmap n 'F'
        gH = dmap n 'H'
        gM = dmap n 'M'
        gQ = dmap n 'Q'
        gR = dmap n 'R'
        gS = dmap n 'S'
        gX = dmap n 'X'
        gY = dmap n 'Y'

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
        letters = "ABCDEFGHIJKLMNOPQRSTUVWXYpo"
        matricule = 1837776
