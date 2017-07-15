package main

import scala.collection.AbstractIterator

/**
 * @author Tobin Yehle
 */
sealed abstract class SkewHeap[A](implicit val ordering: Ordering[A]) extends Iterable[A] {
  def isEmpty: Boolean
  def nonEmpty: Boolean
  def size: Int

  def first: A
  def firstOption: Option[A]
  def rest: SkewHeap[A]
  def firstView: Option[(A, SkewHeap[A])]

  def add(elem: A): SkewHeap[A]
  def merge(other: SkewHeap[A]): SkewHeap[A]

  // TODO: take and drop?
}

object SkewHeap {
  case class Empty[A](implicit override val ordering: Ordering[A]) extends SkewHeap[A] {
    override def isEmpty: Boolean = true
    override def nonEmpty: Boolean = false
    override def size: Int = 0

    override def first: A = throw new NoSuchElementException("First on empty heap")
    override def firstOption: Option[A] = None
    override def rest: SkewHeap[A] = throw new NoSuchElementException("Rest on empty heap")
    override def firstView: Option[(A, SkewHeap[A])] = None

    override def add(elem: A): SkewHeap[A] = Node(elem, this, this)
    override def merge(other: SkewHeap[A]): SkewHeap[A] = other

    override def iterator: Iterator[A] = Iterator.empty
  }

  case class Node[A](elem: A, left: SkewHeap[A], right: SkewHeap[A])
                    (implicit override val ordering: Ordering[A])
    extends SkewHeap[A] { self =>

    override def isEmpty: Boolean = false
    override def nonEmpty: Boolean = true
    override def size: Int = 1 + left.size + right.size

    override def first: A = elem
    override def firstOption: Option[A] = Some(elem)
    override def rest: SkewHeap[A] = left.merge(right)
    override def firstView: Option[(A, SkewHeap[A])] = Some((elem, left merge right))

    override def add(elem: A): SkewHeap[A] = merge(Node(elem, empty, empty))
    override def merge(other: SkewHeap[A]): SkewHeap[A] = other match {
      case Empty() => this
      case Node(e, l, r) =>
        if(ordering.gteq(elem, e)) Node(elem, right.merge(other), left)
        else Node(e, r.merge(this), l)
    }

    override def iterator: Iterator[A] = new AbstractIterator[A] {
      private var state: SkewHeap[A] = self
      override def hasNext: Boolean = state.nonEmpty
      override def next(): A = state.firstView match {
        case None => Iterator.empty.next()
        case Some((first, rest)) => state = rest; first
      }
    }
  }

  def empty[A](implicit ord: Ordering[A]): SkewHeap[A] = Empty()

  def apply[A](elems: A*)(implicit ord: Ordering[A]): SkewHeap[A] = {
    elems.foldLeft(empty[A])((heap, elem) => heap.add(elem))
  }
}
