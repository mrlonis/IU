;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a9")
(define collaboration-statement "I worked alone.")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

(define (last-positive/slow nums)
  (cond
    [(empty? nums) #false]
    [(positive? (first nums))
     (if (false? (last-positive/slow (rest nums)))
         (first nums)
         (last-positive/slow (rest nums)))]
    [else
     (last-positive/slow (rest nums))]))

;;;;; 1a

#|
  A ListOfInt is one of
  - '()
  - (cons Int ListOfInt)
|#

; last-positive/slow : ListOfInt -> Int
; (last-positive/slow nums) takes a ListOfInt and returns the last
; positive Int in the ListOfInt

(define nums (make-list 23 3))

(check-expect (last-positive/slow (list 0 2 -4 1)) 1)
(check-expect (last-positive/slow (list -2 -3 -4 5)) 5)

; When I run (last-positive/slow nums) it takes a very long time to get
; the answer of 3 returned to me

;;;;; 1b

#|

(last-positive '(0 2 -4 1))
== (last-positive '(2 -4 1))
== (if (false? (last-positive '(-4 1)))
       (first '(2 -4 1))
       (last-positive (rest '(2 -4 1))))
== (if (false? (last-positive '(1)))
       (first '(2 -4 1))
       (last-positive (rest '(2 -4 1))))
== (if (false? 1)
       (first '(2 -4 1))
       (last-positive (rest '(2 -4 1))))
== (last-positive (rest '(2 -4 1)))
== (last-positive '(-4 1))
== (if (false? (last-positive '(1)))
       (first '(2 -4 1))
       (last-positive (rest '(2 -4 1))))
== (if (false? 1)
       (first '(2 -4 1))
       (last-positive (rest '(2 -4 1))))
== (last-positive (rest '(-4 1)))
== (last-positive '(1))
== (if (false? #false)
       (first '(1))
       (last-positive (rest '(1))))
== (first '(1))
== 1

|#

;;;;; 1c

; last-positive/fast : ListOfInt -> Int
; (last-positive/fast nums) takes a ListOfInt and returns the last
; positive Int in the ListOfInt

(define (last-positive/fast nums)
  (cond
    [(empty? nums) #false]
    [else (local [(define ans (last-positive/fast (rest nums)))]
            (if (and (false? ans)
                     (positive? (first nums)))
                (first nums)
                ans))]))

(check-expect (last-positive/fast nums) 3)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; next-collatz : Int -> Int
; (next-collatz n) retunrs the next number in the collatz sequence
; after input n

(define (next-collatz n)
  (cond
    [(even? n) (quotient n 2)]
    [(odd? n) (+ (* 3 n) 1)]
    [else "error"]))

(check-expect (next-collatz 7) 22)
(check-expect (next-collatz 22) 11)
(check-expect (next-collatz 1) 4)
(check-expect (next-collatz 5) 16)
(check-expect (next-collatz 6) 3)
(check-expect (next-collatz 16) 8)

;;;;; 2a

#|
  A Nat is one of
  - 0
  - (add1 Nat)
|#

; collatz-steps-helper : Nat Nat -> Nat
; (collatz-steps-helper num step) returns the number of steps needed
; for a Collatz sequence starting at num to return the value 1

(define (collatz-steps-helper num step)
  (cond
    [(= 1 num) step]
    [else (collatz-steps-helper (next-collatz num) (add1 step))]))

; collatz-steps : Nat -> Nat
; (collatz-steps num) takes a positive integer, num, and returns the
; number of steps until the collatz sequence starting at num reaches 1

(define (collatz-steps num)
  (collatz-steps-helper num 0))

(check-expect (collatz-steps 7) 16)
(check-expect (collatz-steps 1) 0)
(check-expect (collatz-steps 2000) 112)

;;;;; 2b

#|
  A ListOfNat is one of
  - '()
  - (cons Nat ListOfNat)
|#

; collatz-sequence : Nat -> ListOfNat
; (collatz-sequence num) takes num and retruns a list of numbers in the
; collatz sequence starting with num and ending with 1

(define (collatz-sequence num)
  (cond
    [(= num 1) (cons 1 '())]
    [else (cons num (collatz-sequence (next-collatz num)))]))

(check-expect (length (collatz-sequence 7)) (add1 (collatz-steps 7)))
(check-expect (collatz-sequence 7)
              (list 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1))
(check-expect (collatz-sequence 1) (list 1))

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

(define img1 (square 20 "solid" "orange"))
(define img2 (square 20 "solid" "indigo"))

; make-column : Nat Img Img -> Img
; (make-column n img1 img2) returns the images stacked on top of each
; other in an alternating fashion until n reaches 0 due to recursion

(define (make-column n img1 img2)
  (cond
    [(zero? n) empty-image]
    [else (above img1
                 (make-column (sub1 n) img2 img1))]))

(check-satisfied (make-column 10 img1 img2) image?)
(check-expect (image-width (make-column 10 img1 img2)) 20)
(check-expect (image-height (make-column 10 img1 img2)) 200)

; make-row : Nat Img Img -> Img
; (make-row n img1 img2) returns the images stacked side by side of each
; other in an alternating fashion until n reaches 0 due to recursion

(define (make-row n img1 img2)
  (cond
    [(zero? n) empty-image]
    [else (beside img1
                  (make-row (sub1 n) img2 img1))]))

(check-satisfied (make-row 10 img1 img2) image?)
(check-expect (image-width (make-row 10 img1 img2)) 200)
(check-expect (image-height (make-row 10 img1 img2)) 20)

;;;;; 3a

#|
  A ListOfSym is one of
  - '()
  - (cons Symbol ListOfSym)
|#

; oscillate : Nat Symbol Symbol -> ListOfSym
; (oscillate n this that)  takes a natural number n and two items,
; this and that, and returns a list of length n items alternating
; between this and that, and starting with this.

(define (oscillate n this that)
  (cond
    [(zero? n) '()]
    [else (cons this
                (oscillate (sub1 n) that this))]))

(check-expect (oscillate 4 'boo 'hoo) (list 'boo 'hoo 'boo 'hoo))
(check-expect (oscillate 9 'X 'O) (list 'X 'O 'X 'O 'X 'O 'X 'O 'X))

;;;;; 3b

; make-stack : Function Any Nat Any Any
; (make-stack combine initial num this that) takes a "combining"
; function, an initial value, a natural number, and two items to
; alternate. It returns the result of alternating the two items to
; obtain a stack of size n

(define (make-stack combine initial num this that)
  (cond
    [(zero? num) initial]
    [else (combine this
                   (make-stack combine initial (sub1 num) that this))]))

(check-satisfied (make-stack above empty-image 7 img1 img2) image?)
(check-satisfied (make-stack beside empty-image 16 img1 img2) image?)
(check-expect (make-stack string-append "" 42 "0" "1")
              "010101010101010101010101010101010101010101")
(check-expect (make-stack + 0 1000 1 -1) 0)
(check-satisfied
 (local [(define (combine x y) (overlay x (scale 1.1 y)))]
   (make-stack combine empty-image 30 img1 img2)) image?)

;;;;; 3c

; hugs-and-kisses : Nat -> ListOfSym
; (hugs-and-kisses n) returns a list of n alternating symbols 'X 'O
; starting with 'X

(define (hugs-and-kisses n)
  (make-stack cons '() n 'X 'O))

(check-expect (hugs-and-kisses 0) '())
(check-expect (hugs-and-kisses 3) (list 'X 'O 'X))
(check-expect (hugs-and-kisses 8) (list 'X 'O 'X 'O 'X 'O 'X 'O))


;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;;;;; 4a

#|
  A ListOfNums is one of
  - '()
  - (cons Num ListOfNums)
|#

; any-greater-than-seven? : ListOfNums -> Boolean
; (any-greater-than-seven? nums) returns #true if any number in nums
; is greater than 7, and #false otherwise

(define (any-greater-than-seven? nums)
  (cond
    [(empty? nums) #false]
    [else (local
            [(define recursion (any-greater-than-seven? (rest nums)))]
            (cond
              [(> (first nums) 7) #true]
              [else recursion]))]))

(check-expect (any-greater-than-seven? '()) #false)
(check-expect (any-greater-than-seven? '(3 8 10 3 1)) #true)
(check-expect (any-greater-than-seven? '(5 6 0 1 2 3 2 1)) #false)

;;;;; 4b

; any-greater-than? : Num ListOfNums -> Boolean
; (any-greater-than? x nums)  takes a number x and a list of numbers
; nums, and returns #true if any number in nums is greater than x, and
; #false otherwise

(define (any-greater-than? x nums)
  (cond
    [(empty? nums) #false]
    [else (local
            [(define recursion (any-greater-than? x (rest nums)))]
            (cond
              [(> (first nums) x) #true]
              [else recursion]))]))

(check-expect (any-greater-than? 7 '(3 6 7 2 1)) #false)
(check-expect (any-greater-than? 5 '(3 6 8 2 1)) #true)
(check-expect (any-greater-than? 0 '(-1.1 -2.2 -3.3 4.4 -5.5)) #true)
(check-expect (any-greater-than? 5 '()) #false)

;;;;; 4c

; <> : Num Num -> Boolean
; (<> x1 x2) returns #true if and only if x1 and x2 are not equal

(define (<> x1 x2)
  (not (= x1 x2)))

(check-expect (<> 4 5) #true)
(check-expect (<> 1/2 3/4) #true)
(check-expect (<> 32 (* 2 2 2 2 2)) #false)

;;;;; 4d

; A Rel? is a [Num Num -> Bool]

; any? : Rel? Num ListOfNums -> Boolean
; (any? relational-predicate x nums) takes a relational predicate on
; numbers (such as >) and a number x and a list of numbers nums, and
; returns #true if any number in nums is related to x (according to the
; given predicate), and #false otherwise

(define (any? relational-predicate x nums)
  (cond
    [(empty? nums) #false]
    [else (local
            [(define recursion
               (any? relational-predicate x (rest nums)))]
            (cond
              [(relational-predicate (first nums) x) #true]
              [else recursion]))]))

(check-expect (any? > 7 '(3 6 8 2 1)) #true)
(check-expect (any? > 8 '(3 6 8 2 1)) #false)
(check-expect (any? <= 0 '(-1.1 -2.2 -3.3 4.4 -5.5)) #true)
(check-expect (any? <> 0 '(0 0 0 0 0 0 0 0)) #false)
(check-expect (any? <> 1 '(1 1 1 1 0 1 1 1)) #true)