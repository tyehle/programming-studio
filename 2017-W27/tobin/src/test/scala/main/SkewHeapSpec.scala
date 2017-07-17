package main

import org.scalatest.{Matchers, FlatSpec}

/**
 * @author Tobin Yehle
 */
class SkewHeapSpec extends FlatSpec with Matchers {
  "A SkewHeap" should "find max" in {
    SkewHeap.empty[Int].add(3).add(5).first shouldBe 5
    SkewHeap("ace":_*).first shouldBe 'e'
    SkewHeap.empty[Int].firstOption shouldBe None
  }

  it should "be in order" in {
    SkewHeap(2, 1, 3).toList shouldBe List(3, 2, 1)
  }

  it should "add" in {
    val heap = SkewHeap(2, 1, 3)
    heap.size shouldBe 3
    val bigger = heap.add(5)
    bigger.size shouldBe 4
    bigger.first shouldBe 5
  }

  it should "pop" in {
    val smaller = SkewHeap(2, 1, 3).rest
    smaller.size shouldBe 2
    smaller.first shouldBe 2
  }

  it should "merge" in {
    val merged = SkewHeap(4, 1) merge SkewHeap(0, 5)
    merged.size shouldBe 4
    merged.toList shouldBe List(5, 4, 1, 0)
  }
}
