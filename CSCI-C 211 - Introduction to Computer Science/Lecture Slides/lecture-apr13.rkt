;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-apr13")
(define team "")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "")

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
(define e4 (make-expr /
                      (make-expr +
                                 (make-expr * 2 6)
                                 (make-expr * 3 4))
                      (make-expr - 7 5)))

; eval : Expr -> ...
; (eval expr) returns the result of applying all operations in
; expr and reducing it down to a single value

(define (eval expr)
  (cond
    [(number? expr) expr]
    [else ((expr-op expr) (eval (expr-rand1 expr))
                          (eval (expr-rand2 expr)))]))


(check-expect (eval e0) 5)
(check-expect (eval e1) 7)
(check-expect (eval e2) 3)
(check-expect (eval e3) 2)
(check-expect (eval e4) (/ (+ (* 2 6) (* 3 4)) (- 7 5)))
(check-expect (eval (make-expr (lambda (x y) (+ (* 10 x) y))
                               e2
                               e3))
              32)

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "")

; count-ops : ...
; (count-ops expr) returns the number of operators in expr

(define (count-ops expr)
  (cond
    [(number? expr) 0]
    [(procedure? expr) 1]
    [else (+ (count-ops (expr-op expr))
             (count-ops (expr-rand1 expr))
             (count-ops (expr-rand2 expr)))]))


(check-expect (count-ops 3) 0)
(check-expect (count-ops (make-expr + 2 3)) 1)
(check-expect (count-ops (make-expr + 3 (make-expr - 4 5))) 2)
(check-expect (count-ops e3) 3)
(check-expect (count-ops e4) 5)
(check-expect (count-ops (make-expr (lambda (x y) (* x (+ x y))) e3 e4))
              9)

;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "")

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

(define et (make-empty-tree))
(define tr1 (make-node 5 et et))
(define tr2 (make-node 7 tr1 et))
(define tr3 (make-node 4 tr1 tr2))
(define tr4 (make-node 8
                       (make-node 9
                                  (make-node 8 et et)
                                  et)
                       (make-node 3
                                  et
                                  (make-node 2 et et))))
(define tr5 (make-node 3
                       (make-node 4 et et)
                       (make-node 1
                                  (make-node 6 et et)
                                  et)))
(define tr6 (make-node 7 tr4 tr5))

;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "")

; process-tree : [TreeOf X] -> ...
; (process-tree tr) returns ...

(define (tree-size tr)
  (cond
    [(empty-tree? tr) 0]
    [else ...]))

