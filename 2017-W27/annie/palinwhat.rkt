#lang racket
(require memoize)


; dynamic programming

; compute-product( x y ):
;    return max( filter palindrome? [x*y, compute-produce(x*(y-1)), compute-product((x-1)*y)]   )


(define/memo* (compute-product x y)
  (apply max (filter palindrome? `(,(* x y) ,(compute-product x (- y 1)) ,(compute-product (- x 1) y)  )))
 )

(define (palindrome? x) #t)


(define n 1)
(define init (range (- (expt 10 n) 1) 2 -1))

(compute-product init init)