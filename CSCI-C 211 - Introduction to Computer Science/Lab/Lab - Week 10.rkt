;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Lab - Week 10|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab10")
(define partner "Andre Quan (quana)")
(define collaboration-statement
  (string-append "I worked with " partner "."))

#|
Uses for Map

1. Converting a list of symbols to strings or vice verse

2. Multiplying, dividing, adding, or subtracting
   (or even advanced mathematical formulas) to be applied to every
   number residing in a list

3. Transposing a list of posns by a certain amount in either the x or y
   plane by a certain amount. Useful for moving lists of dots in
   confetti all in the same direction at the same time
|#

#|
Uses for foldr

1. Compress a list of numbers, symbols, or strings into one massive
   number, symbol, or string

2. Performing mathematical abstractions on each number to every number.
   For example: Adding, multiplying, subtracting, or divinding each and
   every number in a list together.

3. Counting number of certain items in a list. For example: counting
   how many "swag" strings are in a list
|#

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

(define (reflect ls)
  (local [(define (mirror posn)
            (make-posn (posn-y posn) (posn-x posn)))]
    (map mirror ls)))

(check-expect (reflect (list (make-posn 1 2)))
              (list (make-posn 2 1)))

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; nest : [ListOf X] -> [ListOf [ListOf X]]
; (nest ls) returns a [ListOf X] within a [ListOf X]

(define (nest ls)
  (local [(define (nester ls)
            (list ls))]
    (map nester ls)))

(check-expect (nest (list 1 2 3))
              (list (list 1) (list 2) (list 3)))

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; unnest : [ListOf [ListOf X]] -> [ListOf X]

(define (unnest ls)
  (local [(define (unnester ls)
            (first ls))]
    (map unnester ls)))

(check-expect (unnest (list (list 1) (list 2))) (list 1 2))

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

(define (anteater list-of-x)
  (local [(define (eater X Y)
            (cond
              [(equal? 'ant X) Y]
              [else (cons X Y)]))]
    (foldr eater '() list-of-x)))

(check-expect (anteater (list 'ant))
              '())
(check-expect (anteater (list 'ant 'ant 'swag))
              (list 'swag))
(check-expect (anteater (list 'dank 'good-good 'ant 'ant 'swag))
              (list 'dank 'good-good 'swag))