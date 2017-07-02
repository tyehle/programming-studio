module Main where

import System.IO (hFlush, stdout)

import Scraper (getLinks)

main :: IO ()
main = do
  path <- linkPath "/wiki/Philosophy" [] "/wiki/Molecule"
  maybe (putStrLn "Error") (mapM_ putStrLn) path
  -- maybeLinks <- getLinks (fullLink "/wiki/Science")
  -- maybe (putStrLn "Error") (mapM_ print . take 20) maybeLinks


fullLink :: String -> String
fullLink end = "https://en.wikipedia.org" ++ end


headMaybe :: (Foldable f) => f a -> Maybe a
headMaybe = foldr (\x _ -> return x) Nothing


linkPath :: String -> [String] -> String -> IO (Maybe [String])
linkPath end visited page | done = do
                              putStr "\n" >> hFlush stdout
                              return . return . reverse $ page : visited
                          | otherwise = do
                              putStr "." >> hFlush stdout
                              -- putStrLn page
                              links <- getLinks . fullLink $ page
                              let nextPage = links >>= headMaybe
                              maybe (return Nothing) (linkPath end (page : visited)) nextPage
  where
    done = page == end || page `elem` visited
