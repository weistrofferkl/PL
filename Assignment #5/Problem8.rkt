#lang racket
(require test-engine/racket-tests)
(require racket/set)
(require parser-tools/lex
        parser-tools/yacc)

;(check-expect(lexAndParseAndEval input (open-input-string "C {1 2 3}"))
;(define input2(open-input-string "I U{1,2,3} {7,8,9} C{1,2,3,4,7,8}"))

(define-tokens w (VALUE BINARYOP UNARYOP))
(define-empty-tokens e (LEFTBRACE RIGHTBRACE COMMA EOF))

(define operationSetLexer
  (lexer
   [#\{ (token-LEFTBRACE)]
   [#\} (token-RIGHTBRACE)]
   [#\C (token-UNARYOP lexeme)]
   [#\U (token-BINARYOP lexeme)]
   [#\I (token-BINARYOP lexeme)]
   [#\, (token-COMMA)]
   [numeric (token-VALUE lexeme)]
   [whitespace (operationSetLexer input-port)]
   [(eof) (token-EOF)]))

(struct setExpr (firstLMNT otherLMNT) #:transparent)
(struct unaryExpr (opName operand) #:transparent)
(struct BinaryExpr (opName lValue rValue) #:transparent)

(define operationSetParser
  (parser
   (start expr)
   (end EOF)
   (tokens w e)
   (error void)
   (grammar
    (expr
     ((UNARYOP expr) (unaryExpr $1 $2))
     ((BINARYOP expr expr)(BinaryExpr $1 $2 $3))
     ((LEFTBRACE RIGHTBRACE) '())
     ((LEFTBRACE VALUE expr)(setExpr $2 $3))
     ((COMMA VALUE expr) (setExpr $2 $3))
     ((RIGHTBRACE) '())
     ))))

(define (lex-this lexer input)
  (lambda () (lexer input)))

(define (lexAndParseAndEval in)
 (printFun(evalParse(operationSetParser (lex-this operationSetLexer (open-input-string in))))""))

;union evaluator, intersect, and complement
(define (setUnion firstList secondList)
  (set-union firstList secondList))

(define (setComp aList)
  (set-subtract '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9") aList))

(define (setInter firstList secondList)
  (set-intersect firstList secondList))

(define (setToList S)
  (cond [(empty? S) '()]
        (else (cons (setExpr-firstLMNT S) (setToList (setExpr-otherLMNT S))))))

(define (evalParse parseTree)
  (cond [(setExpr? parseTree) (setToList parseTree)]
        [(unaryExpr? parseTree) (setComp (evalParse(unaryExpr-operand parseTree)))]
        [(BinaryExpr? parseTree) (cond
                                   [(equal? (BinaryExpr-opName parseTree) "I")
                                    (setInter
                                     (evalParse (BinaryExpr-lValue parseTree))
                                     (evalParse (BinaryExpr-rValue parseTree)))]
                                 
                                   [(equal? (BinaryExpr-opName parseTree) "U")
                                    (setUnion
                                     (evalParse (BinaryExpr-lValue parseTree))
                                     (evalParse (BinaryExpr-rValue parseTree)))])]))


(define (printFun aList aString)
  (cond [(and(empty? aList) "{}")]
        [(equal? aString "")(printFun aList "{")]
        [(equal? (length aList) 1)(string-append aString (first aList) "}")]
        [else (printFun (rest aList)(string-append aString (first aList) ","))]))
  