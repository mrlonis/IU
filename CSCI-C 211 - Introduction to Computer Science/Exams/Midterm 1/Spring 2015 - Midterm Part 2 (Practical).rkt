;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Spring 2015 - Midterm Part 2 (Practical)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; Design a function bookends that takes a natural number n and returns
; a list containing the value ’end as the first and last elements,
; with n occurrences of the value ’book in between.

(check-expect (bookends 0) '(end end))
(check-expect (bookends 4) '(end book book book book end))

#|
  A ListOfBookEnd is one of:
  - '()
  - (cons 'book '())
  - (cons 'end '())
  - (cons 'book ListOfBookEnd)
|#

; bookends-helper : Nat -> ListOfBookEnd
; (bookends-helper n) returns a list with n occurences of 'book and the
; symbol 'end at the end of the list

(define (bookends-helper n)
  (cond
    [(= n 0)  (cons 'end '())]
    [else (cons 'book (bookends-helper (- n 1)))]))

(check-expect (bookends-helper 0) '(end))
(check-expect (bookends-helper 4) '(book book book book end))
(check-expect (bookends-helper 1) '(book end))
(check-expect (bookends-helper 3) '(book book book end))

; bookends : Nat -> ListOfBookEnd
; (bookends n) returns a list with 'end at the beginning of the list, n
; occurences of 'book in the middle of the list, and finally 'end at
; the end of the list

(define (bookends n)
  (cons 'end (bookends-helper n)))

(check-expect (bookends 1) '(end book end))
(check-expect (bookends 3) '(end book book book end))

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; A big enough list is one with two or more elements.

;;;;; 5a

; In comments, write a data definition for a BigEnoughListOfNum.

#|
  A BigEnoughListOfNum is one of:
  - (cons Num (cons Num '()))
  - (cons Num BigEnoughListOfNum)
|#

;;;;; 5b

; Design a function widest-gap that takes a list of two or more numbers,
; and returns the maximal diference between two consecutive numbers in
; the list.

(check-expect (widest-gap '(4 9)) 5)
(check-expect (widest-gap '(9 4)) 5)
(check-expect (widest-gap '(4 9 1 7 -5 0 3 8)) 12)

(define (widest-gap BigEnoughListOfNum)
  (cond
    [(empty? (rest (rest BigEnoughListOfNum)))
     (max (- (max (first BigEnoughListOfNum)
                  (second BigEnoughListOfNum))
             (min (first BigEnoughListOfNum)
                  (second BigEnoughListOfNum))))]
    [else (max (- (max (first BigEnoughListOfNum)
                       (second BigEnoughListOfNum))
                  (min (first BigEnoughListOfNum)
                       (second BigEnoughListOfNum)))
               (widest-gap (rest BigEnoughListOfNum)))]))

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

; In this problem, you will first define a function in part (a) and
; then make use of it in part (b).

;;;;; 6a

; Design a recursive function replicate-first that takes a natural
; number n and a non-empty list, and returns the list with the first
; element being replicated n times. Notice that if n is zero, this
; results in removing the first element.

(check-expect (replicate-first 0 '(good bye)) '(bye))
(check-expect (replicate-first 1 '(stays the same)) '(stays the same))
(check-expect (replicate-first 3 '(warning! alien approaching))
              '(warning! warning! warning! alien approaching))

; Before you begin coding, go back and re-read the first instruction
; on the front of this exam.

(define (replicate-first n list)
  (cond
    [(empty? list) '()]
    [(= n 0) (rest list)]
    [else (cons (first list) (replicate-first (- n 1) list))]))

#|
;;;;; 6b

; Design a recursive function replicate-all that takes an item, a
; natural number n, and a list, and replaces each occurrence of the
; item in the list with n copies of itself. Make appropriate use of
; replicate-first. Note that if n is zero, this results in removing
; all occurrences of the item from the list.

(check-expect (replicate-all 'penny 0 '(penny nickel penny penny dime))
              '(nickel dime))
(check-expect (replicate-all 'ever 5 '(never ever do that again!))
              '(never ever ever ever ever ever do that again!))
;(check-expect (replicate-all 'duck 3 '(duck goose duck goose))
  ;            '(duck duck duck goose duck duck duck goose))

; Before you begin coding, go back and re-read the first instruction
; on the front of this exam.

(define (replicate-all item n list)
  (cond
    [(empty? list) '()]
    [(and (equal? item (first list))
          (= n 0))
     (replicate-all item n (replicate-first n list))]
    [(and (equal? item (first list))
          (not (= n 0)))
     (cons (replicate-first n (cons (first list) '()))
           (replicate-all item n (rest list)))]
    [else (cons (first list) (replicate-all item n (rest list)))]))
|#

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

; This problem extends the Simple Tetris game you implemented in a7.

;;;;; 7a

; Define two variables, WIDTH and HEIGHT, to have the values 7 and 10,
; respectively. These represent the logical size of the grid of blocks.

(define WIDTH 7)
(define HEIGHT 10)

;;;;; 7b

; Define a structure named block with three fields: row, col, and color.

(define-struct block [row col color])

;;;;; 7c

; In the actual Tetris game, the dropping piece is a cluster of
; several blocks, all of which are the same color. We represent a
; Piece with a list of Block. One such piece is shaped like the letter
; L. Define a variable L-piece corresponding to a red L-shaped piece
; located in the upper left corner of the grid.

(define L-piece (list (make-block 1 1 "red")
                      (make-block 2 1 "red")
                      (make-block 3 1 "red")
                      (make-block 3 2 "red")))

;;;;; 7d

; Design a predicate hit-bottom? that takes a Piece and returns true
; if any block within the piece has reached the bottom row, and false
; otherwise.

(define (hit-bottom? piece)
  (cond
    [(empty? piece) #false]
    [(equal? HEIGHT (block-row (first piece))) #true]
    [else (hit-bottom? (rest piece))]))

(check-expect (hit-bottom? L-piece) #false)

;;;;; 7e

; Design a function piece-down that takes a Piece and returns the
; result of moving it down one row, if possible. However,
; if the piece has already hit the bottom, then just return it
; unchanged.

(define (piece-down piece)
  (cond
    [(empty? piece) '()]
    [(hit-bottom? piece) piece]
    [else (cons (make-block (+ (block-row (first piece)) 1)
                            (block-col (first piece))
                            (block-color (first piece)))
                (piece-down (rest piece)))]))

(check-expect (piece-down L-piece)
              (list (make-block 2 1 "red")
                    (make-block 3 1 "red")
                    (make-block 4 1 "red")
                    (make-block 4 2 "red")))