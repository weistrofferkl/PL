#lang racket
(require parser-tools/lex)

(define test-input (open-input-string "abba foo olaf"))

(define abLexer
  (lexer [#\a (display "Matched a")]
         [#\b (display "Matched b")]
         [whitespace (display "Matched whitespace")]
         [alphabetic (display "Matched alphabetic")]))


(define basicLexer
  (lexer
   [(repetition 1 +inf.0 (char-range #\a #\z))
       (cons (list 'Id lexeme) (basicLexer input-port))]
   [whitespace(basicLexer input-port)]
   [(eof) '()]
   ))

(define lam (open-input-string "lambda x.x"))

(define lambdaLexer
  (lexer
   ["lambda" (cons (list 'Lambda lexeme) (lambdaLexer input-port))]
   [#\( (cons (list 'LeftParen lexeme) (lambdaLexer input-port))]
   [#\) (cons (list 'RightParen lexeme) (lambdaLexer input-port))]
   [(repetition 1 +inf.0 (char-range #\a #\z))
    (cons (list 'Id lexeme)(lambdaLexer input-port))]
   [#\. (cons (list 'Dot lexeme) (lambdaLexer input-port))]
   [(eof) '()]))

   