module Main where

import Rotations

main :: IO ()
main = do
  inputWords <- lines <$> getContents
  mapM_ (putStrLn . format . rotateWord) inputWords
  where
    format (n, word) = show n ++ " " ++ word
