; demo it at: https://repl.it/HWQl/57

abs [x] (max x (- x)))

(defn solveIt
  ([available todo] 
   (if (empty? available)
       " JOLLY"
       (do
       (def dif (abs (- (first todo) (first (rest todo))))) ; what is the abs difference?
       (if (= dif (some #{dif} available)) ; do we already have this difference?
         (recur (remove #{dif} available) (rest todo))
         " NOT JOLLY"))))
  ([test]
    ; makes a list [1...(n-1)], "rest" drops a leading 0
   (solveIt (rest (take (count test) (range))) test))
)

(defn solveAndPrint
  ([inputs]
    (def solns (map (fn [x] (solveIt (rest x))) inputs))
    (map (fn [x y] (apply print x) (println y)) inputs solns )
  ))

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;        TESTIN TIME 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(def test0 [1, 4, 2, 3])
(def test1 [[4 1 4 2 3] [8 1 6 -1 8 9 5 2 7]])
(def test2 [[4 1 4 2 3] [5 1 4 2 -1 6] [4 19 22 24 21] [4 19 22 24 25] [4 2 -1 0 2]])

(println "TEST 0!")
(apply print test0) (println (solveIt test0))

(println "\nTEST 1!")
(solveAndPrint test1)

(println "\nTEST 2!")
(solveAndPrint test2)

