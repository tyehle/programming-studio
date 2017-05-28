#lang racket

(module+ test
  (require rackunit))

(define (debug x)
  (println x)
  x)

(define (price item)
  (match item
    [(? number?) item]
    ["OH" 300]
    ["BC" 110]
    ["SK" 30]))

(module+ test
  (check-equal? (price 12) 12)
  (check-equal? (price "OH") 300)
  (check-equal? (price "BC") 110)
  (check-equal? (price "SK") 30))

;; Define the deals

(define (opera-deal tickets)
  (let* ([n        (count (curry equal? "OH") tickets)]
         [discount (* -1 (price "OH") (quotient n 3))])
    (cons discount tickets)))

(define (tower-deal tickets)
  (let* ([towers   (count (curry equal? "SK") tickets)]
         [operas   (count (curry equal? "OH") tickets)]
         [discount (* -1 (price "SK") (if (> towers operas) operas towers))])
    (cons discount tickets)))

(define (bridge-deal tickets)
  (let* ([n        (count (curry equal? "BC") tickets)]
         [discount (if (> n 4) (* -20 n) 0)])
    (cons discount tickets)))

(define deals
  (list opera-deal
        tower-deal
        bridge-deal))

;; Process a list of tickets

(define (total-price tickets)
  (apply + (map price (foldl (λ (deal tiks) (deal tiks))
                             tickets
                             deals))))

(module+ test
  (check-equal? (total-price '("OH" "OH" "OH" "BC")) 710)
  (check-equal? (total-price '("OH" "SK")) 300)
  (check-equal? (total-price '("BC" "BC" "BC" "BC" "BC" "OH")) 750))

;; Deal with input from stdin

(define orders
  (letrec ([all-lines (λ (lines)
                        (let ([line (read-line)])
                          (if (eq? line eof)
                              lines
                              (all-lines (cons line lines)))))])
    (reverse (all-lines null))))

(for ([line orders])
  (let ([tickets (string-split line)])
    (printf "~a = ~a~n" tickets (total-price tickets))))