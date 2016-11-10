#lang scribble/manual

@(require (for-label xml/xml) racket/sandbox scribble/example "../main.rkt")

@(define my-evaluator
   (parameterize ([sandbox-output 'string]
                  [sandbox-error-output 'string])
     (define e (make-evaluator 'racket))
     (e '(require string-sexpr))
     e))

@title{String to S-expression for Fundamentals I, 2016, Northeastern University}
@author{matthias}

@defmodule[string-sexpr]

The teachpack provides a single function: 

@defproc[(string->sexpr [s string?]) (or/c #false PD*)]{
 Convert the given String into an  S-expression that belongs to PD*. 
 If the function produces #@racket[false], the given String is either not
 an S-expression or it is an S-expression that does not belong to PD*. 

@;%
@(begin
#reader scribble/comment-reader
(racketblock
; A PD* (short for picture description) is one of:
; – 'empty-image 
; – String 
; – (list 'circle Number String String)
; – (list 'rectangle Number Number String String)
; – (list 'beside LPD*)
; – (list 'above LPD*)
; 
; An LPD* is [Listof PD*]
))
@;%


@examples[#:eval my-evaluator
 (string->sexpr "empty-image")
 (string->sexpr "\"nope\"")
 (string->sexpr "(circle 10 \"solid\" \"red\")")
 (string->sexpr "(rectangle 10 20 \"solid\" \"red\")")
 (string->sexpr "(above (rectangle 10 20 \"solid\" \"red\"))")
 (string->sexpr
  "(beside \"hello\" (rectangle 10 20 \"solid\" \"red\") \"world\")")
  (string->sexpr "(circle 10 solid red")
]
}

@history[
 #:changed "1.0" @list{Thu Nov 10 13:42:33 EST 2016}
]
