module Main where

fact :: Int -> Int
fact n = product [1..n]

comb :: Int -> Int -> Int
comb k n = (product [n-k+1..n]) `div` (fact k)

f :: Int -> Int -> Int -> Int
f 0 0 s = 1
f 0 n s = if n < 0 || n > s then 0 else (2^n) * (comb n s)
f c n s = 3*(f (c-1) (n-2) s) + (f (c-1) (n-1) s) + (f (c-1) (n-3) s)

main :: IO ()
main = putStrLn $ show $ f 8 12 28
