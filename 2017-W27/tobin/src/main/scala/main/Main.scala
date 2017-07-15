package main

import scala.collection.mutable
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

  /**
   * Generate a list of pairs in order of their product
   * @param high The largest value in the pair
   * @param low The smallest value in the pair
   */
  def pairs(high: Int, low: Int): Stream[(Int, Int)] = {
    case class Pair(a: Int, b: Int) extends Ordered[Pair] {
      lazy val product: Int = a*b
      override def compare(that: Pair): Int = product compare that.product
    }

    val fringe = new mutable.PriorityQueue[Pair]()
    fringe.enqueue((low to high).map(Pair(high, _)): _*)

    println(s"Starting with $fringe")

    def genStream(): Stream[(Int, Int)] = {
      if(fringe.isEmpty) {
        Stream.empty
      }
      else {
        val Pair(a, b) = fringe.dequeue()
        println(s"Got ${(a, b)}")
        if(a > b) {
          fringe.enqueue(Pair(a -1, b))
          println(s"Added ${(a - 1, b)}")
        }
        (a, b) #:: genStream()
      }
    }

    genStream()
  }
}
