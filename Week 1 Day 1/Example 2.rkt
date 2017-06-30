#lang racket
(require test-engine/racket-tests)

;;; Factorial Function
;;; function which consumes a number and produces the factorial of that number

;;; factorial: Integer -> Integer

(check-expect (factorial 0) 1)
(check-expect (factorial 5) 120)

;Stub
(define (factorial n)
  (if (= n 0) 1
      (* n (factorial (- n 1)))))

(test)