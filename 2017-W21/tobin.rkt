#lang racket

(module+ test
  (require rackunit))

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

(define (opera-deal tickets)
  (list tickets))

(define (tower-deal tickets)
  (list tickets))

(define (bridge-deal tickets)
  (list tickets))

(define (flat-map fn xs)
  (apply append (map fn xs)))

(module+ test
  (check-equal? (flat-map (λ (n) (make-list n n)) '(1 2 3)) '(1 2 2 3 3 3)))

(define (min-price tickets)
  (let* ([all-possible (flat-map opera-deal
                                 (flat-map tower-deal
                                           (flat-map bridge-deal
                                                     (list tickets))))]
         [all-prices (map (λ (ts) (apply + (map price ts)))
                          all-possible)])
    (apply min all-prices)))