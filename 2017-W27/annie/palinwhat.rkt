#lang racket
(require rackunit)
(require memoize)

; DID SOMEONE SAY dynamic programming

; compute-product( x y ):
;    return max( filter palindrome? [x*y, compute-produce(x*(y-1)), compute-product((x-1)*y)]   )

;~~~~~ HELPERS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; stolen from SO because listifying a number is boring
; https://stackoverflow.com/questions/8014453/convert-number-to-list-of-digits
(require srfi/1 srfi/26)
(define (digits->list num (base 10))
  (unfold-right zero? (cut remainder <> base) (cut quotient <> base) num))

; take a *integer* and determines whether it is a palindrome
(define (palindrome? x) (equal? (digits->list x) (reverse (digits->list x))))

; a max that works on lists *and* doesn't throw runtime errors on empty lists!! What more could you want?
(define (safe-list-max xs)
  (if (empty? xs)
   -1
   (apply max xs) ; can't take max of nothing!
))

; but does it work?? FUCK YEAH IT WORKS
(check-equal? (safe-list-max '(232 484 0)) 484)
(check-equal? (safe-list-max '()) -1)


;~~~~~ THE GOODS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(define/memo* (compute-product x y)
  (let ([smaller (if (< x y) x y)]  ; Always pass in the bigger-ish one to avoid duplicating symmetric calls
        [other   (if (< x y) y x)])
  (if ( > 3 x) ; TERMINATED!
      (* 3 x) 
      (if (> 3 y) ; ALSO TERMINATED!
          9       ; awh yeah get that memoized brute force solution!
          (safe-list-max (filter palindrome? `(,(* x y) ,(compute-product (- other 1) smaller) ,(compute-product other (- smaller 1))))))) 
 ))

; tests
(check-equal? (compute-product 9 9) 9)
(check-equal? (compute-product 99 99) 9009)
;(check-equal? (compute-product 999 999) 906609) ; Commented out because it's a wee bit slow





; woah wait there was a problem spec???
(define (SOLVE-THE-PROBLEM n)
  (let ([init (- (expt 10 n) 1)])
       (compute-product init init)))


