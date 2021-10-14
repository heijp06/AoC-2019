module Main where

import Lib
import System.Clipboard (setClipboardString)

main :: IO ()
main = do
    xs <- readCode
    putStr "Part one: "
    let x = part1 xs
    print x
    clip x

    putStr "Part two (13163, 20160 are wrong): "
    let y = part2 xs
    print y
    clip y

clip :: Show a => a -> IO ()
clip = setClipboardString . show

readCode :: IO [Integer]
readCode = do
    xs <- readFile "data.txt"
    return . read $ '[' : xs ++ "]"