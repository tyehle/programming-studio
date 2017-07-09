package main

import util.control.Exception.allCatch

/**
 * @author Tobin Yehle
 */
object Main {
  def main(args: Array[String]): Unit = {
    val n:Int = (args match {
      case Array(number) => allCatch.opt(number.toInt)
      case _ => None
    }).getOrElse({println("enter a single number"); sys.exit(1)})

    process(n)
  }

  def process(n: Int): Unit = {

  }
}
