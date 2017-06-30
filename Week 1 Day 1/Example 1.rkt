#lang racket
(define foo 5)


(define (add x y)
  (+ x y) )


(define (greater? n)
  (if (> n 0) true
      false))


(define (other? n)
  (> n 0 ))

(define (merp x)
  (cond ((= x 1) "Hello")
        ((= x 2) "There")
        (else "default")))