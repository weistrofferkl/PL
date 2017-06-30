#lang racket
(require parser-tools/lex)

(define-tokens v (VAR VALUE BINARYOP UNARYOP))
(define-empty-tokens e (LEFTPAREN RIGHTPAREN EOF))

(define input (open-input-string "((("))

(define input2 (open-input-string "(true and not)"))

(define BoolLexer
  (lexer
   [#\( (cons (token-LEFTPAREN) (BoolLexer input-port))]
   [#\) (cons (token-RIGHTPAREN) (BoolLexer input-port))]
   [(union "true" "false") (cons (token-VALUE lexeme) (BoolLexer input-port))]
   [(union "and" "or" "xor")(cons (token-BINARYOP lexeme)(BoolLexer input-port))]
   [(union "not") (cons (token-UNARYOP lexeme) (BoolLexer input-port))]
   [whitespace (BoolLexer input-port)]
   [(eof) (token-EOF)]))

