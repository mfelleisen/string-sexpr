#lang scribble/manual

@(require (for-label racket xml/xml))

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
}

@history[
 #:changed "1.0" @list{Thu Nov 10 13:42:33 EST 2016}
]
