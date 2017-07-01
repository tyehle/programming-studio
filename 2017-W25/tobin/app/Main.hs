{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.List (isPrefixOf)
import Text.HTML.Scalpel

import Scraper

main :: IO ()
main = do
  result <- getLinks "https://en.wikipedia.org/wiki/science"
  maybe (putStrLn "Error") (mapM_ print . take 20) result


getLinks :: URL -> IO (Maybe [String])
getLinks url = scrapeURL url scraper
  where
    internal = isPrefixOf "/wiki/"
    selectBody = "div" @: ["id" @= "mw-content-text"]
    scraper = do
      allLinks <- attrs "href" $ selectBody // "p" // "a"
      return . filter internal $ allLinks
