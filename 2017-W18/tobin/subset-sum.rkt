#lang racket
(require Racket-miniKanren/miniKanren/mk)

(module+ test (require rackunit))

(define (subsumo nums out)
  (conde
   ((== nums '())
    (== out #f))
   
   ((fresh (x xs matched)
      (== nums (cons x xs))
      (conde
       ((is-zero x)
        (== out #t))

       ((not-zero x)
        (check-rest x xs matched)
        (conde
         ((== matched #t) (== out #t))
         ((== matched #f) (subsumo xs out)))))))))

(module+ test
  (check-equal? (run* (q) (subsumo `((#t . 5) (#f . 1) (#f . 7) ,q) #t))
                '((#f . 5) (#t . 1) (#t . 7) (#f . 0) (#t . 0)))
  (check-equal? (run* (q) (subsumo `(,q) #f))
                '(((_.0 . _.1) (=/= ((_.1 . 0)))))))

(define (is-zero n)
  (fresh (neg num)
    (== (cons neg num) n)
    (== num 0)))

(define (not-zero n)
  (fresh (neg num)
    (== (cons neg num) n)
    (=/= num 0)))

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
  (check-equal? (subsum '(1 1)) #f)
  (check-equal? (subsum '(0)) #t)
  (check-equal? (subsum '(-97364 -71561 -69336 19675 71561 97863)) #t)
  (check-equal? (subsum '(-53974 -39140 -36561 -23935 -15680 0)) #t))