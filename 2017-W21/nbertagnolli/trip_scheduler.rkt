#lang racket
(require rackunit)

; ------------------------------------------------------------------------------------------
; Helper Methods
; ------------------------------------------------------------------------------------------
; Pack duplicats in a list
(define (pack lst)
  (foldr (lambda (x y) (cond
                         [(or (empty? y) (not (equal? x (first (first y))))) (cons (list x) y)]
                         [else (cons (cons x (first y)) (rest y))])) empty lst))

; Run length encoding
(define (run-length-encoding lst)
  (map (lambda (x) (list (first x) (length x))) (pack lst)))


; ------------------------------------------------------------------------------------------
; Define trip database
; ------------------------------------------------------------------------------------------
(define trip-options
  (hash "OH" 300.0
        "BC" 110.0
        "SK" 30.0))

; ------------------------------------------------------------------------------------------
; Define specialty rules
; Each rule will operate on a list of strings and return a price modifier.  For example given
; OH SK free-sky-bridge will return -30.0
; ------------------------------------------------------------------------------------------

; This helper creates a list where the first element is the number of OH bookings and
; the second element is the number of sk bookings.  It takes a list of Strings
(define (sky-bridge-helper lst)
  (flatten (match lst
             ['() '()]
             [(cons (cons "OH" a) t) (cons a (sky-bridge-helper t))]
             [(cons (cons "SK" a) t) (cons a (sky-bridge-helper t))]
             [(cons _ t) (cons '() (sky-bridge-helper t))])))

(define (free-sky-bridge lst)
  (let ([flat-lst (sky-bridge-helper lst)])
  ; If more OH than SK subtract all SK values
  (cond [(and (> (length flat-lst) 1) (>= (first flat-lst) (last flat-lst)))
         (- 0 (* (last flat-lst) (hash-ref trip-options "SK")))]
        [else 0.0])))  ; Otherwise return 0 as a cost modifier


; Define Opera house discount
; Buy three OH tickets get 1 free
(define (opera-house-helper lst)
  (flatten (match lst
             ['() '()]
             [(cons (cons "OH" a) t) (cons a (opera-house-helper t))]
             [(cons _ t) (cons '() (opera-house-helper t))])))


(define (opera-house-discount lst)
  (let ([flat-lst (opera-house-helper lst)])
  ; If opera house is greater than 3 then give one free for every 3 purchased
  (cond [(and (>= (length flat-lst) 1)) (* (quotient (first flat-lst) 3) -1.0 (hash-ref trip-options "OH"))]
        [else 0.0])))  ; Otherwise return 0 as a cost modifier


; Define Bridge Climb Discount
; If BC > 4 then the price drops by $20
(define (bridge-climb-helper lst)
  (flatten (match lst
             ['() '()]
             [(cons (cons "BC" a) t) (cons a (bridge-climb-helper t))]
             [(cons _ t) (cons '() (bridge-climb-helper t))])))

(define (bridge-climb-discount lst)
  (let ([flat-lst (bridge-climb-helper lst)])
  ; If BC >=4 then subtract $20 from all prices
  (cond [(and (>= (length flat-lst) 1) (>= (first flat-lst) 4)) (* (first flat-lst) -20.0)]
        [else 0.0])))  ; Otherwise return 0 as a cost modifier

; ------------------------------------------------------------------------------------------
; Create the main booking method
; ------------------------------------------------------------------------------------------

; Calculate the total unadjusted booking cost
(define (calculate-total lst)
  (foldl (lambda (x result) (+ result (* (last x) (hash-ref trip-options (first x))))) 0 lst))
(check-equal? (calculate-total '(("OH" 2) ("BC" 1))) 710.0)


; Create a method with explicit discount rules
(define (book-trip lst)
  (let ([run-length (run-length-encoding (sort lst string<?))])
    (+ (calculate-total run-length)  ; Calculate the total cost
       (free-sky-bridge run-length)  ; subtract the sky bridge promotion
       (bridge-climb-discount run-length)  ; Subtract the bulk bridge climb discount
       (opera-house-discount run-length)
       )))

; Implement with let* which let's everything previously defined stay in scope.

; A better approach would be to create a method which applies a list of discount functions
(define (apply-discounts lst discounts)
  (let ([run-length (run-length-encoding (sort lst string<?))])
    (foldl (lambda (f result) (+ result (f run-length))) 0 discounts)))


; ------------------------------------------------------------------------------------------
; Test cases
; ------------------------------------------------------------------------------------------

; Test helper methods
(check-equal? (pack '()) '())
(check-equal? (pack '(a a a a b c c a a d e e e e)) '((a a a a) (b) (c c) (a a) (d) (e e e e)))
(check-equal? (run-length-encoding  '(a a a a b c c a a d e e e e)) '((a 4) (b 1) (c 2) (a 2) (d 1) (e 4)))


; Test skybridge discounts and helpers
(check-equal? (sky-bridge-helper '(("OH" 4) ("SK" 2) ("PP" 1))) '(4 2))
(check-equal? (free-sky-bridge '(("OH" 4) ("SK" 2) ("PP" 1))) -60.0)
(check-equal? (free-sky-bridge '(("OH" 4) ("PP" 1))) 0.0)

; Test opera house discounts and helpers
(check-equal? (opera-house-helper '(("OH" 4) ("SK" 2) ("PP" 1))) '(4))
(check-equal? (opera-house-discount '(("OH" 4) ("SK" 2) ("PP" 1))) -300.0)
(check-equal? (opera-house-discount '(("OH" 2) ("SK" 2) ("PP" 1))) 0)
(check-equal? (opera-house-discount '(("OH" 7) ("SK" 2) ("PP" 1))) -600.0)

; Test bridge climbing discount methods and helpers
(check-equal? (bridge-climb-helper '(("BC" 4) ("SK" 2) ("PP" 1))) '(4))
(check-equal? (bridge-climb-discount '(("BC" 4) ("SK" 2) ("PP" 1))) -80.0)
(check-equal? (bridge-climb-discount '(("OH" 4) ("PP" 1))) 0.0)
(check-equal? (bridge-climb-discount '(("BC" 3) ("PP" 1))) 0.0)

; Test Final booking method
(check-equal? (book-trip (list "OH" "OH" "OH" "BC")) 710.0 "Should be 710.0")
(check-equal? (book-trip (list "OH" "SK")) 300.0 "Should be 300.0")
(check-equal? (book-trip (list "BC" "BC" "BC" "BC" "BC" "OH")) 750.0 "Should be 750.0")
(check-equal? (book-trip (list "OH" "OH" "OH" "BC" "SK")) 710.0)
(check-equal? (book-trip (list "OH" "BC" "BC" "BC" "SK")) 630.0)
(check-equal? (book-trip (list "SK" "SK" "BC")) 170.0)

; Test Final booking via function lists
(check-equal? (apply-discounts (list "OH" "OH" "OH" "BC" "SK")
                               (list calculate-total
                                     free-sky-bridge
                                     bridge-climb-discount
                                     opera-house-discount)) 710.0 "Should be 710.0")

(check-equal? (apply-discounts (list "OH" "BC" "BC" "BC" "SK")
                               (list calculate-total
                                     free-sky-bridge
                                     bridge-climb-discount
                                     opera-house-discount)) 630.0 "Should be 630.0")
