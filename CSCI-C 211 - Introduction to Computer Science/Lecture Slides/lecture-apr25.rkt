;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr25) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lecture-apr25")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Andrew Andjelic")

#|
  A Bit is one of
  - 0
  - 1
|#

; binary->decimal : [NonEmptyListOf Bit] -> Nat
; (binary->decimal bits) returns the base 10 equivalent of bits

(define (binary->decimal bits)
  (foldl 
   ; Bit Nat -> Nat
   (lambda (bit ans)
     (+ bit (* 2 ans)))
   0
   bits))

(check-expect (binary->decimal '(0)) 0)
(check-expect (binary->decimal '(1)) 1)
(check-expect (binary->decimal '(1 1 0)) 6)
(check-expect (binary->decimal '(1 1 1 1)) 15)
(check-expect (binary->decimal '(1 0 0 0 1)) 17)
(check-expect (binary->decimal '(1 0 0 0 1 1 1 0)) 142)



;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Josh Lipe-Melton")

#|
  A [2List X Y] is a (list X Y)
|#

; split : Num [ListOf X] -> [2List [ListOf X] [ListOf X]]
; (split n ls) returns a list of the first n elements in ls followed
;by a list of the rest of ls

(define (split n ls)
  (cond
    [(empty? ls) (list '() ls)]
    [(zero? n) (list '() ls)]
    [else
     (local [(define ans (split (sub1 n)(rest ls)))]
     (cons (cons (first ls) (first ans))
          (rest ans)))]))


(check-expect (split 0 '(10 20 30 40))
              (list '() '(10 20 30 40)) )
(check-expect (split 2 '(1 1 2 2 3 3 4 4 5 5))
              '((1 1) (2 2 3 3 4 4 5 5)))
(check-expect (split 3 '(a b c d e f g h i j k l m))
              '((a b c) (d e f g h i j k l m)))



