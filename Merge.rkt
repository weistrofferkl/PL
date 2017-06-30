#lang racket
(require test-engine/racket-tests)

;;;; Split a list of numbers
;;; split : list of number --> Pair of list of number
(check-expect (split '(1 2 3 4 5 6)) '((1 3 5)(2 4 6)))

;;; stub
;(define (split aList) '( ()()) )

(define (split aList)
  (if (empty? aList) '( ()())
      (if (empty? (rest aList)) (list (first aList) '())
       (list   (cons (first aList) (first(split (rest (rest aList)))))
               (cons (first (rest aList)) (first (rest (split (rest (rest aList)))))))))) 
;;; merge two lists into a single list
;;; merge : ((List of number) * (List of number)) --> List of Number


(check-expect (merge '(0 2 4 6) '(1 3 5 7)) '(0 1 2 3 4 5 6 7))
(check-expect (merge '() '(0 1 2)) '(0 1 2))
(check-expect (merge '(1 2 3) '()) '(1 2 3))

;;; stub
;;(define (merge listOne listTwo) '() )

(define (merge listOne listTwo)
  (cond ((empty? listOne) listTwo)
        ((empty? listTwo) listOne)
        ((< (first listOne) (first listTwo))
          (cons (first listOne)(merge(rest listOne) listTwo)))
        (else (cons (first listTwo)(merge listOne (rest listTwo))))))

(test)