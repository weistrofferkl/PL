#lang racket
(require parser-tools/lex)
(define in (open-input-string "3d4h3h4k2l 3h5j2j1k 1l2k3j 1pasdf"))
 
(define (string->char s)
  (first (string->list s)))

(define lex
  (lexer 
   [(repetition 1 +inf.0 
                (char-range #\a #\z))
    ; =>
    (begin (display "found an id: ")
           (display lexeme)
           (newline))]
   
   [(union #\space #\newline)
    ; =>
    (void)]))

(define kendallSucks
  (lexer
   [(repetition 1 +inf.0 (concatenation numeric alphabetic)) (cons lexeme (kendallSucks input-port))]
   [whitespace (kendallSucks input-port)]


   ))