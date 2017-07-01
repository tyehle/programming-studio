module Main where

import Scraper (getLinks)

main :: IO ()
main = do
  maybeLinks <- getLinks "https://en.wikipedia.org/wiki/science"
  maybe (putStrLn "Error") (mapM_ print . take 20) maybeLinks
