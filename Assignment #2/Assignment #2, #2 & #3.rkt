#lang racket

(require test-engine/racket-tests)

;;#2
;;upList
;;upList: List -> List

(check-expect (upList '((1 2) (3 4))) '(1 2 3 4))
(check-expect (upList '((x (y)) z)) '(x (y) z))
(check-expect (upList '((1 (2)) (3 4))) '(1 (2) 3 4))



(define (upList aList)
  (extractList aList '()))

(define (extractList tList bList)
  (cond
    [(empty? tList) '()]
    [(empty? (rest tList))(appendList (first tList) bList)]
    [else (extractList (rest tList) (appendList (first tList) bList))]))

(define (appendList tValue bList)
  (cond
    [(empty? tValue) bList]
    [(not (list? tValue))
     (append bList (list tValue))]
    [(empty? (rest tValue))
     (append bList tValue)]
    [else (appendList (rest tValue)(append bList (list (first tValue))))]))



;;#3
;;Flatten List
;;flatten : List of Lists -> List
(check-expect (flatten '(a b c)) '(a b c))
(check-expect (flatten '((a)()(b())()(c))) '(a b c))
(check-expect (flatten '((a b) (() (c)))) '(a b c))

(define (flatten aList)

  (cond
    ((equal? (upList aList)aList)aList)
    (else (flatten (upList aList)))
    
    
 ))

(test)
