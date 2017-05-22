module Rotations where

import Data.Ord (compare)
import Data.List (minimumBy)

rotateWord :: String -> (Int, String)
rotateWord word = minimumBy compareWithIndex allRotations
  where
    doubleWord = word ++ word
    len = length word
    allRotations = map (\n -> (n, take len (drop n doubleWord))) [0..(len-1)]
    compareWithIndex (_, a) (_, b) = compare a b
