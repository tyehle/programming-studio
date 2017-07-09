package main

import util.control.Exception.allCatch

/**
 * @author Tobin Yehle
 */
object Main {
  def main(args: Array[String]): Unit =
    parseCommandLine(args).extract(println("enter a single number"), largestPalindrome)

  /** Define extract for options. This is like haskell's maybe function. */
  implicit class FancyOption[+A](val inner: Option[A]) {
    def extract[B](default: => B, conversion: A => B): B = inner.map(conversion).getOrElse(default)
  }

  /**
   * Try to parse the command line args
   */
  def parseCommandLine(args: Array[String]): Option[Int] = {
    args match {
      case Array(number) => allCatch.opt(number.toInt)
      case _             => None
    }
  }

  def largestPalindrome(n: Int): Unit = {
    ???
  }
}
