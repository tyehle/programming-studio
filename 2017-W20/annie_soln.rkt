#lang racket
; Annie's solution to the "lexicographically minimal string rotation" problem


; returns the list rotated right by 1
; so [1 2 3] --> [2 3 1]
(define (rotate input-list)
    (append (rest input-list) (list (first input-list))))

; returns a list of all rotations of a list, paired with their "rotation index"
; so [1 2 3] --> [([1 2 3] . 1) ([2 3 1] . 2) ([3 1 2] . 3)]
(define (get-rotations input-list)
  (begin ; inside worker function with "fuel" arg
    (define (get-rotations-inner data-list fuel)
      (if (equal? 1 fuel) ; are we done?
          (list (cons data-list (- (length data-list) fuel)))  ; return the rotation & the rotation index
          (cons (cons data-list (- (length data-list) fuel))   ; cons on the current, and 
                (get-rotations-inner (rotate data-list) (- fuel 1))))))  ; recursive call with rotated data & one fewer fuels
    (get-rotations-inner input-list (length input-list))) ; call the worker


(define (find-smallest-garland test-string)
  (first (sort (map ; grab the smallest from the sorted list
                (lambda (in-list) (cons (list->string (car in-list)) (cdr in-list))) ; just type fiddling
                (get-rotations (string->list test-string))) ; list of all rotations
               string<? #:key car))) ; sort by key less-than of the first thing in the pair (ie the list)


;; ~~~~~~~~~~~~~`` ** SHOWTIME! ** ''~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(define tests '("onion" "bbaaccaadd" "alfalfa" "weugweougewoiheew" "pneumonoultramicroscopicsilicovolcanoconiosis"))
(define results (map (lambda (x) (find-smallest-garland x)) tests))

(map (lambda (result) (begin (print (cdr result)) (pretty-print (car result)))) results)




