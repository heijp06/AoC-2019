module Lib
    ( part1
    , part2
    , initialize
    ) where

import Data.List.Split (chunksOf)
import Data.Maybe (fromMaybe)
import IntCode (Interpreter, Program, addInputs, empty, fromList, readOutputs, run)
import Control.Monad.State (execState, runState)
import qualified Data.Map as M

part1 :: [Integer] -> Integer
part1 code = findY $ initialize code

findY :: [Interpreter] -> Integer
findY ns = fromMaybe (findY ns'') maybeY
    where
        osns = map (runState readOutputs) ns
        queues = foldr f M.empty . chunksOf 3 $ concatMap fst osns
        ns' = map snd osns
        maybeY = (!! 1) <$> M.lookup 255 queues
        ns'' = map (\i -> execState (inputs (M.lookup i queues)) (ns' !! fromIntegral i)) [0..49]

f :: [Integer] -> M.Map Integer [Integer] -> M.Map Integer [Integer]
f [addr, x, y] queues = M.insertWith (flip (++)) addr [y] $ M.insertWith (flip (++)) addr [x] queues
f xs _ = error $ "Incorrect number of arguments " ++ show xs

initialize :: [Integer] -> [Interpreter]
initialize code = map (\i -> execState (doInitialize code i) empty) [0..49]

inputs :: Maybe [Integer] -> Program ()
inputs maybeInputs = do
    let is = fromMaybe [-1] maybeInputs
    addInputs is
    run

doInitialize :: [Integer] -> Integer -> Program ()
doInitialize code i = do
    fromList code
    addInputs [i]
    run
    return ()

part2 = undefined