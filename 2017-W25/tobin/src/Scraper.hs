{-# LANGUAGE OverloadedStrings #-}
module Scraper where

import Data.List (isPrefixOf)
import Data.Maybe (fromMaybe)
import Control.Monad (void)
import Text.HTML.Scalpel
import Text.Parsec
import Text.Parsec.Char


getLinks :: URL -> IO (Maybe [String])
getLinks url = do
  rawText <- scrapeURL url getPText
  let noParens = rawText >>= dropParens
  let links = noParens >>= flip scrapeStringLike linksFromText
  return links


linksFromText :: Scraper String [String]
linksFromText = filter internal <$> attrs "href" "a"
  where
    internal = isPrefixOf "/wiki/"


getPText :: Scraper String String
getPText = do
  inners <- innerHTMLs $ "div" @: ["id" @= "bodyContent"] // "p"
  return . concat $ inners


dropParens :: String -> Maybe String
dropParens input | '(' `elem` take 50 input = either (const Nothing) Just $ parse firstParenRemover "function input" input
                 | otherwise = Just input

firstParenRemover :: Parsec String () String
firstParenRemover = do
  before <- many $ noneOf "()"
  after <- parenParser >> getInput
  return $ before ++ after

allParenRemoveer :: Parsec String () String
allParenRemoveer = do
  before <- many $ noneOf "()"
  after <- (parenParser >> allParenRemoveer) <|> return ""
  return $ before ++ after

parenParser :: Parsec String () ()
parenParser = void $ between (char '(') (char ')') allParenRemoveer
