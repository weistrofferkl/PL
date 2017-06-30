#lang racket
(require test-engine/racket-tests)

(check-expect (remove-duplicates '(1 1 3 3 2 1 3 2 1 4)) '(1 3 2 4))
(check-expect (remove-duplicates '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (remove-duplicates '(4 4 4 4 4 4 4 4 4 4)) '(4))
(check-expect (remove-duplicates '())'())


(define (remove-duplicates aList)
  (secondMethod aList '())
 )

(define (secondMethod aList bList)
 (cond
   [(empty? aList) bList ] 
   [(not(member (first aList) bList))
     (secondMethod (rest aList) (append bList (list (first aList))))]
   [else (secondMethod (rest aList) bList)]
   )
  
   )
  
(test)