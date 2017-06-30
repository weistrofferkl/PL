#lang racket
(require parser-tools/lex)


(define-tokens var (VAR))
(define-empty-tokens e (EOF))

(define input (open-input-string "hskjfhasdfkjlhdsjfk_ a23_ dsjkfhaslkdjfh"))


;;#5
(define idLexer
  (lexer
   [(concatenation lower-case (repetition 0 +inf.0 (union #\_ lower-case numeric)))
    (cons (token-VAR lexeme)(idLexer input-port))]
   [whitespace (idLexer input-port)]
   [(eof) (token-EOF)]))
