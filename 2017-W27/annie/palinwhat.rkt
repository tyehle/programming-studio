#lang racket
(require memoize)

; stolen from SO because listifying a number is boring
; https://stackoverflow.com/questions/8014453/convert-number-to-list-of-digits
(require srfi/1 srfi/26)
(define (digits->list num (base 10))
  (unfold-right zero? (cut remainder <> base) (cut quotient <> base) num))

; dynamic programming

; compute-product( x y ):
;    return max( filter palindrome? [x*y, compute-produce(x*(y-1)), compute-product((x-1)*y)]   )


(define (safe-list-max xs)
  (if (empty? xs)
   -1
   (apply max xs) 
))
; tests
; (safe-list-max '(232 484 0)) => 484
; (safe-list-max '()) -> -1



(define/memo* (compute-product x y)
  (if ( > 3 x)
      (* 3 x)
      (if (> 3 y)
          9
          (safe-list-max (filter palindrome? `(,(* x y) ,(compute-product x (- y 1)) ,(compute-product (- x 1) y)))))
 ))
; tests
;(compute-product 9 9) => 9
;(compute-product 99 99) => 9009
; (compute-product 999 999) => 906609



;(define/memo* (compute-product x y)
;  (let ([smaller (if (< x y) x y)]
;        [larger  (if (< x y) y x)])
;   (apply max (filter palindrome? `(,(* x y) ,(compute-product smaller (- larger 1)) ,(compute-product (- smaller 1) larger)  )))
;))

; take a *integer* and determines whether it is a palindrome
(define (palindrome? x) (equal? (digits->list x) (reverse (digits->list x))))


(define n 1)
(define init (- (expt 10 n) 1))

;(compute-product init init)