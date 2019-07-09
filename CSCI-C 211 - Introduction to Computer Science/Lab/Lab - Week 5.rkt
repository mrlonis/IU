;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab - Week 5|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "lab5")
(define partner "Olivia Pfingston (opfingst")

#|
A ListOfNums is one of
- '()
- (cons Num ListOfNums)

A Nat is one of
- 0
- (add1 Nat)
|#

(define (process-nat nat)
  (cond
    [(zero? nat) (cons 0 '())]
    [else (... (process-nat (sub1 nat)) ...)]))

(define (process-listofnums nums)
  (cond
    [(empty? nums) ...]
    [else (... (process-listofnums (rest numes)) ...)]))

; countdown : Nat -> ListOfNum
; (countdown num) returns a list of numbers from num to zero

(define (countdown num)
  (cond
    [(zero? num) (cons 0 '())]
    [else (cons num (countdown (sub1 num)))]))

(check-expect (countdown 0) (cons 0 '()))

#|
A StarImage is an image of a star
|#

; make-leaf : Nat -> StarImage
; (make-leaf n) makes a Star of size n

(define (make-leaf n)
  (star n "solid" "green"))

; make-upper-tree : Nat -> Image
; (make-upper-tree n) produces an image with n StarImages that
; decrease as they ascend

(define (make-upper-tree n)
  (cond
    [(zero? n) empty-image]
    [else (above (make-upper-tree (sub1 n)) (make-leaf n))]))

(define (make-tree n)
  (above (make-upper-tree n)
         (rectangle 20 30 "solid" "brown")))

(define (draw-tree n)
  (overlay (make-tree (quotient n 10))
           (empty-scene 1000 1000)))