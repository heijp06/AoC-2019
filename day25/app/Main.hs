module Main where

import Lib
import Utils
import System.Clipboard (setClipboardString)
import IntCode (Interpreter, Program, empty, fromList, inputAscii, outputAscii, run)
import Control.Monad.State (evalState, execState, runState)

main :: IO ()
main = do
    -- xs <- rows <$> readFile "data.txt" -- Data item per row.
    -- xs <- groups <$> readFile "data.txt" -- Groups of data items separated by empty rows.
    -- xs <- multi <$> readFile "data.txt" -- Multi line strings separated by empty rows.
    xs <- readCode
    let (output, interpreter) = runState (initialize xs) empty
    mapM_ putStrLn output
    let (output', interpreter') = runState (execAll solution) interpreter
    -- let output' = evalState (tryAll (takeSome takeAll) []) interpreter'
    -- mapM_ (f interpreter') (takeSome takeAll)
    mapM_ putStrLn output'
    -- loop interpreter'
    -- putStr "Part one: "
    -- let x = part1 xs
    -- print x
    -- clip x

    -- putStr "Part two: "
    -- let y = part2 xs
    -- print y
    -- clip y

f :: Interpreter -> [String] -> IO ()
f interpreter some = do
    let macro = dropAll ++ some ++ ["north"]
    let output = evalState (execAll macro) interpreter
    mapM_ putStrLn output

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
    if null command
        then
            loop interpreter
        else
            if head command == 'q'
                then
                    return ()
                else
                    do
                        let (output, interpreter') = runState (exec command) interpreter
                        mapM_ putStrLn output
                        loop interpreter'

tryAll :: [[String]] -> [String] -> Program [String]
tryAll [] output = return output
tryAll (x:xs) output = do
    runMacro dropAll
    output' <- execAll ("inv":x ++ ["north"])
    tryAll xs (output' ++  output)

exec :: String -> Program [String]
exec input = do
    execAll [input]

execAll :: [String] -> Program [String]
execAll xs = do
    inputAscii xs
    run
    outputAscii

runMacro :: [String] -> Program ()
runMacro [] = return ()
runMacro (x:xs) = do
    exec x
    runMacro xs

solution :: [String]
solution =
    [ "south"
    , "take monolith"
    , "east"
    , "take asterisk"
    , "west"
    , "north"
    -- , "west"
    -- , "take coin"
    -- , "north"
    -- , "east"
    -- , "take astronaut ice cream"
    -- , "west"
    -- , "south"
    -- , "east"
    , "north"
    , "north"
    -- , "take mutex"
    , "west"
    , "take astrolabe"
    , "west"
    -- , "take dehydrated water"
    , "west"
    , "take wreath"
    , "east"
    , "south"
    , "east"
    , "north"
    , "north"
    ]

toCheckPoint :: [String]
toCheckPoint =
    [ "south"
    , "take monolith"
    , "east"
    , "take asterisk"
    , "west"
    , "north"
    , "west"
    , "take coin"
    , "north"
    , "east"
    , "take astronaut ice cream"
    , "west"
    , "south"
    , "east"
    , "north"
    , "north"
    , "take mutex"
    , "west"
    , "take astrolabe"
    , "west"
    , "take dehydrated water"
    , "west"
    , "take wreath"
    , "east"
    , "south"
    , "east"
    , "north"
    ]

dropAll :: [String]
dropAll =
    [ "drop monolith"
    , "drop asterisk"
    , "drop coin"
    , "drop astronaut ice cream"
    , "drop mutex"
    , "drop astrolabe"
    , "drop dehydrated water"
    , "drop wreath"
    ]

takeAll :: [String]
takeAll =
    [ "take monolith"
    , "take asterisk"
    , "take coin"
    , "take astronaut ice cream"
    , "take mutex"
    , "take astrolabe"
    , "take dehydrated water"
    , "take wreath"
    ]

takeSome :: [String] -> [[String]]
takeSome [] = [[]]
takeSome (x:xs) = let some = takeSome xs in some ++ (map (x:) some)