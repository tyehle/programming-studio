#lang racket
(require Racket-miniKanren/miniKanren/mk)

(module+ test (require rackunit))

(define assocs1
  '((#\a . #\4)
    (#\b . #\6)
    (#\e . #\3)
    (#\i . #\1)
    (#\l . #\1)
    (#\o . #\0)
    (#\s . #\5)
    (#\t . #\7)))

(define (noneo a bs)
  (conde
   ((== bs '()))
   
   ((fresh (bh bt)
      (== `(,bh . ,bt) bs)
      (=/= a bh)
      (noneo a bt)))))

(define (conde* cs)
  (match cs
    ['()         (fresh (x) (=/= x x))]
    [(cons x xs) (conde ((fresh () x)) ((conde* xs)))]))

(define (leeto in out)
  (conde
   ((== in '())
    (== out '()))
   
   ((fresh (ih it oh ot)
      (== `(,ih . ,it) in)
      (== `(,oh . ,ot) out)
      (leeto it ot)
      (conde* (cons (fresh ()
                      (noneo ih (map car assocs1))
                      (noneo oh (map cdr assocs1))
                      (== ih oh))

                    (map (λ (pair) (fresh ()
                                     (== ih (car pair))
                                     (== oh (cdr pair))))
                         assocs1)))))))

(define (convert s)
  (let ([input (string->list s)])
    (map list->string
         (run* (q)
           (conde
            ((leeto q input))
            ((leeto input q)))))))

(module+ test
  (check-equal? (convert "elite") '("31173"))
  (check-equal? (convert "31173") '("eiite" "elite" "eilte" "ellte")))
