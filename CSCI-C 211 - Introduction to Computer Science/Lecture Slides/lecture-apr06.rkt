;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-apr06")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Matthew Lonis")

(define spin0 '())
(define spin1 '(1))
(define spin2 '(2 1))
(define spin3 '(1 3 1 2 1)) 
(define spin4 '(2 1 4 1 2 1 3 1 2 1))
(define spin5 '(1 3 1 2 1 5 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1))

(check-expect (length spin3) 5)
(check-expect (length spin4) 10)
(check-expect (length spin5) 21)

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Grant Eller")


(define spin6 (append spin4 (list 6) (reverse spin4) spin5))

(check-expect (length spin6) 42)


;; Note: if you finish early, try defining spin7 computationally.

(define spin7 (append spin5 (list 7) (reverse spin5) spin6))

(check-expect (length spin7) 85)

;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Andre Quan")

#|
  A [2List X Y] is a (list X Y)
|#

; deal/v- : [ListOf X] -> [2List [ListOf X] [ListOf X]] 
; (deal/v- deck) returns the result of dealing the cards in deck
; into two hands, such that the order of cards in the hands is
; the same as in deck

(define (deal/v2 deck)
  (cond
    [(empty? deck) (list '() '())]
    [else (local [(define ans (deal/v2 (rest deck)))]
            (list (cons (first deck) (second ans))
                  (first ans)))]))


(check-expect (deal/v2 '(a b c d e)) '((a c e) (b d)))
(check-expect (deal/v2 '(a b)) '((a) (b)))
(check-expect (deal/v2 '(a)) '((a) ()))
(check-expect (deal/v2 '()) '(() ()))


;; Note: if you finish your version of deal early, then start
;; working on the other version!!! Is one version faster than
;; the other?


(define (deal/v1 deck)
  (cond
    [(empty? deck) (list '() '())]
    [(empty? (rest deck)) (list (list (first deck)) '())]))