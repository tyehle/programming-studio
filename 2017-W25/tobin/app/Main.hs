module Main where

import System.Environment (getArgs)
import System.IO (hFlush, stdout)
import Data.List (isInfixOf, find)

import Scraper (getLinks)

main :: IO ()
main = do
  (page:_) <- getArgs
  path <- linkPath "/wiki/Philosophy" [] ("/wiki/" ++ page)
  maybe (putStrLn "Error") (mapM_ (putStrLn . drop 6)) path
  -- maybeLinks <- getLinks (fullLink "/wiki/Science")
  -- maybe (putStrLn "Error") (mapM_ print . take 20) maybeLinks


fullLink :: String -> String
fullLink end = "https://en.wikipedia.org" ++ end


linkPath :: String -> [String] -> String -> IO (Maybe [String])
linkPath end visited page | done = do
                              putStr "\n" >> hFlush stdout
                              return . return . reverse $ page : visited
                          | otherwise = do
                              -- putStr "." >> hFlush stdout
                              putStrLn . drop 6 $ page
                              links <- getLinks . fullLink $ page
                              let nextPage = links >>= find valid
                              maybe (return Nothing) (linkPath end (page : visited)) nextPage
  where
    done = page == end || page `elem` visited
    valid link = not $ isInfixOf "Help:IPA" link || isInfixOf "Wikipedia:" link
