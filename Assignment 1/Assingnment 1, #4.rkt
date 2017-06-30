#lang racket
(require test-engine/racket-tests)

;ascending?
;Consume a list of numbers and produces if the list is in ascending order
;ascending? : (List of Numbers) --> true or false

(check-expect (ascending? '(1 2 3)) #t)
(check-expect (ascending? '(2 1 3)) #f)
(check-expect (ascending? '()) #t)
(check-expect (ascending? '(1)) #t)
(check-expect (ascending? '(3 2 1)) #f)

;Stub
;(define (ascending? aList) '())

(define (ascending? aList)
  (if (empty? aList) true
      (if(<= (length aList) 1) true
         (if (< (first aList) (first (cdr aList)))
             (ascending? (cdr aList))
             false))))


(test)