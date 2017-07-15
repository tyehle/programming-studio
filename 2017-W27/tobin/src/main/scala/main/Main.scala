package main

import util.control.Exception.allCatch

/**
 * @author Tobin Yehle
 */
object Main {
  def main(args: Array[String]): Unit =
    parseCommandLine(args).extract(println(s"Got ${args.mkString(", ")}, expected a single number"),
                                   n => println(largestPalindrome(n)))

  /** Define extract for options. This is like haskell's maybe function. */
  implicit class FancyOption[+A](val inner: Option[A]) {
    def extract[B](default: => B, conversion: A => B): B = inner.map(conversion).getOrElse(default)
  }

  /**
   * Try to parse the command line args
   */
  def parseCommandLine(args: Array[String]): Option[Long] = {
    args match {
      case Array(number) => allCatch.opt(number.toLong)
      case _             => None
    }
  }

  def largestPalindrome(n: Long): Long = {
    val high = math.pow(10, n).toInt - 1
    val low = math.pow(10, n-1).toInt
    products(high, low).find(intIsPalindrome).getOrElse(throw new RuntimeException("No palindrome found"))
  }

  @inline
  def intIsPalindrome(n: Long): Boolean = isPalindrome(n.toString)

  @inline
  def isPalindrome(s: String): Boolean = s.zip(s.reverse).forall(pair => pair._1 == pair._2)

  /**
   * Generate a list of pairs in order of their product
   * @param high The largest value in the pair
   * @param low The smallest value in the pair
   */
  def products(high: Long, low: Long): Stream[Long] = {
    case class Pair(a: Long, b: Long) extends Ordered[Pair] {
      override def compare(that: Pair): Int = (a*b) compare (that.a * that.b)
    }

    def genStream(fringe: SkewHeap[Pair]): Stream[Long] = fringe.firstView match {
      case None => Stream.empty
      case Some((Pair(a, b), rest)) => (a * b) #:: genStream(if(a > b) rest.add(Pair(a-1, b)) else rest)
    }

    genStream(SkewHeap((low to high).map(Pair(high, _)): _*))
  }
}
