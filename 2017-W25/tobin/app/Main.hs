module Main where

import System.IO (hFlush, stdout)
import Data.List (isInfixOf, find)

import Scraper (getLinks)

main :: IO ()
main = do
  path <- linkPath "/wiki/Philosophy" [] "/wiki/Telephone"
  maybe (putStrLn "Error") (mapM_ putStrLn) path
  -- maybeLinks <- getLinks (fullLink "/wiki/Science")
  -- maybe (putStrLn "Error") (mapM_ print . take 20) maybeLinks


fullLink :: String -> String
fullLink end = "https://en.wikipedia.org" ++ end


linkPath :: String -> [String] -> String -> IO (Maybe [String])
linkPath end visited page | done = do
                              putStr "\n" >> hFlush stdout
                              return . return . reverse $ page : visited
                          | otherwise = do
                              putStr "." >> hFlush stdout
                              -- putStrLn page
                              links <- getLinks . fullLink $ page
                              let nextPage = links >>= find valid
                              maybe (return Nothing) (linkPath end (page : visited)) nextPage
  where
    done = page == end || page `elem` visited
    valid = not . isInfixOf "Help:IPA"
