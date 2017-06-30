#lang racket
(require test-engine/racket-tests)

;CountSym
;Consumes a symbol and a list of items and produces the count of how many times the symbol appears in the list of items
;CountSym : (Symbol * list of items) -> Integer

(check-expect (countSym 'a '()) 0)
(check-expect (countSym 'a '(a a a)) 3)
(check-expect (countSym 'a '(a b a b c)) 2)
(check-expect (countSym 'x '((f x) y (((x z) x)))) 3)

;Stub
;(define (countSym sym aList) '())
(define (countSym sym aList)
  (if (empty? aList) 0
  (if (list? (first aList))
      (+ (countSym sym (first aList))
         (countSym sym (rest aList)))
      (if (equal? sym (first aList))
          (+ 1 (countSym sym (rest aList)))
          (countSym sym (rest aList))))))

(test)