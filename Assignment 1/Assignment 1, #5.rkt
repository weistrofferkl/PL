#lang racket
(require test-engine/racket-tests)

;reverse-pairs
;Consume a list of pairs and produce a list of reversed pairs
;reverse-pairs : ((a b)(1 3)(e f)) --> ((b a)(3 1)(f e))

(check-expect (reverse-pairs '((a b)(1 3)(e f))) '((b a)(3 1)(f e)))
(check-expect (reverse-pairs '((b d)(24 32)(y u))) '((d b)(32 24)(u y)))
(check-expect (reverse-pairs '((b d)(24 ())(y u))) '((d b)(() 24)(u y)))
(check-expect (reverse-pairs '((b d)(() ())(y u))) '((d b)(() ())(u y)))
(check-expect (reverse-pairs '((b d))) '((d b)))

;Stub
;(define (reverse-pairs aList) '())

(define (reverse-pairs aList)
  (if (empty? (rest aList)) (list (reverse (first aList)))
      (cons (reverse (first aList))
            (reverse-pairs(rest aList)))  
  )
)

(test)