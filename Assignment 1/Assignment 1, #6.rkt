#lang racket
(require test-engine/racket-tests)

;create-pairs
;consume two lists and produce a list of pairs
;create-pairs: '((a b c)(1 2 3)) --> '((a 1)(b 2)(c 3))

(check-expect (create-pairs '((a b c)(1 2 3))) '((a 1)(b 2)(c 3)))
(check-expect (create-pairs '((a b c)(1 2))) '((a 1)(b 2)(c ())))
(check-expect (create-pairs '((a b)(1 2 3))) '((a 1)(b 2)(() 3)))


(define (create-pairs aList)
  (extraMethod2 (first aList) (first (rest aList)))
)

(define (extraMethod2 List1 List2)
  (cond
   [(and (empty? List1) (empty? List2)) '()]
   [(empty? List1) (cons (list '() (first List2)) (extraMethod2 List1 (rest List2)))]
   [(empty? List2) (cons (list(first List1) '()) (extraMethod2 (rest List1) List2))]
   [else (cons (list (first List1) (first List2)) (extraMethod2 (rest List1) (rest List2)))]
   ))
   
   

(test)