import Test.Tasty
import Test.Tasty.HUnit

import Rotations

main :: IO ()
main = defaultMain $ testGroup "Tests"
  [ testCase "1" $ rotateWord "onion" @?= (2, "ionon")
  , testCase "1" $ rotateWord "bbaaccaadd" @?= (2, "aaccaaddbb")
  , testCase "1" $ rotateWord "alfalfa" @?= (6, "aalfalf")
  , testCase "1" $ rotateWord "weugweougewoiheew" @?= (14, "eewweugweougewoih")
  , testCase "1" $ rotateWord "pneumonoultramicroscopicsilicovolcanoconiosis" @?= (12, "amicroscopicsilicovolcanoconiosispneumonoultr")
  ]
