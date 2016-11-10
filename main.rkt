#lang racket

;; convert a String to an S-expression in the shape of PD*

; A PD* (short for picture description) is one of:
; – 'empty-image 
; – String 
; – (list 'circle Number String String)
; – (list 'rectangle Number Number String String)
; – (list 'beside LPD*)
; – (list 'above LPD*)
; 
; An LPD* is [Listof PD*]

;; -----------------------------------------------------------------------------
;; services 

(provide
 ;; String -> PD*
 ;; converts the given String into a PD* (Sexpression)
 string->sexpr)

;; -----------------------------------------------------------------------------
;; dependencies 

(require htdp/error)

(module+ test
  (require rackunit))

;; -----------------------------------------------------------------------------
;; implementation 

(module+ test
  (require rackunit))

;; String -> [Maybe PD*]
;; Converts a string into an s-expression via read,
;; masking exceptions as #false 

(define (string->sexpr s)
  (check-arg 'string->sexpr (string? s) "string" "first" s)
  (with-handlers ((exn:fail:read:eof? (lambda (x) #false))
                  (exn:fail:contract? (lambda (x) #false)))
    (define x (read (open-input-string s)))
    (if (check-pd* x) x #false)))

;; S-expression -> Boolean
;; is x in PD?
(define (check-pd* x)
  (match x
    ['empty-image #true]
    [(? string?) #true]
    [`(circle ,(? number?) ,(? string?) ,(? string?)) #true]
    [`(rectangle ,(? number?) ,(? number?) ,(? string?) ,(? string?)) #true]
    [`(beside ,y ...) (check-lpd* y)]
    [`(above ,y ...) (check-lpd* y)]
    [else #false]))

;; [Listof S-expression] -> Boolean
;; is y in LPD*
(define (check-lpd* y)
  (andmap check-pd* y))

;; -----------------------------------------------------------------------------
;; tests 

(module+ test
  (check-equal? (string->sexpr "empty-image") 'empty-image)
  (check-equal? (string->sexpr "\"nope\"") "nope")
  (check-equal? (string->sexpr "(circle 10 \"solid\" \"red\")")
                '(circle 10 "solid" "red"))
  (check-equal? (string->sexpr "(rectangle 10 20 \"solid\" \"red\")")
                '(rectangle 10 20 "solid" "red"))
  (check-equal? (string->sexpr "(above (rectangle 10 20 \"solid\" \"red\"))")
                '(above (rectangle 10 20 "solid" "red")))
  (check-equal?
   (string->sexpr
    "(beside \"hello\" (rectangle 10 20 \"solid\" \"red\") \"world\")")
   '(beside "hello" (rectangle 10 20 "solid" "red") "world"))

  (check-exn exn:fail? (lambda () (string->sexpr 'nope)) "symbols not allowed")
  (check-false (string->sexpr "(circle 10 solid red") "incomplete S-expression"))
