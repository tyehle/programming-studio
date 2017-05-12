import scala.collection.mutable
import scala.io.Source

object Main {
  val cache = mutable.Map.empty[Vector[Int], String]

  def memSearch(words: Vector[String], positions: Vector[Int]): String = {
    if(cache.contains(positions))
      cache(positions)
    else {
      val result = search(words, positions)
      cache(positions) = result
      result
    }
  }

  def search(words: Vector[String], positions: Vector[Int]): String = {
    val choices = positions.zip(words).flatMap{ case (pos, word) =>
      if(pos == word.length) None
      else Some(word(pos))
    }.toSet

    if(choices.isEmpty) {
      ""
    } else {
      choices.map { char =>
        char +: memSearch(words, positions.zip(words).map { case (pos, word) =>
          if (pos == word.length || word(pos) != char) pos
          else pos + 1
        })
      }.minBy(_.length())
    }
  }

  lazy val enable1: Iterator[String] = {
    Source.fromFile("enable1.txt").getLines()
  }

  def main(args: Array[String]): Unit = {
    val words = Vector("one", "two", "three", "four", "five")
//    val words = enable1.take(20).toVector
    val answer = memSearch(words, words.map(_ => 0))
    println(answer)
    println(s"length: ${answer.length}")
    println(s"num calls: ${cache.size}")
  }
}
