module Lib
    ( part1
    , part2
    , initialize
    ) where

import Data.List.Split (chunksOf)
import Data.Maybe (fromMaybe, isJust, maybe)
import IntCode (Interpreter, Program, addInputs, empty, fromList, readOutputs, run)
import Control.Monad.State (State, execState, get, put, runState)
import qualified Data.Map as M

data Nat = Nat
    { value :: [Integer]
    , prevY :: Maybe Integer
    , func :: Maybe Integer -> Maybe Integer -> Maybe Integer
    , result :: Maybe Integer
    }

part1 :: [Integer] -> Integer
part1 code = findY (initialize code) emptyNat

part2 :: [Integer] -> Integer
part2 code = findY (initialize code) (cloneNat emptyNat { func = g })

g :: Maybe Integer -> Maybe Integer -> Maybe Integer
g newY prevY = if newY == prevY then newY else Nothing

findY :: [Interpreter] -> Nat -> Integer
findY ns nat = fromMaybe (findY ns' nat') (result nat')
    where
        (ns', nat') = runState (next ns) nat

next :: [Interpreter] -> State Nat [Interpreter]
next ns =
    do
        let osns = map (runState readOutputs) ns
        let queues = foldr addToQueue M.empty . chunksOf 3 $ concatMap fst osns

        let maybeNatQueue = M.lookup 255 queues
        nat <- get
        let natValue = maybe (value nat) (last . chunksOf 2) maybeNatQueue

        let (queues', newY) = if null queues
            then (M.singleton 0 natValue, Just $ natValue !! 1)
            else (queues, Nothing)
        let newResult = func nat newY (prevY nat)
        let newY' = if isJust newY then newY else prevY nat
        put $ cloneNat nat { value = natValue, prevY = newY', result = newResult }

        return $ map (f queues') (zip [0..49] (map snd osns))

f :: M.Map Integer [Integer] -> (Integer, Interpreter) -> Interpreter
f queues (i, n) = execState (inputs (M.lookup i queues)) n

addToQueue :: [Integer] -> M.Map Integer [Integer] -> M.Map Integer [Integer]
addToQueue [addr, x, y] queues = M.insertWith (flip (++)) addr [y] $ M.insertWith (flip (++)) addr [x] queues
addToQueue xs _ = error $ "Incorrect number of arguments " ++ show xs

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
    addInputs [i, -1]
    run
    return ()

emptyNat :: Nat
emptyNat = Nat
    { value = []
    , prevY = Nothing
    , func = const
    , result = Nothing
    }

cloneNat :: Nat -> Nat
cloneNat nat = Nat
    { value = value nat
    , prevY = prevY nat
    , func = func nat
    , result = result nat
    }