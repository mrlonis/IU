;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "a12")
(define collaboration-statement
  "I worked alone.")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

#|
  A Nat is one of
  - 0
  - (add1 Nat)

  A CoinDenom is one of
  - 1
  - 5
  - 10
  - 25

  A [2List X Y] is a (list X Y)
|#

; give-away : [ListOf CoinDenom] -> [2List Nat Nat]
; (give-away pocket) returns the result of giving pocket coins
; to Child1 and Child2, such that the child with less money always gets
; the next coin (with ties going to Child1)

(define (give-away pocket)
  (foldl (; CoinDenom [2List Nat Nat] -> [2List Nat Nat]
          lambda (coin child-list)
           (if (> (first child-list) (second child-list))
               (list (first child-list) (+ coin (second child-list)))
               (list (+ coin (first child-list)) (second child-list))))
         (list 0 0) pocket))

(check-expect (give-away '(10 5 1 5 25 10))
              (list 35 21))
(check-expect (give-away '(10 25)) '(10 25))

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

(define t1 (square 3 "solid" "black"))
(define t2 (above (beside t1 t1 t1)
                  (beside t1
                          (square (image-width t1) "solid" "white")
                          t1)
                  (beside t1 t1 t1)))
(define t3 (above (beside t2 t2 t2)
                  (beside t2
                          (square (image-width t2) "solid" "white")
                          t2)
                  (beside t2 t2 t2)))

#|
  A PosInt is one of
  - 1
  - (add1 PosInt)
|#

; sierpinski-carpet : PosInt -> Image
; (sierpinski n) returns a solid black square in the case that n is 1,
; or an image formed from 8 copies of the predecessor sierpinski-carpet
; square, in the shape of a square with a white square in the center

(define (sierpinski-carpet n)
  (cond
    [(= n 1) (square 3 "solid" "black")]
    [else (local [(define ans (sierpinski-carpet (sub1 n)))]
            (above (beside ans ans ans)
                   (beside ans
                           (square (image-width ans) "solid" "white")
                           ans)
                   (beside ans ans ans)))]))

(check-expect (image-width (sierpinski-carpet 1)) 3)
(check-expect (sierpinski-carpet 1) t1)
(check-expect (sierpinski-carpet 2) t2)
(check-expect (sierpinski-carpet 3) t3)

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

#|
  A MathOp is one of:
  - Nat
  - [Nat Nat] -> Nat
|#

; verify-rpn? : [ListOf MathOp] -> Bool
; (verify-rpn? rpn-ls) returns the result of the reverse polish notation
; formula given

(define (verify-rpn? rpn-ls)
  (local [; help : [ListOf MathOp] [ListOf Nat] [ListOf MathOp] -> Bool
          (define (help ls n op)
            (cond
              [(empty? ls)
               (if (zero? (sub1 (- (length n) (length op))))
                   #true
                   #false)]
              [else (help (rest ls)
                          (if (number? (first ls))
                              (cons (first ls) n)
                              n)
                          (if (procedure? (first ls))
                              (cons (first ls) op)
                              op))]))]
    (help rpn-ls (list) (list))))

(check-expect (verify-rpn? '()) #false)
(check-expect (verify-rpn? (list 42)) #true)
(check-expect (verify-rpn? (list 2 1 + 3 - 4 *)) #true)
(check-expect (verify-rpn? '(2 1 + 3 - 4 *)) #false)
(check-expect (verify-rpn? (list 1 2 3 - + * 2 1)) #false)
(check-expect (verify-rpn? (list 2 4 3 5 + - /)) #true)
(check-expect (verify-rpn? (list 3 5 + 2 / 3)) #false)
(check-expect (verify-rpn? (list 5 5 / *)) #false)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; spin-out : Nat -> [ListOf Nat]
; (spin-out n) returns a solution, as shown in the "Spin Out" video on
; Canvas and discussed in lecture

(define (spin-out n)
  (local [; loop : Nat Nat Nat -> Nat
          ; (loop i p1 p2) returns the i-th Fibonacci number, where
          ; p1 is (fib (- i 1)) and p2 is (fib i)
          (define (loop i p1 p2)
            (cond
              [(= i n) p2]
              [else (loop
                     (+ i 1)
                     p2
                     (append p1 (list (+ i 1)) (reverse p1) p2))]))]
    (if (zero? n)
        '()
        (loop 1 '() '(1)))))

(define spin0 '())
(define spin1 '(1))
(define spin2 '(2 1))
(define spin3 '(1 3 1 2 1)) 
(define spin4 '(2 1 4 1 2 1 3 1 2 1))
(define spin5 '(1 3 1 2 1 5 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1))
(define spin6 (append spin4 (list 6) (reverse spin4) spin5))
(define spin7 (append spin5 (list 7) (reverse spin5) spin6))

(check-expect (spin-out 0) spin0)
(check-expect (spin-out 1) spin1)
(check-expect (spin-out 2) spin2)
(check-expect (spin-out 3) spin3)
(check-expect (spin-out 4) spin4)
(check-expect (spin-out 5) spin5)
(check-expect (spin-out 6) spin6)
(check-expect (spin-out 7) spin7)
(check-expect (length (spin-out 7)) 85)
(check-expect (length (spin-out 20)) 699050)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; factorial : PosInt -> PosInt
; (factorial n) returns the result of the factorial of n. We don't
; include zero as a valid input for this function

(define (factorial n)
  (cond
    [(zero? n) 1]
    [else (* n (factorial (sub1 n)))]))

(check-expect (factorial 1) 1)
(check-expect (factorial 2) 2)
(check-expect (factorial 3) 6)

; count-shortest-paths : Nat Nat -> Nat
; (count-shortest-paths n1 n2) returns the number of distinct shortest
; paths between the indicated square and the upper left corner with n1
; and n2 corresponding to positions on the board

#|
  Factorial Version

(define (count-shortest-paths n1 n2)
  (cond
    [(or (and (zero? n1) (zero? n2))
         (or (zero? n1) (zero? n2)))1]
    [else (/ (factorial (+ n1 n2)) (* (factorial n1) (factorial n2)))]))
|#

(define (count-shortest-paths n1 n2)
  (cond
    [(or (zero? n1)
         (zero? n2)) 1]
    [else (+ (count-shortest-paths (sub1 n1) n2)
             (count-shortest-paths n1 (sub1 n2)))]))

(check-expect (count-shortest-paths 0 0) 1)
(check-expect (count-shortest-paths 0 1) 1)
(check-expect (count-shortest-paths 1 0) 1)
(check-expect (count-shortest-paths 1 1) 2)
(check-expect (count-shortest-paths 1 2) 3)
(check-expect (count-shortest-paths 2 1) 3)
(check-expect (count-shortest-paths 2 2) 6)
(check-expect (count-shortest-paths 2 3) 10)
(check-expect (count-shortest-paths 2 7) 36)
(check-expect (count-shortest-paths 6 5) 462)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

;;;;; 6a

#|
  A [SortedListOf X] is a list of items assorted according to a given
  relation
|#

; insert-in-order : X [X X -> Bool] [SortedListOf X] -> [SortedListOf X]
; (insert-in-order item rel? ls) returns the result of inserting x into
; the correct location in the given list such that the result is in
; sorted order

(define (insert-in-order item rel? ls)
  (local
    [; help : [SortedListOf X] -> [SortedListOf X]
     (define (help ls)
       (cond
         [(empty? ls) (cons item ls)]
         [(rel? (first ls) item) (cons (first ls) (help (rest ls)))]
         [else (cons item ls)]))]
    (help ls)))

(check-expect (insert-in-order 3 < '(1 2 4 5 6 7 8))
              (list 1 2 3 4 5 6 7 8))
(check-expect (insert-in-order 5 > '(12 10 9 7 4 3 1 0))
              (list 12 10 9 7 5 4 3 1 0))
(check-expect
 (insert-in-order "dog" string<? '("ape" "bat" "cat" "pig" "rat"))
 (list "ape" "bat" "cat" "dog" "pig" "rat"))

;; 6b

; insertion-sort : [X X -> Bool] [ListOf X] -> [SortedListOf X]
; (insertion-sort rel? ls) returns the result of sorting the list
; according to the given relation

(define (insertion-sort rel? ls)
  (foldl (; X [ListOf X] -> [SortedListOf X]
          lambda (x y)
           (insert-in-order x rel? y))
         (list) ls))

(check-expect (insertion-sort < '(9 3 2 0 1 4 9 2 1))
              (list 0 1 1 2 2 3 4 9 9))
(check-expect (insertion-sort > '(9 3 2 0 1 4 9 2 1))
              (list 9 9 4 3 2 2 1 1 0))
(check-expect
 (insertion-sort string<?
                 '("cat" "bird" "ant" "frog" "cow" "dog" "gnu"))
 (list "ant" "bird" "cat" "cow" "dog" "frog" "gnu"))
(check-expect
 (insertion-sort string-ci>=?
                 '("Cat" "birD" "ant" "frog" "cOW" "dog" "GNU"))
 (list "GNU" "frog" "dog" "cOW" "Cat" "birD" "ant"))
(check-expect
 (insertion-sort
  (lambda (p1 p2)
    (< (posn-x p1) (posn-x p2)))
  (list (make-posn 2 3)
        (make-posn 9 5) (make-posn 7 4) (make-posn 3 2)))
 (list (make-posn 2 3)
       (make-posn 3 2) (make-posn 7 4) (make-posn 9 5)))

;;;;; 6c

(define inc1 (build-list 100 (lambda (i) (add1 i))))
(define inc2 (build-list 1000 (lambda (i) (add1 i))))
(define inc3 (build-list 10000 (lambda (i) (add1 i))))
(define inc4 (build-list 100000 (lambda (i) (add1 i))))
(define dec1 (build-list 100 (lambda (i) (sub1 i))))
(define dec2 (build-list 1000 (lambda (i) (sub1 i))))
(define dec3 (build-list 10000 (lambda (i) (sub1 i))))
(define dec4 (build-list 100000 (lambda (i) (sub1 i))))
(define rand1 (build-list 100 (lambda (i) (random 100))))
(define rand2 (build-list 1000 (lambda (i) (random 1000))))
(define rand3 (build-list 10000 (lambda (i) (random 10000))))
(define rand4 (build-list 100000 (lambda (i) (random 100000))))

; ignore : Any -> Bool
; (ignore x) returns #true

(define (ignore x) #true)

(check-expect (ignore 1) #true)

#|
  INSERTION SORT
       n       sorted        reverse sorted        random
  ------------------------------------------------------------
      100       15                  15               0
     1000       687                 719              359
    10000       70297               71063            36344
   100000       ??                  ??               ??


Windows 10 - 32 Bit Racket
|#

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;; 7a

; merge : [X X -> Bool] [ListOf X] [ListOf X] -> [SortedListOf X]
; (merge rel? ls1 ls2) return the result of combining the list elements
; into a single sorted list

(define (merge rel? ls1 ls2)
  (cond
    [(and (empty? ls1)
          (empty? ls2))
     '()]
    [(empty? ls1) ls2]
    [(empty? ls2) ls1]
    [(rel? (first ls1) (first ls2))
     (cons (first ls1) (merge rel? (rest ls1) ls2))]
    [else (cons (first ls2) (merge rel? ls1 (rest ls2)))]))

(check-expect (merge < '() '()) '())
(check-expect (merge < '(1 2 3) '(4 5 6 7 8))
              (list 1 2 3 4 5 6 7 8))
(check-expect (merge <= '(1 1 3 3 5 5 7 7) '(0 0 2 2 4 4 6 6))
              (list 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7))
(check-expect (merge > '(9 8 7 3 2 1) '(13 12 11 10 6 5 4))
              (list 13 12 11 10 9 8 7 6 5 4 3 2 1))
(check-expect (merge string<? '("cat" "dog" "pig") '("bat" "cow" "rat"))
              (list "bat" "cat" "cow" "dog" "pig" "rat"))

;;;;; 7b

; group-sorted-sequences :
; [X X -> Bool] [ListOf X] -> [ListOf [SortedListOf X]]
; (group-sorted-sequences rel? ls) returns the list with each sorted
; sequence grouped in a sublist

(define (group-sorted-sequences rel? ls)
  (cond
    [(empty? ls) '()]
    [(empty? (rest ls)) (list ls)]
    [else (local [(define ans (group-sorted-sequences rel? (rest ls)))]
            (cond
              [(rel? (first ls) (second ls))
               (cons (cons (first ls) (first ans)) (rest ans))]
              [else (cons (list (first ls)) ans)]))]))

(check-expect (group-sorted-sequences > '()) '())
(check-expect (group-sorted-sequences < '(1 2 3))
              (list (list 1 2 3)))
(check-expect (group-sorted-sequences >= '(2 2 2 2))
              (list (list 2 2 2 2)))
(check-expect (group-sorted-sequences < '(5 4 3 2 1))
              (list (list 5) (list 4) (list 3) (list 2) (list 1)))
(check-expect
 (group-sorted-sequences < '(1 2 3 4 2 3 4 5 6 1 2 9 8 7))
 (list (list 1 2 3 4) (list 2 3 4 5 6) (list 1 2 9) (list 8) (list 7)))

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

;;;;; 8a

; merge-adjacent-sequences :
; [X X -> Bool] [ListOf [SortedListOf X]] -> [SortedListOf X]
; (merge-adjacent-sequences rel? ls) returns the list after merging
; adjacent lists together

(define (merge-adjacent-sequences rel? ls)
  (cond
    [(empty? ls) ls]
    [(empty? (rest ls)) ls]
    [else (cons (merge rel? (first ls) (second ls))
                (merge-adjacent-sequences rel? (rest (rest ls))))]))

(check-expect (merge-adjacent-sequences < '()) '())
(check-expect (merge-adjacent-sequences < '((1 2))) (list (list 1 2)))
(check-expect (merge-adjacent-sequences < '((2 5) (4 7 8) (3 7) (6)))
              (list (list 2 4 5 7 8) (list 3 6 7)))
(check-expect
 (merge-adjacent-sequences < '((2 5) (4 7 8) (3 7) (6) (0 1)))
 (list (list 2 4 5 7 8) (list 3 6 7) (list 0 1)))
(check-expect
 (merge-adjacent-sequences
  <
  (group-sorted-sequences < '(1 2 3 4 2 3 4 5 6 1 2 9 8 7)))
 (list (list 1 2 2 3 3 4 4 5 6) (list 1 2 8 9) (list 7)))

;;;;; 8b

; mergesort : [X X -> Bool] [ListOf X] -> [SortedListOf X]
; (mergesort rel? ls) returns the result of sorting the elements in ls
; according to rel? using the Merge Sort algorithm

(define (mergesort rel? ls)
  (cond
    [(empty? ls) '()]
    [else (local
            [; help : [ListOf [ListOf X]] -> [SortedListOf X]
             (define (help ls)
               (cond
                 [(empty? (rest ls)) (first ls)]
                 [else (help (merge-adjacent-sequences rel? ls))]))]
            (help (group-sorted-sequences rel? ls)))]))

(check-expect (mergesort > '()) '())
(check-expect (mergesort > '(42)) (list 42))
(check-expect
 (mergesort string<? '("cow" "ant" "boa" "bat" "dog" "rat" "sow" "pig"))
 (list "ant" "bat" "boa" "cow" "dog" "pig" "rat" "sow"))
(check-expect (mergesort > '(1 2 3 4 5 6 7 8)) (list 8 7 6 5 4 3 2 1))
(check-expect (mergesort < '(8 7 6 5 4 3 2 1)) (list 1 2 3 4 5 6 7 8))
(check-expect
 (mergesort < '(-3 9 5 1 -4 15 -7 25 29 33 6 8 2 9 4 -3 9 10 29 55))
 (list -7 -4 -3 -3 1 2 4 5 6 8 9 9 9 10 15 25 29 29 33 55))

;;;;; 8c

#|
  MERGE SORT
       n       sorted        reverse sorted        random
  ------------------------------------------------------------
      100        0                  0                 0
     1000        0                  0                 31
    10000        31                 47                266
   100000        797                2719              5219

 Windows 10 - 32 Bit Racket
|#

;;;;; 8d

#|

In general, under all circumstances, mergesort is faster than
insertion-sort due to pre-grouping lists and then using the
merge-adjacent-sequences to do the rest of the work resulting in a
faster time.

Unlike insertion-sort, mergesort was able to produce a reasonable time
for inc4, dec4, and rand4 whereas insertion sort probably would've
crashed DrRacket had i left the program running for too long.

|#