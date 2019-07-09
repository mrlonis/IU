;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 15 Quiz|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
  An Association is one of
  - (cons X (cons Y '()))

  An AssociationList is one of
  - [ListOf Association]
|#

; lookup : AssociationList Stmbol > [Maybe X]
; (lookup ass key) returns the entry belonging to the given key. If it
; doesn't exis it returns #false

(define (lookup ass key)
  (cond
    [(empty? ass) #false]
    [(equal? (first (first ass)) key) (first ass)]
    [else (lookup (rest ass) key)]))

(check-expect (lookup '((a hello) (c 42) (d 1/2)) 'd)
              '(d 1/2))