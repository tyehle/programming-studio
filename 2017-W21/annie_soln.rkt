; Annie's soln to the INSANELY STUPID "tourist shopping cart problem"
#lang racket
(require rackunit)


; ~~~~~~~~~vvvv BORING HELPER FUNCTIONS vvvv~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(define (make-some-money elem) (match elem
              ['OH      300]
              ['BC      110]
              ['BC-disc 90]
              ['SK      30]
              [_         "the fuck is this?"]))
;-------
(define (total input-list)
    (sum (map (λ (x) (make-some-money x)) input-list)))
;-------
; what is this, 200 BC?
(define (sum L)
  (apply + L))
;-------

; short hand because oh my god so much list filtering
(define (get what input-list)
  (filter (λ (x) (equal? x what)) input-list))
(define (get-not what input-list)
  (filter (λ (x) (not (equal? x what))) input-list))
;-------
; bc wtf why is drop not safe? IT'S SAFE IN HASKELL
(define (safe-drop how-many input-list)
    (drop input-list (min (length input-list) how-many)))
;-------
; a common action: filter out the ones we don't need and append them back onto the whole list
(define (drop-activity input-list activity how-many)
  (append
     (get-not activity input-list)
     (safe-drop how-many (get activity input-list))))

;---------------------------------------------------------------------------------
; unit tests for all the helper functions
(check-equal? (get 2 '(1 2 3)) '(2))
(check-equal? (get 2 '(2 1 2 3 2)) '(2 2 2))
(check-equal? (get-not 2 '(1 2 3)) '(1 3))
(check-equal? (get-not 2 '(2 1 2 3 2)) '(1 3))
(check-equal? (safe-drop 2 '(1)) '())
(check-equal? (safe-drop 2 '(1 2)) '())
(check-equal? (safe-drop 2 '(1 2 3)) '(3))
(check-equal? (drop-activity '(2 1 2 3 2) 2 1) '(1 3 2 2))
(check-equal? (drop-activity '(2 1 2 3 2) 2 2) '(1 3 2))
(check-equal? (drop-activity '(2 1 2 3 2) 2 40) '(1 3))
;---------------------------------------------------------------------------------




; ~~~~~~~~~vvvv THIS IS WHAT WE CAME FOR vvvv~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(define (a-for-the-price-of-b-discount a b activity input-list)
  (drop-activity input-list activity (* (- a b)  ; this is how much the discount is, ie if it's 7-for-5 then the discount is 2
                                        (quotient (length (get activity input-list)) a)))) ; how times did we see "activity" a times?
;-------
(define (buy-a-get-b-free a b input-list)
  (let* ([As (get a input-list)]
         [Bs (get b input-list)])
    (drop-activity input-list b (length As)))) ; get rid of as many b's as there are a's 

;-------
(define (apply-bulk-discount activity truckloads-for-bulk input-list)
  (let* ([discounted (match activity
                      ['BC 'BC-disc] ; get the right discount symbol for what we want to discount- 
                      [_ "this puzzle sucks and there are no other discounts"])]
        [number-discounted (length (get activity input-list))])  ;     because this puzzle is stupid our only option is 'BC
    
    (if (> number-discounted truckloads-for-bulk) ; do we qualify?
        (append (drop-activity input-list activity number-discounted) ; if yes, get rid of all the old un-discounted ones 
                (build-list (length (get activity input-list)) (λ (x) discounted))) ; and add that many discounted ones 
        input-list)))                                       ; if no, the carry on about your day


;---------------------------------------------------------------------------------
; unit tests for all the important functions
(check-equal? (buy-a-get-b-free 'OH 'SK '(OH OH SK SK SK)) '(OH OH SK))
(check-equal? (buy-a-get-b-free 'OH 'SK (list 'OH 'OH)) '(OH OH))
(check-equal? (buy-a-get-b-free 'OH 'SK (list 'SK 'SK)) '(SK SK))
;
(check-equal? (a-for-the-price-of-b-discount 3 2 'OH (list 'OH 'OH 'OH)) '(OH OH))
(check-equal? (a-for-the-price-of-b-discount 3 1 'OH (list 'OH 'OH 'OH)) '(OH))
(check-equal? (a-for-the-price-of-b-discount 3 1 'OH (list 'OH 'OH 'OH 'OH 'OH)) '(OH OH OH))
(check-equal? (a-for-the-price-of-b-discount 3 1 'OH (list 'OH 'OH 'OH 'OH)) '(OH OH))
(check-equal? (a-for-the-price-of-b-discount 5 3 'OH (list 'OH 'OH 'OH 'OH 'OH)) '(OH OH OH))
;
(check-equal? (apply-bulk-discount 'BC 4 (list 'BC 'BC 'BC)) '(BC BC BC))
(check-equal? (apply-bulk-discount 'BC 4 (list 'BC 'BC 'BC 'BC 'BC)) '(BC-disc BC-disc BC-disc BC-disc BC-disc))
(check-equal? (apply-bulk-discount 'BC 1 (list 'OH 'BC 'AAC 'SCUBA 'BC)) '(OH AAC SCUBA BC-disc BC-disc))
;---------------------------------------------------------------------------------




;; #####@@@@****&&&&  ROCK_&_ROLL  &&&&&*****@@@@@#########

; We are going to have a 3 for 2 deal on opera house ticket. For example, if you buy 3 tickets, you will pay the price of 2 only getting another one completely free of charge.
; We are going to give a free Sky Tower tour for with every Opera House tour sold
; The Sydney Bridge Climb will have a bulk discount applied, where the price will drop $20, if someone buys more than 4
(define disc1 (λ (x) (a-for-the-price-of-b-discount 3 2 'OH x)))
(define disc2 (λ (x) (buy-a-get-b-free 'OH 'SK x)))
(define disc3 (λ (x) (apply-bulk-discount 'BC 4 x)))

;OH, OH, OH, BC  =  710.00
;OH, SK  = 300.00
;BC, BC, BC, BC, BC, OH = 750

; real talk:
(define tests (list '(OH OH OH BC)
                    '(OH SK)
                    '(BC BC BC BC BC OH)))
(check-equal? (map (λ (x) (total(disc3 (disc2 (disc1 x))))) tests) '(710 300 750))


; "challenge input"
(define challenge-tests (list '(OH OH OH BC SK)
                              '(OH BC BC SK SK)
                              '(BC BC BC BC BC BC OH OH)
                              '(SK SK BC)))
(map (λ (x) (total (disc3 (disc2 (disc1 x))))) challenge-tests)
; --> '(710 550 1140 170)

