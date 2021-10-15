module Main where

import Lib
import Utils
import System.Clipboard (setClipboardString)
import IntCode (Interpreter, Program, empty, fromList, inputAscii, outputAscii, run)
import Control.Monad.State (runState)

main :: IO ()
main = do
    -- xs <- rows <$> readFile "data.txt" -- Data item per row.
    -- xs <- groups <$> readFile "data.txt" -- Groups of data items separated by empty rows.
    -- xs <- multi <$> readFile "data.txt" -- Multi line strings separated by empty rows.
    xs <- readCode
    let (output, interpreter) = runState (initialize xs) empty
    mapM_ putStrLn output
    loop interpreter
    -- putStr "Part one: "
    -- let x = part1 xs
    -- print x
    -- clip x

    -- putStr "Part two: "
    -- let y = part2 xs
    -- print y
    -- clip y

clip :: Show a => a -> IO ()
clip = setClipboardString . show

readCode :: IO [Integer]
readCode = do
    xs <- readFile "data.txt"
    return . read $ '[' : xs ++ "]"

initialize :: [Integer] -> Program [String]
initialize code = do
    fromList code
    run
    outputAscii

loop :: Interpreter -> IO ()
loop interpreter = do
    command <- getLine
    if head command == 'q'
        then
            return ()
        else
            do
                let (output, interpreter') = runState (exec command) interpreter
                mapM_ putStrLn output
                loop interpreter'

exec :: String -> Program [String]
exec input = do
    inputAscii [input]
    run
    outputAscii