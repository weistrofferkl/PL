#lang racket
(require test-engine/racket-tests)

(check-expect (downList '(1 2 3)) '((1) (2) (3)))
(check-expect (downList '()) '(()))
(check-expect (downList '((a) (good) (day))) '(((a)) ((good)) ((day))))
(check-expect (downList '(a (more (complicated)) example)) '((a) ((more (complicated))) (example)))

;; downList
;; downList : List -> List of Lists
(define (downList aList)
  (cond
    [(empty? aList) (list '())]
   [(empty? (rest aList)) (list(list(first aList)))]
  [else (cons (list (first aList)) (downList (rest aList)))]
  ))


(test)

