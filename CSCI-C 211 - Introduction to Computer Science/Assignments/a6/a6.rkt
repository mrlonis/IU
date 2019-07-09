;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname a6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "a6")
(define collaboration-statement "I worked alone")

(require 2htdp/image)

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

(define a-cons (cons 3 (cons 8 (cons 2 empty))))
(define a-list (list 3 8 2))
(check-expect a-cons a-list)

;;;;; 1b

(define b-cons
  (cons (cons 5 empty) (cons
                        (cons 7 empty) (cons
                                        (cons 1 empty) empty))))

(define b-list (list (list 5) (list 7) (list 1)))
(check-expect b-cons b-list)

;;;;; 1c

(define c-cons
  (cons (cons 1 (cons 2 empty))
        (cons 7 (cons (cons 5 empty) empty))))

(define c-list
  (list (list 1 2) 7 (list 5)))
(check-expect c-cons c-list)

;;;;; 1d

(define d-cons
  (cons
   (cons '()
         (cons 8
               (cons
                (cons (cons 2 empty) empty) empty)))
  (cons 4 empty)))
(define d-list
  (list (list '() 8 (list (list 2))) 4))
(check-expect d-cons d-list)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

#|
 
   A NegInt is one of
   - -1
   - (sub1 NegInt)

   A ListOfNum is one of
   - '()
   - (cons Num ListOfNum)
|#

; process-nums : ListOfNum -> ...
; (process-nums a-num-list) returns ...

(define (process-nums a-num-list)
  (cond
    [(empty? a-num-list) ...]
    [else (... (first a-num-list) ...
               (process-nums (rest a-num-list)))]))

;;;;; 2a

; process-neg-int : NegInt -> ...
; (process-neg-int a-neg-int) returns ...

(define (process-neg-int a-neg-int)
  (cond
    [(zero? a-neg-int) ...]
    [else (... (process-neg-int (add1 a-neg-int)))]))

;;;;; 2b

; countup : NegInt -> ListOfNum
; (countup n) returns a ListOfNum starting with n and increasing
; by one each time until reaching zero

(define (countup n)
  (cond
    [(zero? n) (cons 0 empty)]
    [else (cons n (countup (add1 n)))]))

(check-expect (countup -1) (list -1 0))
(check-expect (countup -6)
              (list -6 -5 -4 -3 -2 -1 0))
(check-expect (countup -12)
              (list -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0))

;;;;; 2c

#|
(countup -5)
== (cond
     [(zero? -5) (cons 0 empty)]
     [else (cons -5 (countup (add1 -5)))]))
== (cond
     [#false (cons -5 empty)]
     [else (cons -5 (countup (add1 -5)))])
== (cond
     [else (cons -5 (countup (add1 -5)))]))
== (cons -5 (countup (add1 -5)))
== (cons -5 (countup -4))
== (cons -5 (cond
              [(zero? -4) (cons 0 empty)]
              [else (cons -4 (countup (add1 -4)))]))
== (cons -5 (cond
              [#false (cons 0 empty)]
              [else (cons -4 (countup (add1 -4)))]))
== (cons -5 (cond
              [else (cons -4 (countup (add1 -4)))]))
== (cons -5 (cons -4 (countup (add1 -4))))
== (cons -5 (cons -4 (countup -3)))
== (cons -5 (cons -4
                  (cond
                    [(zero? -3) (cons 0 empty)]
                    [else (cons -3 (countup (add1 -3)))])))
== (cons -5 (cons -4
                  (cond
                    [#false (cons 0 empty)]
                    [else (cons -3 (countup (add1 -3)))])))
== (cons -5 (cons -4
                  (cond
                    [else (cons -3 (countup (add1 -3)))])))
== (cons -5 (cons -4 (cons -3 (countup (add1 -3)))))
== (cons -5 (cons -4 (cons -3 (countup -2))))
== (cons -5
         (cons -4
               (cons -3
                     (cond
                       [(zero? -2) (cons 0 empty)]
                       [else (cons -2 (countup (add1 -2)))]))))
== (cons -5
         (cons -4
               (cons -3
                     (cond
                       [#false (cons 0 empty)]
                       [else (cons -2 (countup (add1 -2)))]))))
== (cons -5
         (cons -4
               (cons -3
                     (cond
                       [else (cons -2 (countup (add1 -2)))]))))
== (cons -5 (cons -4 (cons -3 (cons -2 (countup (add1 -2))))))
== (cons -5 (cons -4 (cons -3 (cons -2 (countup -1)))))
== (cons -5
         (cons -4
               (cons -3
                     (cons -2
                           (cond
                             [(zero? -1) (cons 0 empty)]
                             [else (cons -1 (countup (add1 -1)))])))))
== (cons -5
         (cons -4
               (cons -3
                     (cons -2
                           (cond
                             [#false (cons 0 empty)]
                             [else (cons -1 (countup (add1 -1)))])))))
== (cons -5
         (cons -4
               (cons -3
                     (cons -2
                           (cond
                             [else (cons -1 (countup (add1 -1)))])))))
== (cons -5 (cons -4 (cons -3 (cons -2 (cons -1 (countup (add1 -1)))))))
== (cons -5 (cons -4 (cons -3 (cons -2 (cons -1 (countup 0))))))
==
(cons -5
      (cons -4
            (cons -3
                  (cons -2
                        (cons -1
                              (cond
                                [(zero? 0) (cons 0 empty)]
                                [else (cons 0 (countup (add1 0)))]))))))
==
(cons -5
      (cons -4
            (cons -3
                  (cons -2
                        (cons -1
                              (cond
                                [#true (cons 0 empty)]
                                [else (cons 0 (countup (add1 0)))]))))))
== (cons -5 (cons -4 (cons -3 (cons -2 (cons -1 (cons 0 empty))))))
|#

;;;;; 2d

#|
   An Interval is of the form:
   (make-interval end-point1 end-point2)

   - end-point1 is the lower endpoint of the interval and end-point2
     is the upper end of the interval

   A ListOfInt is one of
   - '()
   - (cons Integer '())
|#

(define-struct interval [a b])

; make-interval : a b -> Interval
; interval? : Interval -> Bool
; interval-a : Interval -> Num
; interval-b : Interval -> Num

; process-interval : an-interval -> ...
; (process-interval an-interval) is my template for problem 7c

(define (process-interval an-interval)
  (... (interval-a an-interval) ...
       (interval-b an-interval) ...))

; explode-interval : Interval -> ListOfInt
; (explode-interval interval) returns a list of integers in the interval

(define (explode-interval interval)
  (cond
    [(equal? (interval-a interval)
             (interval-b interval))
     (cons (interval-a interval) empty)]
    [else (cons (interval-a interval)
                (explode-interval
                 (make-interval (add1 (interval-a interval))
                                (interval-b interval))))]))

(check-expect (explode-interval (make-interval -6 0))
              (list -6 -5 -4 -3 -2 -1 0))
(check-expect (explode-interval (make-interval -6 3))
              (list -6 -5 -4 -3 -2 -1 0 1 2 3))
(check-expect (explode-interval (make-interval 4 5))
              (list 4 5))
(check-expect (explode-interval (make-interval 0 0))
              (list 0))

;;;;; 2e

#|
== (explode-interval (make-interval -2 3))
== (cond
     [(equal? -2 3) (cons -2 empty)]
     [else (cons -2 (explode-interval (make-interval (add1 -2) 3)))])
== (cond
     [#false (cons (interval-a interval) empty)]
     [else (cons -2 (explode-interval (make-interval (add1 -2) 3)))])
== (cond
     [else (cons -2 (explode-interval (make-interval (add1 -2) 3)))])
== (cons -2 (explode-interval (make-interval (add1 -2) 3)))
== (cons -2 (explode-interval (make-interval -1 3)))
== (cons -2
         (cond
           [(equal? -1 3) (cons -1 empty)]
           [else (cons -1 (explode-interval
                           (make-interval (add1 -1) 3)))]))
== (cons -2 (cond
              [#false (cons -1 empty)]
              [else (cons -1 (explode-interval
                              (make-interval (add1 -1) 3)))]))
== (cons -2 (cond
              [else (cons -1 (explode-interval
                              (make-interval (add1 -1) 3)))]))
== (cons -2 (cons -1 (explode-interval (make-interval (add1 -1) 3))))
== (cons -2 (cons -1 (explode-interval (make-interval 0 3))))
== (cons -2 (cons -1
                  (cond
                    [(equal? 0 3) (cons 0 empty)]
                    [else (cons 0 (explode-interval
                                   (make-interval (add1 0) 3)))])))
== (cons -2 (cons -1 (cond
                       [#false (cons 0 empty)]
                       [else (cons 0
                                   (explode-interval
                                    (make-interval (add1 0) 3)))])))
== (cons -2 (cons -1 (cond
                       [else (cons 0 (explode-interval
                                      (make-interval (add1 0) 3)))])))
== (cons -2 (cons -1 (cons 0 (explode-interval
                              (make-interval (add1 0) 3)))))
== (cons -2 (cons -1 (cons 0 (explode-interval (make-interval 1 3)))))
== (cons -2
         (cons -1
               (cons 0
                     (cond
                       [(equal? 1 3) (cons 1 empty)]
                       [else (cons 1 (explode-interval
                                      (make-interval (add1 1) 3)))]))))
== (cons -2
         (cons -1
               (cons 0
                     (cond
                       [#false (cons 1 empty)]
                       [else (cons 1
                                   (explode-interval
                                    (make-interval (add1 1) 3)))]))))
== (cons -2
         (cons -1
               (cons 0
                     (cond
                       [else (cons 1 (explode-interval
                                      (make-interval (add1 1) 3)))]))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1 (explode-interval
                              (make-interval (add1 1) 3))))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1 (explode-interval (make-interval 2 3))))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1
                           (cond
                             [(equal? 2 3) (cons 2 empty)]
                             [else
                              (cons 2
                                    (explode-interval
                                     (make-interval (add1 2) 3)))])))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1
                           (cond
                             [#false (cons 2 empty)]
                             [else
                              (cons 2
                                    (explode-interval
                                     (make-interval (add1 2) 3)))])))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1
                           (cond
                             [else
                              (cons 2
                                    (explode-interval
                                     (make-interval (add1 2) 3)))])))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1
                           (cons 2 (explode-interval
                                    (make-interval (add1 2) 3)))))))
== (cons -2
         (cons -1
               (cons 0
                     (cons 1
                           (cons 2
                                 (explode-interval
                                  (make-interval 3 3)))))))
==
(cons -2
      (cons -1
            (cons 0
                  (cons 1
                        (cons 2
                              (cond
                                [(equal? 3 3) (cons 3 empty)]
                                [else
                                 (cons 3
                                       (explode-interval
                                        (make-interval
                                         (add1 3) 3)))]))))))
==
(cons -2
      (cons -1
            (cons 0
                  (cons 1
                        (cons 2
                              (cond
                                [#true (cons 3 empty)]
                                [else
                                 (cons 3
                                       (explode-interval
                                        (make-interval
                                         (add1 3) 3)))]))))))
== (cons -2 (cons -1 (cons 0 (cons 1 (cons 2 (cons 3 empty))))))
|#

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

#|
  A Coin is one of:
  - 'penny
  - 'nickel
  - 'dime
  - 'quarter

  A PiggyBank is one of:
  - '()
  - (cons Coin '())
|#

; process-piggy-bank : PiggyBank -> ...
; (process-piggy-bank a-piggy-bank) returns ...

(define (process-piggy-bank a-piggy-bank)
  (cond
    [(empty? a-piggy-bank) ...]
    [else (... (first a-piggy-bank) ...
               (process-piggy-bank (rest a-piggy-bank)))]))

; penny-pincher : PiggyBank -> PiggyBank
; (penny-pincher piggy-bank) returns the input PiggyBank with all the
; pennies removed

(define (penny-pincher piggy-bank)
  (cond
    [(empty? piggy-bank) empty]
    [(equal? (first piggy-bank) 'penny)
     (penny-pincher (rest piggy-bank))]
    [else (cons (first piggy-bank) (penny-pincher (rest piggy-bank)))]))

(check-expect (penny-pincher (list))
              '())
(check-expect (penny-pincher (list 'quarter))
              (list 'quarter))
(check-expect (penny-pincher (list 'penny 'penny 'penny 'penny))
              '())
(check-expect (penny-pincher '(penny quarter dime penny nickel penny))
              (list 'quarter 'dime 'nickel))

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

#|
  A NatE is one of:
  - Nat
  - (error "waldo is nowhere to be found")
|#

; wheres-waldo : List -> NatE
; (wheres-waldo waldo-list) returns  the indec n of the leftmost
; occurence of 'waldo

(define (wheres-waldo waldo-list)
  (cond
    [(member 'waldo waldo-list)
     (cond
       [(equal? (list-ref waldo-list 0) 'waldo) 0]
       [(equal? (list-ref waldo-list 1) 'waldo) 1]
       [(equal? (list-ref waldo-list 2) 'waldo) 2]
       [(equal? (list-ref waldo-list 3) 'waldo) 3]
       [(equal? (list-ref waldo-list 4) 'waldo) 4]
       [(equal? (list-ref waldo-list 5) 'waldo) 5]
       [(equal? (list-ref waldo-list 6) 'waldo) 6]
       [(equal? (list-ref waldo-list 7) 'waldo) 7]
       [(equal? (list-ref waldo-list 8) 'waldo) 8]
       [(equal? (list-ref waldo-list 9) 'waldo) 9]
       [(equal? (list-ref waldo-list 10) 'waldo) 10]
       [(equal? (list-ref waldo-list 11) 'waldo) 11]
       [(equal? (list-ref waldo-list 12) 'waldo) 12]
       [(equal? (list-ref waldo-list 13) 'waldo) 13]
       [(equal? (list-ref waldo-list 14) 'waldo) 14]
       [(equal? (list-ref waldo-list 15) 'waldo) 15]
       [(equal? (list-ref waldo-list 16) 'waldo) 16]
       [(equal? (list-ref waldo-list 17) 'waldo) 17]
       [(equal? (list-ref waldo-list 18) 'waldo) 18]
       [(equal? (list-ref waldo-list 19) 'waldo) 19])]
    [else (error "waldo is nowhere to be found")]))

(check-expect (wheres-waldo '(waldo)) 0)
(check-expect (wheres-waldo '(beach zoo ski-slope waldo france camping))
              3)
(check-error (wheres-waldo '(ranier rushmore kilimanjaro everest))
             "waldo is nowhere to be found")
(check-expect
 (wheres-waldo '(water water waldo water water water waldo waldo))
 2)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; pick-one-at-random : Any Any -> Any
; (pick-one-at-random any-1 any-2) returns one of the inputs at random

(define (pick-one-at-random any-1 any-2)
  (cond
    [(equal? 1 (random 2)) any-1]
    [else any-2]))

(check-random (pick-one-at-random 1 -1) (pick-one-at-random 1 -1))
(check-random (pick-one-at-random 'left 'right)
              (pick-one-at-random 'left 'right))
(check-random (pick-one-at-random "heads" "tails")
              (pick-one-at-random "heads" "tails"))
(check-random (pick-one-at-random #true #false)
              (pick-one-at-random #true #false))

#|
  A ListOfIntS is one of
  - '()
  - (cons Integer '()
  - (cons Integer 'happy '())
  - (cons Integer 'sad '())
|#

; mouse-journey : Int Int Int : ListOfIntS
; (mouse-journey cat mouse cheese) returns a ListOfIntS that simulates
; the movement of a mouse, each Int corresponding to the location the
; mouse visits. If the mouse ends at the cheese the journey was 'happy.
; If the mouse finishes it's journey at the cat its journey was 'sad.

(define (mouse-journey cat mouse cheese)
  (cond
    [(= mouse cheese) (cons cheese (cons 'happy empty))]
    [(= mouse cat) (cons cat (cons 'sad empty))]
    [else (cons mouse
                (mouse-journey cat
                               (pick-one-at-random
                                (sub1 mouse)
                                (add1 mouse))
                               cheese))]))

(check-random (mouse-journey 0 3 6) (mouse-journey 0 3 6))
(check-random (mouse-journey 7 4 -1) (mouse-journey 7 4 -1))
(check-random (mouse-journey 1 2 3) (mouse-journey 1 2 3))
(check-random (mouse-journey 3 2 1) (mouse-journey 3 2 1))
(check-random (mouse-journey -5 0 7) (mouse-journey -5 0 7))

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

#|
  A 1String is a String of length = 1

  A String is one of
  - ""
  - (string-append 1String String)
|#

; process-string : String -> ...
; (process-string a-string) returns ...

(define (process-string a-string)
  (cond
    [(equal? a-string "") ...]
    [else (... (string-ith a-string 0) ...
               (process-string
                (substring a-string 1)))]))

;;;;; 6a

; misspell : 1String -> 1String
; (misspell 1-string) returns the (possibly) misspelled version by
; applying the four change rules given bellow

#|
  The four change rules are:
  1. "s" = "5"
  2. "e" = "3"
  3. "l" = "1"
  4. "o" = "0"
|#

(define (misspell 1-string)
  (cond
    [(equal? 1-string "s") "5"]
    [(equal? 1-string "e") "3"]
    [(equal? 1-string "l") "1"]
    [(equal? 1-string "o") "0"]
    [else 1-string]))

(check-expect (misspell "s") "5")
(check-expect (misspell "e") "3")
(check-expect (misspell "l") "1")
(check-expect (misspell "o") "0")
(check-expect (misspell "x") "x")

;;;;; 6b

; leet-speak : String -> String
; (leet-speak string) returns the string with the result of
; misspell-ing all the letters in string

(define (leet-speak string)
  (cond
    [(equal? string "") ""]
    [else (string-append (misspell (string-ith string 0))
                         (leet-speak
                          (substring string 1)))]))

(check-expect (leet-speak "") "")
(check-expect (leet-speak "leet speak neat speak")
              "133t 5p3ak n3at 5p3ak")
(check-expect (leet-speak "foolishness") "f001i5hn355")

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

#|
  A WholeNum is one of
  - 1
  - (add1 WholeNum)

  A ListOfImg is one of
  - '()
  - (cons Image '())

  A ListOfPosn is one of
  - '()
  - (cons (make-posn Nat Nat) '())
|#

; starry-night-helper1 : Nat Nat Nat -> ListOfImg
; (starry-noght-helper1 num-stars width height) returns a ListOfImg
; with the list containing the same white circle num-stars times

(define (starry-night-helper1 num-stars width height)
  (cond
    [(= num-stars 0) '()]
    [else (cons (circle 1 "solid" "white")
                (starry-night-helper1 (sub1 num-stars)
                                      width height))]))

#|
(check-satisfied (starry-night-helper1 0 300 50) list?)
(check-satisfied (starry-night-helper1 5 300 50) list?)
(check-satisfied (starry-night-helper1 100 50 75) list?)
(check-satisfied (starry-night-helper1 2000 500 300) list?)
|#

; starry-night-helper2 : Nat Nat Nat -> ListOfPosn
; (starry-night-helper2 num-stars width height) returns a ListOfPosns
; with the number of items in the list equalling num-stars

(define (starry-night-helper2 num-stars width height)
  (cond
    [(= 0 num-stars) '()]
    [else (cons (make-posn (random width) (random height))
                (starry-night-helper2 (sub1 num-stars)
                                      width height))]))

#|
(check-satisfied (starry-night-helper2 0 300 50) list?)
(check-satisfied (starry-night-helper2 5 300 50) list?)
(check-satisfied (starry-night-helper2 100 50 75) list?)
(check-satisfied (starry-night-helper2 2000 500 300) list?)
|#

; make-starry-night : Nat Nat Nat -> Img
; (make-starry-night num-stars width height) returns an image
; of white circle at an amount equal to num-stars on a black screen
; with a width and a height

(define (make-starry-night num-stars width height)
  (cond
    [(= num-stars 0) (rectangle width height "solid" "black")]
    [else (place-images (starry-night-helper1 num-stars width height)
                        (starry-night-helper2 num-stars width height)
                        (rectangle width height "solid" "black"))]))

(check-satisfied (make-starry-night 0 300 50) image?)
(check-satisfied (make-starry-night 5 300 50) image?)
(check-satisfied (make-starry-night 100 50 75) image?)
(check-satisfied (make-starry-night 2000 500 300) image?)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

#|
  An RGB is an Int in the range [0..255]

  A Color is one of
  - String
  - (make-color RGB RGB RGB 255)
  - (make-color RGB RGB RGB RGB 255)
|#


;;;;; 8a

; shade-of-gray : RGB -> Color
; (shade-of-gray n) returns a color structure with the three red
; green and blue inputs corresponding to n and the alpha input
; corresponding to 255

(define (shade-of-gray n)
  (make-color n n n 255))

(check-expect (shade-of-gray 100) (make-color 100 100 100 255))
(check-expect (shade-of-gray 220) (make-color 220 220 220 255))
(check-satisfied (shade-of-gray 100) color?)
(check-satisfied (shade-of-gray 220) color?)

;;;;; 8b

; 8b-helper : Nat Num Nat Num -> ListOfImg
; (8b-helper n color-factor radius radius-factor) returns a list of n
; images decreasing by the radius-factor and changing color by the
; color-factor

(define (8b-helper n color-factor radius radius-factor)
  (cond
    [(or (zero? n)
         (<= radius 0))
     '()]
    [else (cons
           (circle radius "solid"
                   (shade-of-gray (round (+ 255 (* color-factor n)))))
           (8b-helper (sub1 n)
                      color-factor
                      (round ( - radius radius-factor))
                      radius-factor))]))

; diminishing-circles : Nat -> ListOfImg
; (diminishing-circles n radius) returns a lost of n images each of
; which is a solid circle. The first circle in the list is black and
; has a radius corresponding to the radius variable. Subsequent circles
; get smaller and smaller, as well as lighter and lighter. The radius
; and shade of each circle changes in proportion to n.

(define (diminishing-circles n radius)
  (8b-helper
   n
   (* -1 (/ 255 n))
   radius
   (/ radius n)))

(define ls (diminishing-circles 10 50))
(check-expect (list (image-width (first ls))
                    (image-width (second ls))
                    (image-width (third ls))) (list 100 90 80))
(define colorway (diminishing-circles 15 60))
(check-expect (list (image-width (first colorway))
                    (image-width (second colorway))
                    (image-width (third colorway))) (list 120 112 104))

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

;;;;; 9a

; make-square : String -> Image
; (make-square color) returns a 20 by 20 square with the color of the
; square corresponding to the input

(define (make-square color)
  (square 20 "solid" color))

;;;;; 9b

; make-column : Nat Img Img -> Img
; (make-column n image1 image2) returns an image that results from
; stacking the given images one on top of the other in an alternating
; pattern of height n

(define (make-column n image1 image2)
  (cond
    [(= n 0) empty-image]
    [(= n 1) image1]
    [else (above image1 image2 (make-column (- n 2) image1 image2))]))

(check-expect
 (image-width
  (make-column 0 (make-square "red") (make-square "green"))) 0)
(check-satisfied
 (make-column 3 (make-square "orange") (make-square "black")) image?)
(check-expect
 (image-width
  (make-column 3 (make-square "orange") (make-square "black"))) 20)
(check-expect
 (image-height
  (make-column 3 (make-square "orange") (make-square "black"))) 60)
(check-satisfied
 (make-column 8 (make-square "red") (make-square "green")) image?)
(check-satisfied
 (make-column 4
              (make-column 2
                           (make-square "blue") (make-square "yellow"))
              (make-column 2
                           (make-square "red") (make-square "green")))
 image?)

;;;;; 9c

; make-row : Nat Img Img -> Img
; (make-row n image1 image2) returns the image that results from
; placing the given images one next to the other in an alternating
; pattern of width n

(define (make-row n image1 image2)
  (cond
    [(= n 0) empty-image]
    [(= n 1) image1]
    [else (beside image1 image2 (make-row (- n 2) image1 image2))]))

(check-expect
 (image-width (make-row 0 (make-square "red") (make-square "green"))) 0)
(check-satisfied
 (make-row 8 (make-square "black") (make-square "cyan")) image?)
(check-expect
 (image-width
  (make-row 8 (make-square "black") (make-square "cyan"))) 160)
(check-expect
 (image-height
  (make-row 8 (make-square "black") (make-square "cyan"))) 20)
(check-satisfied
 (make-row 25 (make-square "red") (make-square "green")) image?)
(check-satisfied
 (make-row 7
           (make-row 2 (make-square "blue") (make-square "yellow"))
           (make-row 2 (make-square "red") (make-square "green")))
 image?)

;;;;; 9d

; make-checkerboard : Nat Color Color -> Img
; (make-checkerboard n color1 color2) returns an image of squares with n
; representing the number of squares per row and column. The color of
; the top left square corresponds to color1 and the colors alternate
; either right or below by color2 and then back to color1

(define (make-checkerboard n color1 color2)
  (make-row n
            (make-column n (make-square color1) (make-square color2))
            (make-column n (make-square color2) (make-square color1))))

(check-satisfied (make-checkerboard 1 "blue" "pink") image?)
(check-satisfied (make-checkerboard 3 "pink" "blue") image?)
(check-satisfied (make-checkerboard 8 "green" "yellow") image?)
(check-satisfied
 (make-checkerboard 12 (shade-of-gray 50) (shade-of-gray 200)) image?)

;;;;;;;;;;;;;;;;
;; Problem 10 ;;
;;;;;;;;;;;;;;;;

; make-lumberjack-plaid : Nat Nat -> Img
; (make-lumberjack-plaid num-rows num-cols) returns an image resembling
; the fabric for a lumberjack plaid shirt with the number or columns
; and rows corresponding to the inputs

(define (make-lumberjack-plaid num-rows num-cols)
  (make-row
   num-cols
   (make-column num-rows (make-square "darkred") (make-square "black"))
   (make-column num-rows (make-square "red") (make-square "darkred"))))

(check-satisfied (make-lumberjack-plaid 2 2) image?)
(check-satisfied (make-lumberjack-plaid 2 11) image?)
(check-satisfied (make-lumberjack-plaid 15 23) image?)