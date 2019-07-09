;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "a5")
(define collaboration-statement "I worked alone")

(require 2htdp/image)

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

#|
   A Nat is one of:
   - 0
   - (add1 nat)
|#

;;;;; 1a

; b-o-b : Nat -> String
; (b-o-b nat) returns a phrase based off of the Nat provided

(define (b-o-b nat)
  (cond
    [(zero? nat) "no more bottles of beer"]
    [(= nat 1) (string-append (number->string nat) " bottle of beer")]
    [(integer? nat) (string-append (number->string nat)
                                   " bottles of beer")]
    [else (error "invalid input")]))

(check-expect (b-o-b 0) "no more bottles of beer")
(check-expect (b-o-b 1) "1 bottle of beer")
(check-expect (b-o-b 2) "2 bottles of beer")
(check-expect (b-o-b 3) "3 bottles of beer")
(check-expect (b-o-b 99) "99 bottles of beer")

;;;;; 1b

; verses : Nat -> String
; (verses nat) returns a string describing the number of versus of the
; song "99 Bottles of Beer on the Wall"

(define (verses nat)
  (cond
    [(zero? nat) ""]
    [(and
      (<= nat 99)
      (integer? nat))
     (string-append (b-o-b nat) " on the wall, " (b-o-b nat) "."
                    "\nTake one down and pass it around, "
                    (b-o-b (sub1 nat)) " on the wall."
                    "\n" (verses (sub1 nat)))]
    [else (error "invalid input")]))

(check-expect (verses 0) "")
(check-expect
 (verses 1) "1 bottle of beer on the wall, 1 bottle of beer.
Take one down and pass it around, no more bottles of beer on the wall.
")
(check-expect (string-length (verses 1)) 119)
(check-expect
 (verses 2) "2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.
1 bottle of beer on the wall, 1 bottle of beer.
Take one down and pass it around, no more bottles of beer on the wall.
")
(check-expect (string-length (verses 2)) 233)
(check-expect (string-length (verses 99)) 11657)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; mystery : Nat -> Int
; (mystery n) returns ???

(define (mystery n)
  (cond
    [(zero? n) -13]
    [else (+ 7 (mystery (- n 2)))]))

#|
  (mystery 2)
  == (cond
       [(zero? 2) -13]
       [else (+ 7 (mystery (- 2 2))])
  == (cond
       [#false -13]
       [else (+ 7 (mystery (- 2 2))])
  == (+ 7 (mystery (- 2 2))
  == (+ 7 (mystery 0))
  == (+ 7 (cond
            [(zero? 0) -13]
            [else (+ 7 (mystery (- 0 2)))]))
  == (+ 7 (cond
            [#true -13]
            [else (+ 7 (mystery (- 0 2)))]))
  == (+ 7 -13)
  == -6
|#

; what-the? : Int -> Bool
; (what-the? n) returns ???

(define (what-the? n)
  (cond
    [(negative? n) #false]
    [(odd? n) (what-the? (- n 2))]
    [else (/ n 0)]))

#|
  (what-the? 5)
  == (cond
       [(negative? 5) #false]
       [(odd? 5) (what-the? (- 5 2))]
       [else (/ 5 0)])
  == (cond
      [#false #false]
      [(odd? 5) (what-the? (- 5 2))]
      [else (/ 5 0)])
  == (cond
      [(odd? 5) (what-the? (- 5 2))]
      [else (/ 5 0)])
  == (cond
       [#true (what-the? (- 5 2))]
       [else (/ 5 0)])
  == (what-the? (- 5 2))
  == (what-the? 3)
  == (cond
       [(negative? 3) #false]
       [(odd? 3) (what-the? (- 3 2))]
       [else (/ 3 0)])
  == (cond
      [#false #false]
      [(odd? 3) (what-the? (- 3 2))]
      [else (/ 3 0)])
  == (cond
      [(odd? 3) (what-the? (- 3 2))]
      [else (/ 3 0)])
  == (cond
       [#true (what-the? (- 3 2))]
       [else (/ 3 0)])
  == (what-the? (- 3 2))
  == (what-the? 1)
  == (cond
       [(negative? 1) #false]
       [(odd? 1) (what-the? (- 1 2))]
       [else (/ 1 0)])
  == (cond
      [#false #false]
      [(odd? 1) (what-the? (- 1 2))]
      [else (/ 1 0)])
  == (cond
      [(odd? 1) (what-the? (- 1 2))]
      [else (/ 1 0)])
  == (cond
       [#true (what-the? (- 1 2))]
       [else (/ 1 0)])
  == (what-the? (- 1 2))
  == (what-the? -1)
  == (cond
       [(negative? -1) #false]
       [(odd? -1) (what-the? (- -1 2))]
       [else (/ -1 0)])
  == (cond
       [#true #false]
       [(odd? -1) (what-the? (- -1 2))]
       [else (/ -1 0)])
  == #false
|#

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

;;;;; 3a

; process-nat : Nat -> ...
; (process-nat a-nat) returns ...

(define (process-nat a-nat)
  (cond
    [(zero? a-nat) ...]
    [else (... (process-nat (sub1 a-nat)))]))

;;;;; 3b

; sum-of-squares : Nat -> Nat
; (sum-of-squares n) retunrs the sum of the square of the first n
; integers

(define (sum-of-squares n)
  (cond
    [(zero? n) 0]
    [else (+ (expt n 2) (sum-of-squares (sub1 n)))]))

(check-expect (sum-of-squares 0) 0)
(check-expect (sum-of-squares 3) 14)
(check-expect (sum-of-squares 4) 30)
(check-expect (sum-of-squares 100) 338350)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;;;;; 4a

#|
  A ListOfNat is one of
  - '()
  - (cons Nat ListOfNat)
|#

;;;;; 4b

; process-nats : ListOfNat -> ...
; (process-nats a-nat-list) returns ...

(define (process-nats a-nat-list)
  (cond
    [(empty? a-nat-list) ...]
    [else (... (first a-nat-list) ...
               (process-nats (rest a-nat-list)))]))

;;;;; 4c

; sweet? : -> Number -> Boolean
; (sweet? n) retunrs a boolean value of #true if n is divisible
; by 3 or 5 or #false otherwise

(define (sweet? n)
  (cond
    [(= 0 (remainder n 3)) #true]
    [(= 0 (remainder n 5)) #true]
    [else #false]))

(check-expect (sweet? 6) #true)
(check-expect (sweet? 10) #true)
(check-expect (sweet? 100) #true)
(check-expect (sweet? 36) #true)
(check-expect (sweet? 99) #true)
(check-expect (sweet? 5555) #true)
(check-expect (sweet? 8) #false)

; count-sweets : ListOfNat -> Nat
; (count-sweets NatList) returns the number of numbers in the list that
; are multiples of either 3 or 5

(define (count-sweets nat-list)
  (cond
    [(empty? nat-list) 0]
    [else (+ (cond
               [(sweet? (first nat-list)) 1]
               [else 0])
             (count-sweets (rest nat-list)))]))

(check-expect (count-sweets '()) 0)
(check-expect (count-sweets (cons 12 '())) 1)
(check-expect (count-sweets
               (cons 55
                     (cons 22
                           (cons 0
                                 (cons 7
                                       (cons 42 '())))))) 3)

;;;;; 4d

; sweets-only : ListOfNat -> List
; (sweets-only NatList) returns ListOfNat as a list with all of the
; non-sweet valus removed

(define (sweets-only nat-list)
  (cond
    [(equal? (count-sweets nat-list) 0) empty]
    [else (append
           (cond
             [(sweet? (first nat-list)) (cons (first nat-list) '())]
             [else empty])
           (sweets-only (rest nat-list)))]))

(check-satisfied (sweets-only '()) empty?)
(check-satisfied
 (sweets-only
  (cons 13
        (cons 2
              (cons 8
                    (cons 11
                          (cons 4
                                (cons 7 '()))))))) empty?)
(check-expect
 (sweets-only
  (cons 55
        (cons 22
              (cons 0
                    (cons 7
                          (cons 42 '()))))))
 (cons 55 (cons 0 (cons 42 '()))))

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

;;;;; 5a

#|
  A Bit is one of:
  - "0"
  - "1"
|#

;;;;; 5b

#|
  A BitString is one of:
  - ""
  - (string-append "" Bit)
|#

;;;;; 5c

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

;;;;; 5d

; make-noise : Nat -> BitString
; (make-noise n) returns a BitString of length n


(define (make-noise n)
  (string-append
   (cond
     [(or (= n 0)
          (<= n 0))
      ""]
     [else (pick-one-at-random "0" "1")])
   (cond
     [(or (= (sub1 n) 0)
          (<= (sub1 n) 0)) ""]
     [else (make-noise (sub1 n))])))

(check-expect (make-noise 0) "")
(check-random (make-noise 16) (make-noise 16))
(check-random (make-noise 50) (make-noise 50))

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

#|
  A ListOfInt is one of:
  - '()
  - (cons Int ListOfInt)
|#

; process-ints : ListOfInt -> ...
; (process-ints ints) returns ...

(define (process-ints ints)
  (cond
    [(empty? ints) ...]
    [else (... (first ints) ...
               (process-ints (rest ints)))]))

;;;;; 6a

; all-even? : ListOfInt -> Boolean
; (all-even? int-list) returns #true iff every integer in the given
; list is even

(define (all-even? int-list)
  (or (empty? int-list)
      (and (even? (first int-list))
           (all-even? (rest int-list)))))

(check-expect (all-even? '()) #true)
(check-expect (all-even? (cons 3 '())) #false)
(check-expect (all-even? (cons 4 (cons 8 (cons -10 (cons 0 '())))))
              #true)

;;;;; 6b

; some-even? : ListOfInt -> Boolean
; (some-even? int-list) returns #true iff at least one integer in the
; given list is even

(define (some-even? int-list)
  (and (not (empty? int-list))
       (or (even? (first int-list))
           (some-even? (rest int-list)))))

(check-expect (some-even? '()) #false)
(check-expect (some-even? (cons 3 '())) #false)
(check-expect (some-even? (cons 0 '())) #true)
(check-expect (some-even? (cons 5 (cons 9 (cons -11 (cons 1 '())))))
              #false)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;; 7a

#|
   A Nucleotide is one of:
   - 'A
   - 'T
   - 'G
   - 'C

   A ListOfNucleotides is one of:
   - '()
   - (cons Nucleotide '())
|#

;;;;; 7b

; make-dna-strand : Nat -> ListOfNucleotides
; (make-dna-strand n) returns a ListOfNucleotides with n Nucleotides

(define (make-dna-strand n)
  (cond
    [(zero? n) '()]
    [else (cons (cond
                  [(= 3 (random 4)) 'A]
                  [(= 2 (random 3)) 'T]
                  [(= 1 (random 2)) 'G]
                  [else 'C])
                (make-dna-strand (sub1 n)))]))

(check-expect (make-dna-strand 0)
              '())
(check-random (make-dna-strand 7) (make-dna-strand 7))

;;;;; 7c

; t-count : ListOfNucleotides -> Nat
; (t-count nuc-list) returns a natural number corresponding to the
; number of T nucleotides in the given ListOfNucleotides

(define (t-count nuc-list)
  (cond
    [(empty? nuc-list) 0]
    [else (+ (cond
               [(equal? (first nuc-list) 'T) 1]
               [else 0])
             (t-count (rest nuc-list)))]))

(check-expect (t-count '()) 0)
(check-expect (t-count (cons 'T (cons 'T (cons 'A (cons 'T '()))))) 3)
(check-within (t-count (make-dna-strand 10000)) 2500 100)

; g-count : ListOfNucleotides -> Nat
; (g-count nuc-list) returns a Nat corresponding to the number of G
; nucleotides in the nuc-list

(define (g-count nuc-list)
  (cond
    [(empty? nuc-list) 0]
    [else (+ (cond
               [(equal? (first nuc-list) 'G) 1]
               [else 0])
             (g-count (rest nuc-list)))]))

(check-within (g-count (make-dna-strand 10000)) 2500 100)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

;;;;; 8a

#|
  A Coin is one of:
  - 'penny
  - 'nickel
  - 'dime
  - 'quarter
|#

;;;;; 8b

; coin->cents : Coin -> Nat
; (coin->cents coin) returns a Nat based on the Coin input

(define (coin->cents coin)
  (cond
    [(equal? coin 'penny) 1]
    [(equal? coin 'nickel) 5]
    [(equal? coin 'dime) 10]
    [(equal? coin 'quarter) 25]
    [else (error "invalid input")]))

(check-expect (coin->cents 'penny) 1)
(check-expect (coin->cents 'nickel) 5)
(check-expect (coin->cents 'dime) 10)
(check-expect (coin->cents 'quarter) 25)
(check-error (coin->cents 'euro) "invalid input")

;;;;; 8c

#|
  A PiggyBank is one of:
  - '()
  - (cons Coin '())
|#

;;;;; 8d

; process-piggy-bank : PiggyBank -> ...
; (process-piggy-bank a-piggy-bank) returns ...

(define (process-piggy-bank a-piggy-bank)
  (cond
    [(empty? a-piggy-bank) ...]
    [else (+ (coin->cents a-piggy-bank)
             (process-piggy-bank (rest a-piggy-bank)))]))

;;;;; 8e

; count-coins : PiggyBank -> Nat
; (count-coins piggy-bank) retunrs a Nat for the value of coins in the
; PiggyBank

(define (count-coins piggy-bank)
  (cond
    [(empty? piggy-bank) 0]
    [else (+ (coin->cents (first piggy-bank))
             (count-coins (rest piggy-bank)))]))

(check-expect (count-coins '()) 0)
(check-expect (count-coins (cons 'penny (cons 'penny '()))) 2)
(define bank (cons 'quarter
                     (cons 'penny
                           (cons 'nickel
                                 (cons 'penny
                                       (cons 'dime '()))))))
(check-expect (count-coins bank) 42)

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

#|
   A Dish is a (make-dish String Nat Num)
 
   A Menu is one of
   - '()
   - (cons Dish Menu)
|#

;;;;; 9a

(define-struct dish [name calories cost])

;;;;; 9b

; make-dish : String Nat Num -> Dish
; dish? : Any -> Bool
; dish-name : Dish -> String
; dish-calories : Dish -> Nat
; dish-cost : Dish -> Num

;;;;; 9c

; process-dish : Dish -> ...
; (process-dish a-dish) returns ...

(define (process-dish a-dish)
  (cond
    [(... (dish-name a-dish)) ...]
    [(... (dish-calories a-dish)) ...]
    [(... (dish-cost a-dish)) ...]
    [else ...]))

;;;;; 9d

(define appetizer (make-dish "Deep Fried Wontons" 760 8.49))
(define soup (make-dish "Egg Drop" 250 5.29))
(define entree (make-dish "Salt and Pepper Squid" 675 12.82))

;;;;; 9e

#|
  A Menu is one of:
  - '()
  - (cons Dish '())
|#

; count-calories : Menu -> Nat
; (count-calories menu) returns the total number of calories for all the
; items on the menu

(define (count-calories menu)
  (cond
    [(empty? menu) 0]
    [else (+ (dish-calories (first menu))
             (count-calories (rest menu)))]))

(check-expect (count-calories '()) 0)
(define meal (cons appetizer (cons soup (cons entree '()))))
(check-expect (dish-name (first meal)) "Deep Fried Wontons")
(check-expect (count-calories meal) 1685)

;;;;;;;;;;;;;;;
;; Problem 10 ;
;;;;;;;;;;;;;;;

;;;;; 10a

#|
  A ListOfColors is one of
  - '()
  - (cons color '())
|#

; process-color-list ; ListOfColors -> ...
; (process-color-list a-color-list) returns ...

(define (process-color-list a-color-list)
  (cond
    [(empty? a-color-list) ...]
    [else (... (rectangle 30 100 "solid" (first a-color-list))
               (process-color-list (rest a-color-list)))]))

; make-color-chart : ListOfColors -> Image
; (make-color-chart ColorList) returns an image with rectangles
; side-by-side corresponding to each color in the list

(define (make-color-chart color-list)
  (cond
    [(empty? color-list) empty-image]
    [else (beside (rectangle 30 100 "solid" (first color-list))
                  (make-color-chart (rest color-list)))]))

(check-expect (image-width (make-color-chart '())) 0)
(check-expect (image-height (make-color-chart '())) 0)
(define chart (make-color-chart (cons "gold" '())))
(check-expect (image-width chart) 30)
(check-expect (image-height chart) 100)
(define rainbow
  (cons "red"
        (cons "orange"
              (cons "yellow"
                    (cons "green"
                          (cons "blue"
                                (cons "indigo"
                                      (cons "violet" '()))))))))
(check-expect (image-width (make-color-chart rainbow)) 210)
(check-expect (image-height (make-color-chart rainbow)) 100)

;;;;; 10b

; bullseye-helper : Nat -> Image
; (bullseye-helper n) retunrs a circle with a radius of the sum of 10
; and the product of 10 and n with a color of black if n is even and a
; color of red if n is odd

(define (bullseye-helper n)
  (cond
    [(even? n) (circle (+ (* n 10) 10) "solid" "black")]
    [(odd? n) (circle (+ (* n 10) 10) "solid" "red")]
    [else (error "invalid input")]))

(check-expect (image-width (bullseye-helper 0)) 20)
(check-expect (image-width (bullseye-helper 1)) 40)

; make-bullseye : Nat -> Image
; (make-bullseye n) returns an image that looks like a bullseye with the
; number of rings corresponfing to the value of n

(define (make-bullseye n)
  (cond
    [(= 0 n) (bullseye-helper n)]
    [else (underlay (bullseye-helper n)
                  (make-bullseye (sub1 n)))]))

(check-expect (image-width (make-bullseye 1)) 40)
(check-expect (image-width (make-bullseye 2)) 60)
(check-expect (image-width (make-bullseye 6)) 140)
(check-expect (image-width (make-bullseye 7)) 160)