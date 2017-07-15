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
    largestPalindrome(1) shouldBe 9
    largestPalindrome(2) shouldBe 9009
    largestPalindrome(3) shouldBe 906609
    largestPalindrome(4) shouldBe 99000099
    largestPalindrome(5) shouldBe 9966006699L
  }

  "The product generator" should "work for small examples" in {
    Main.products(4, 2).toList shouldBe List(16, 12, 9, 8, 6, 4)
  }
}
