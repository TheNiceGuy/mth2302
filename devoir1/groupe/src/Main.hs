module Main where

f1 :: Int -> Int -> Int
f1 0 _ = 1
f1 n 0 = (f1 (n-1) 1)
f1 n m = (f1 (n-1) (m+1)) + m * (f1 (n-1) m)

f2 :: Int -> Int -> Int -> Int
f2 0 _ 3 = 1
f2 0 _ _ = 0
f2 n 0 _ = (f2 (n-1) 1 1)
f2 n m c = (f2 (n-1) (m+1) c) + (f2 (n-1) m (c+1)) + (m-1) * (f2 (n-1) m c)

f3 :: Int -> Int -> Int
f3 0 m = if m <= 7 then 1 else 0
f3 n 0 = (f3 (n-1) 1)
f3 n m = (f3 (n-1) (m+1)) + m * (f3 (n-1) m)

f4 :: Int -> Int -> Int -> Int
f4 0 m 3 = if m <= 7 then 1 else 0
f4 0 _ _ = 0
f4 n 0 _ = (f4 (n-1) 1 1)
f4 n m c = (f4 (n-1) (m+1) c) + (f4 (n-1) m (c+1)) + (m-1) * (f4 (n-1) m c)

main :: IO ()
main = putStrLn $ show $ map show [f1 16 0, f2 16 0 0, f3 16 0, f4 16 0 0]
