#lang racket
(define (fib n)
  (cond
    ((= n 0) 1)
    ((= n 1) 1)
    (else (+ (fib (- n 1))
             (fib (- n 2))))))


(define (fibList k)
  (if (= k 0) '(1)
      (cons (fib k) (fibList (- k 1)))))