package main

import org.scalatest.{FlatSpec, Matchers}

import Main._

/**
 * @author Tobin Yehle
 */
class MainSpec extends FlatSpec with Matchers {
  "Main" should "accept a command line argument" in {
    parseCommandLine(Array()) shouldBe None
    parseCommandLine(Array("hi")) shouldBe None
    parseCommandLine(Array("1", "3")) shouldBe None
    parseCommandLine(Array("666")) shouldBe Some(666)
  }

  it should "find the largest palindrome" in {
    largestPalindrome(1) shouldBe (3, 3)
    largestPalindrome(2) shouldBe (99, 91)
  }

  "The pair generator" should "work for small examples" in {
    Main.pairs(4, 2).toList shouldBe List((4, 4), (4, 3), (3, 3), (4, 2), (3, 2), (2, 2))
  }
}
