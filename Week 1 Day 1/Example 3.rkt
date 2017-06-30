#lang racket
(require test-engine/racket-tests)

;duple
;Consume a number and an item produces a list containing n copies of the item

;duple : (Number * Item) -> List of Item)

(check-expect (duple 0 'a)'())
(check-expect (duple 3 2) '(2 2 2))
(check-expect (duple 2 '(a b c)) '((a b c) (a b c)))

;stub
;(define (duple n item) '())
(define (duple n item)
  (if (= n 0) '()
      (cons item (duple (- n 1) item))))

(test)