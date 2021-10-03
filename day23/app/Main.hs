module Main where

import Lib
import Utils
import System.Clipboard (setClipboardString)

main :: IO ()
main = do
    -- xs <- rows <$> readFile "data.txt" -- Data item per row.
    -- xs <- groups <$> readFile "data.txt" -- Groups of data items separated by empty rows.
    -- xs <- multi <$> readFile "data.txt" -- Multi line strings separated by empty rows.
    putStr "Part one: "
    -- let x = part1 xs
    -- print x
    -- clip x

    putStr "Part two: "
    -- let y = part2 xs
    -- print y
    -- clip y

clip :: Show a => a -> IO ()
clip = setClipboardString . show