;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-apr11")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Andrew Andjelic")

; fibonachos : Symbol Symbol PosInt -> Symbol
; (fibonachos friend1 friend2 num-chips) returns the name of the person
; (either friend1 or friend2) who eats the last chip, assuming
; that the friends take turns eating from a bowl with num-chips
; chips and the friends take handfuls of chips that follow a Fibonacci
; sequence starting with 1 1

(define (fibonachos friend1 friend2 chips)
  (local
    [; loop : Int Nat Nat Symbol
     ; (loop chips fib1 fib2 eater other) assumes chips is the number
     ; of chips left in the bowl, fib1 and fib2 is a window into the
     ; Fibonacci sequence, eater is the person whose turn it is to eat
     ; next, and other is the eater's friend
     
     (define (loop chips fib1 fib2 eater other)
       (cond
         [(<= chips 0) other]
         [else (loop (- chips fib1) fib2 (+ fib1 fib2) other eater)]))]
         
    
    (loop chips 1 1 friend1 friend2)))

(check-expect (fibonachos 'Jason 'Marcus 1) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 2) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 3) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 4) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 5) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 6) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 7) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 8) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 9) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 10) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 11) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 12) 'Jason)
(check-expect (fibonachos 'Jason 'Marcus 13) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 14) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 15) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 16) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 17) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 18) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 19) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 20) 'Marcus)
(check-expect (fibonachos 'Jason 'Marcus 21) 'Jason)


;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Grant Eller")

; rotate-right : [ListOf X] -> [ListOf X]
; (rotate-right ls) returns the result of moving all elements of ls one
; position to the right and rotating the last element to the front

(define (rotate-right ls)
  (cond
    [(empty? ls) ls]
    [(= 1 (length ls)) ls]
    [else (local
            [(define ans (rotate-right (rest ls)))]
            (cons (first ans) (cons (first ls) (rest ans))))]))


(check-expect (rotate-right '()) '())
(check-expect (rotate-right '(a)) '(a))
(check-expect (rotate-right '(a b c d e f)) '(f a b c d e))
(check-expect (rotate-right (build-list 1001 (lambda (i) (* 2 i))))
              (build-list 1001 (lambda (i)
                                (if (zero? i)
                                    2000
                                    (* 2 (sub1 i))))))


;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

(define scribe5 "")

#|
  An Expr is one of
  - Num
  - (make-expr [Num Num -> Num] Expr Expr)
|#

(define-struct expr [op rand1 rand2])

(define e0 5)
(define e1 (make-expr + 3 4))
(define e2 (make-expr remainder 13 5))
(define e3 (make-expr - (make-expr + 2 3) (make-expr / 12 4)))

; (/ (+ (* 2 6) (* 3 4)) (- 7 5))
(define e4 (make-expr / (make-expr + (make-expr * 2 6)
                                   (make-expr * 3 4))
                      (make-expr - 7 5)))

;;;;;;;;;;;;;;
;; Problem 6
;;;;;;;;;;;;;;

(define scribe6 "")

; eval : Expr -> ...
; (eval expr) returns the result of applying all operations in
; expr and reducing it down to a single value

#;(define (eval expr)
  (cond
    [(number? expr) ...]
    [else ...]))

#|
(check-expect (eval e0) 5)
(check-expect (eval e1) 7)
(check-expect (eval e2) 3)
(check-expect (eval e3) 2)
(check-expect (eval e4) 12)
(check-expect (eval (make-expr (lambda (x y) (+ (* 10 x) y))
                               e2
                               e3))
                    32)
|#