{-# LANGUAGE OverloadedStrings #-}
module Scraper where

import Data.List (isPrefixOf)
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
  inners <- innerHTMLs $ "div" @: ["id" @= "mw-content-text"] // "p"
  return . concat $ inners


dropParens :: String -> Maybe String
dropParens = either (const Nothing) Just . parse (parser <* eof) "function input"
  where
    parser = do
      before <- many $ noneOf "()"
      after <- (parenParser >> parser) <|> return ""
      return $ before ++ after
    parenParser = void $ between (char '(') (char ')') parser
