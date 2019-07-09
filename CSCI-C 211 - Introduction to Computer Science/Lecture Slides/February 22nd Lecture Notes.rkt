;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |February 22nd Lecture Notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-feb22")
(define team "yellow9")

;;;;;;;;;;;;;;;
;; The Model
;;;;;;;;;;;;;;;

; logical constants
(define WIDTH 7)    ; the number of blocks horizontally 
(define HEIGHT 10)  ; the number of blocks vertically

; graphical constants 
(define BLOCK-SIZE 70)  ; size of a rendered block (blocks are square)
(define SCENE-WIDTH (* WIDTH BLOCK-SIZE))      ; scaled width of scene
(define SCENE-HEIGHT (* HEIGHT BLOCK-SIZE))    ; scaled height of scene

; pool of possible block colors
(define POOL 
  (list "red" "orange" "yellow" "green" "blue" "indigo" "violet"))

#|
   A Hue is a Color in POOL

   A Block is (make-block [1..HEIGHT] [1..WIDTH] Hue)
 
   A Landscape is one of: 
   – '()
   – (cons Block Landscape)

   A World is a (make-world Block Landscape)
|#

(define-struct block [row col color])
(define-struct world [piece land])

;;;;;;;; Sample Worlds

(define w0
  (make-world (make-block 1 4 "indigo")
              (list (make-block (sub1 HEIGHT) 2 "red")
                    (make-block HEIGHT 1 "green")
                    (make-block HEIGHT 2 "blue")
                    (make-block HEIGHT WIDTH "yellow"))))

(define w1
  (make-world (make-block 3 6 "red")
              (list (make-block 6 4 "green")
                    (make-block 7 4 "blue")
                    (make-block 8 3 "orange")
                    (make-block 8 4 "green")
                    (make-block 9 3 "violet")
                    (make-block 9 4 "yellow")
                    (make-block 9 7 "indigo")
                    (make-block 10 1 "red")
                    (make-block 10 2 "red")
                    (make-block 10 3 "red")
                    (make-block 10 4 "red")
                    (make-block 10 5 "red")
                    (make-block 10 7 "red"))))

;;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;;

; next-block : Block Direction -> Block
; (next-block block dir) returns a block that is the result of moving
; the block in the indicated direction, if possible

(define (next-block block dir)
  (cond
    [(and (equal? dir "down")
          (not (= (block-row block) HEIGHT)))
     (make-block (+ 1 (block-row block)) (block-col block)
                 (block-color block))]
    [(and (equal? dir "right")
          (not (= (block-col block) WIDTH)))
     (make-block (block-row block) (+ 1 (block-col block))
                 (block-color block))]
    [(and (equal? dir "left")
           (not (= (block-col block) 1)))
      (make-block (block-row block) (- (block-col block) 1)
                  (block-color block))]
    [else block]))


(check-expect (next-block (make-block 1 1 "red") "down")
              (make-block 2 1 "red"))
(check-expect (next-block (make-block 10 7 "green") "down")
              (make-block 10 7 "green"))
(check-expect (next-block (make-block 1 1 "red") "left")
              (make-block 1 1 "red"))
(check-expect (next-block (make-block 10 7 "green") "left")
              (make-block 10 6 "green"))
(check-expect (next-block (make-block 1 1 "red") "right")
              (make-block 1 2 "red"))
(check-expect (next-block (make-block 1 1 "red") "up")
              (make-block 1 1 "red"))

;;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;;

; same-location? Block Block -> Boolean
; (smae-location? b1 b2) returns #true iff the two blocks have the same
; location

(define (same-location? b1 b2)
  (and (= (block-row b1) (block-row b2))
       (= (block-col b1) (block-col b2))))  

(check-expect (same-location? (make-block 2 7 "red")
                              (make-block 2 7 "green")) #true)

;;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;;

; exists? : Block Landscape -> Boolean
; (exists? block landscape) returns #true iff the block has the same
; location as some other block in the landscape

(define (exists? block landscape)
  (cond
    [(empty? landscape) #false]
    [(same-location? block (first landscape)) #true]
    [else (exists? block (rest landscape))]))

(check-expect (exists? (make-block 2 7 "red")
                       (list (make-block 3 7 "green")
                             (make-block 2 7 "yellow")
                             (make-block 7 2 "red")
                             (make-block 5 4 "blue")))
              #true)
(check-expect (exists? (make-block 2 7 "red")
                       (list (make-block 3 7 "green")
                             (make-block 4 7 "yellow")
                             (make-block 7 2 "red")
                             (make-block 5 4 "blue")))
              #false)