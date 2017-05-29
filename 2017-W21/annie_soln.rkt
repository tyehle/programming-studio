#lang racket
; Annie's soln to the INSANELY STUPID "tourist shopping cart problem"
(require rackunit)

(define (make-some-money elem) (match elem
              ['OH      300]
              ['BC      110]
              ['BC-disc 90]
              ['SK      30]
              [_         "the fuck is this?"]))


;(map make-some-money (list 'OH 'OH 'BC 'SK 'BC-disc))

; short hand because oh my god so much list filtering
(define (get what input-list)
  (filter (λ (x) (equal? x what)) input-list))
(define (get-not what input-list)
  (filter (λ (x) (not (equal? x what))) input-list))

; bc wtf why is drop not safe? IT'S SAFE IN HASKELL
(define (safe-drop how-many input-list)
    (drop input-list (min (length input-list) how-many)))

; a common action: filter out the ones we don't need and append them back onto the whole list
(define (drop-activity input-list activity how-many)
  (append
     (get-not activity input-list)
     (safe-drop how-many (get activity input-list))))

(define (a-for-b-discount a b activity input-list)
  (drop-activity input-list activity (quotient (length (get activity input-list)) b)))
  ;  (append
  ;   (get-not activity input-list)
  ;   (safe-drop (quotient (length (get activity input-list)) b) (get activity input-list))))

; (buy-a-get-b-free 'OH 'SK '(OH OH SK SK SK)) --> '(OH OH SK)
; (buy-a-get-b-free 'OH 'SK (list 'OH 'OH))    --> '(OH OH)
; (buy-a-get-b-free 'OH 'SK (list 'SK 'SK))    --> '(SK SK)
(define (buy-a-get-b-free a b input-list)
  (let* ([As (get a input-list)]
           [Bs (get b input-list)])
    (drop-activity input-list activity (length As))))
           ;[discounted-Bs (drop Bs (min (length Bs) (length As)))]) ; drop as many "b"s as we can- so either the number of a's or all of them! 
    ;(append (get-not b input-list) discounted-Bs))) ; add on the new b's list onto our (inputlist - b's)


; (apply-bulk-discount 'BC 4 (list 'BC 'BC 'BC))           --> '(BC BC BC)
; (apply-bulk-discount 'BC 4 (list 'BC 'BC 'BC 'BC 'BC))   --> '(BC-disc BC-disc BC-disc BC-disc BC-disc)
(define (apply-bulk-discount activity truckloads-for-bulk input-list)
  (let ([discounted (match activity
                      ['BC 'BC-disc] ; get the right discount symbol for what we want to discount- 
                      [_ "this puzzle sucks and there are no other discounts"])])  ;     because this puzzle is stupid our only option is 'BC
    (if (> (length (get activity input-list)) truckloads-for-bulk) ; do we qualify?
        (build-list (length input-list) (λ (x) discounted)) ; if yes, then discount all of them  TODO THIS IS WRONG
        input-list)))                                       ; if no, the carry on about your day




;; #####@@@@****&&&&  ROCK_&_ROLL  &&&&&*****@@@@@#########

(define tests (list (list 'OH 'OH 'OH 'BC) (list 'OH 'SK) (list 'BC 'BC 'BC 'BC 'BC 'OH)))
(define test (list 'OH 'OH 'OH 'BC))