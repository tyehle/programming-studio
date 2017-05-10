#lang racket
(require Racket-miniKanren/miniKanren/mk)

(module+ test (require rackunit))

(define (subsumo nums out)
  (conde
   ((== nums '())
    (== out #f))
   
   ((fresh (x xs matched)
      (== nums (cons x xs))
      (check-rest x xs matched)
      (conde
       ((== matched #t) (== out #t))
       ((== matched #f) (subsumo xs out)))))))

(define (check-rest n rest matched)
  (conde
   ((== rest '())
    (== matched #f))

   ((fresh (x xs neg-x)
      (== rest (cons x xs))
      (=neg= x neg-x)
      (conde
       ((== n neg-x)
        (== matched #t))
       
       ((=/= n neg-x)
        (check-rest n xs matched)))))))

(define (=neg= a b)
  (fresh (a-neg a-num b-neg b-num)
    (== (cons a-neg a-num) a)
    (== (cons b-neg b-num) b)
    (== a-num b-num)
    (conde
     ((== a-neg #f) (== b-neg #t))
     ((== a-neg #t) (== b-neg #f)))))

(define (subsum nums)
  (let ([paired (map (λ (num) (cons (> 0 num) (abs num))) nums)])
    (match (run* (q) (subsumo paired q))
      [`(,result) result]
      [else (error "Something is wrong")])))

(module+ test
  (check-equal? (subsum '(-5 -3 -1 2 4 6)) #f)
  (check-equal? (subsum '()) #f)
  (check-equal? (subsum '(-1 1)) #t)
  (check-equal? (subsum '(0)) #t)
  (check-equal? (subsum '(-97364 -71561 -69336 19675 71561 97863)) #t)
  (check-equal? (subsum '(-53974 -39140 -36561 -23935 -15680 0)) #t))