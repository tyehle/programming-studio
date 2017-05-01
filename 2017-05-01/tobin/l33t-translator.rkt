#lang racket
(require Racket-miniKanren/miniKanren/mk)

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

(define (unify-pairs a b pairs)
  (match pairs
    ['() (fresh (x) (=/= x x))]
    [`((,ap . ,bp) . ,tail)
     (conde
      ((== ap a)
       (== bp b))

      ((unify-pairs a b tail)))]))

(define (leeto in out)
  (conde
   ((== in '())
    (== out '()))
   
   ((fresh (ih it oh ot)
      (== `(,ih . ,it) in)
      (== `(,oh . ,ot) out)
      (leeto it ot)
      (conde
       ((unify-pairs ih oh assocs1))
       
       ((noneo ih (map car assocs1))
        (noneo oh (map cdr assocs1))
        (== ih oh)))))))

(define (convert s)
  (let ([input (string->list s)])
    (map list->string
         (run* (q)
           (conde
            ((leeto q input))
            ((leeto input q)))))))