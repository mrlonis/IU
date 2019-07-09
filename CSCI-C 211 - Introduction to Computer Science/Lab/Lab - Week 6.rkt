;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Lab - Week 6|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab6")
(define partner "Mitchell Thomas (mitthoma)")
(define collaboration-statement
  (string-append "I worked with " partner "."))

#|
  A Nat is one of:
  - 0
  - (add1 0)

  A NatH is one of
  - Nat
  - (+ Nat 0.5)

  A ListOfNum is one of
  - '()
  - (cons Num '())
|#

; count-halves : NatH -> ListOfNum
; (count-halves n) returns a list starting at n and counting down by 0.5
; each step


(define (count-halves n)
  (cond
    [(zero? n) (cons 0 '())]
    [else (cons n (count-halves (- n 0.5)))]))

(check-within (second (count-halves 5)) 4.5 0.1)


;;;;;;;;;;
;;;;; 1a

#|
  A ListOfNum is one of
  - '()
  - (list Num ListOfNum)
|#

; abs-sum : ListOfNum -> Num
; (abs-sum nums) returns the sum of the absolute values of the
; numbers in nums

(define (abs-sum nums)
  (cond
    [(empty? nums) 0]
    [(zero? (first nums)) (+ 0 (abs-sum (rest nums)))]
    ;; if it's negative, flip the sign
    [(negative? (first nums)) (+ (- (first nums))
                                 (abs-sum (rest nums)))]
    ;; if it's positive, just add it!
    [(positive? (first nums)) (+ (first nums)
                                 (abs-sum (rest nums)))]
    [else (error "What's good?")]))

(check-expect (abs-sum (list 1 2 3)) 6)
(check-expect (abs-sum (list -2 -1 0 1 2)) 6)

;;;;;;;;;;
;;;;; 1b

#|
  A ListOfString is one of
  - ""
  - (cons String ListOfString)
|#

; remove-bad : ListOfString -> ListOfString
; (remove-commas strings) returns the result of removing all
; occurrences of "bad" from strings

(define (remove-bad strings)
  (cond
    [(empty? strings) '()]
    [(equal? "bad" (first strings)) (remove-bad (rest strings))]
    [else (cons (first strings) (remove-bad (rest strings)))]))

(check-expect (remove-bad (list "bad")) empty)
(check-expect (remove-bad (list "bad" "good")) (list "good"))
(check-expect (remove-bad (list)) '())
(check-expect (remove-bad (list "bad" "bad" "good" "hello" "wow"))
              (list "good" "hello" "wow"))
(check-expect (remove-bad (list "bad" "bad" "good" "bad" "hello" "wow"))
              (list "good" "hello" "wow"))

; Fully test this function.  Cover all important cases by
; adding your own tests to clear the black highlighting

;;;;;;;;;;
;;;;; 1c

#|
  A Nat is one of
  - 0
  - (add1 Nat)
|#

; factorial : Nat -> Nat
; (factorial n) returns n! = n * (n-1) * (n-2) * ... * 1

(define (factorial n)
  (cond
    [(zero? n) 0]
    [(= n 1) 1]
    [else (* n (factorial (sub1 n)))]))

(check-expect (factorial 5) 120)
(check-expect (factorial 1) 1)
(check-expect (factorial 0) 0)


;;;;; 1d

; join-first-two : ListOfString -> String
; (join-first-two words) returns the result of concatenating,
; separated by a blank, the first two words if they exist.
; Otherwise, returns either the empty string, in the case that
; there are no words, or just the first word in words.

(define (join-first-two words)
  (cond
    [(empty? words) ""]
    [(= (length words) 1) (first words)]
    [else (string-append (first words) " " (second words))]))

(check-expect (join-first-two '()) "")
(check-expect (join-first-two (list "one" "two")) "one two")
(check-expect (join-first-two (list "hi" "good" "day")) "hi good")
(check-expect (join-first-two (list "A" "B" "C" "D")) "A B")
(check-expect (join-first-two (cons "onlyone" '())) "onlyone")


; 5.  Exercises
; =============

;;;;;;;;;;;;;;;
;; Exercises - Part 2
;;;;;;;;;;;;;;;

#|
Here we're going to revisit some definitions from a previous homework
and use them in some new recursive functions.

Copy and paste the following into titanpad and set them loose to work
on the problems with their partners.  There is one main
problem (2a-2b) and a challenge problem for anyone who finishes before
time is up.
|#

;; Given these familiar definitions:

; planet-radius : Planet -> Num
; (planet-radius planet) returns an approximation of planet's radius

(define (planet-radius planet)
  (cond
    [(equal? planet 'mercury) 1524.6875]
    [(equal? planet 'venus) 3782.5]
    [(equal? planet 'earth) 3986.25]
    [(equal? planet 'mars) 2122.5]
    [(equal? planet 'jupiter) 44682.5]
    [(equal? planet 'saturn) 37667.5]
    [(equal? planet 'uranus) 15974.375]
    [(equal? planet 'neptune) 15477.5]
    [else (error "unknown planet")]))

; degrees->radians : Num -> Num
; (degrees->radians degrees) returns degrees converted to radians

(define (degrees->radians degrees)
  (/ (* degrees pi) 180))

; A NonNegNum is a Num >= 0

; spherical-distance : Posn Posn -> NonNegNum
; (spherical-distance start end) returns the distance between the two
; points along the surface of a sphere. Note: the start and end points
; are given in degrees.

(define (spherical-distance start end)
  (haversin (make-posn (degrees->radians (posn-x start))
                       (degrees->radians (posn-y start)))
            (make-posn (degrees->radians (posn-x end))
                       (degrees->radians (posn-y end)))))

; haversin : Posn Posn -> NonNegNum
; (haversin start end) implements the Haversin Formula given here
; https://en.wikipedia.org/wiki/Haversine_formula

(define (haversin start end)
  (* 2 (planet-radius 'earth)
     (asin
      (sqrt
       (+ (sqr (sin (/ (- (posn-x end) (posn-x start)) 2)))
          (* (cos (posn-x start))
             (cos (posn-x end))
             (sqr (sin (/ (- (posn-y end) (posn-y start)) 2)))))))))

; An Airport is a (make-airport String Symbol Posn)

(define-struct airport [location code gps])

; Examples of airports:

(define indy
  (make-airport "Indianapolis, IN" 'IND (make-posn 39.7172 -86.2944)))
(define boston
  (make-airport "Boston, MA" 'BOS (make-posn 42.3631 -71.0064)))
(define coldbay
  (make-airport "Cold Bay, AK" 'CDB (make-posn 55.2005005 -162.7055)))
(define sanfran
  (make-airport "San Francisco, CA" 'SFO (make-posn 37.6189 -122.3750)))
(define kauai
  (make-airport "Lihu'e, HI" 'LIH (make-posn 21.97822 -159.3508)))

; Examples of lists of airports:

(define trip1 (list indy))
(define trip2 (list indy boston))
(define trip3 (list indy boston sanfran))
(define round-trip (list indy boston coldbay sanfran kauai indy))

;;;;; 2a

; Design a function named extract-codes that converts a list of
; airports into a list of the corresponding airport codes.

#|
  A ListOfAirports is one of
  - '()
  - (cons (make-airport [loaction code gps]) '())

  A ListOfCodes is one of
  - '()
  - (cons (airport-code airport) '())
|#

; extract-codes : ListOfAirports -> ListOfCodes
; (extract-codes airport-list

(define (extract-codes airport-list)
  (cond
    [(empty? airport-list) '()]
    [else (cons (airport-code (first airport-list))
                (extract-codes (rest airport-list)))]))

(check-expect (extract-codes (list indy boston coldbay sanfran kauai))
              (list 'IND 'BOS 'CDB 'SFO 'LIH))

;;;;; 2b

; Design a function named total-distance that computes the total
; distance of an itinerary given as a sequential list of airports.

(define (total-distance airport-list)
  (cond
    [(empty? airport-list) 0]
    [(= (length airport-list) 1) 0]
    [else (+ (spherical-distance
              (airport-gps (first airport-list))
              (airport-gps (second airport-list)))
             (total-distance (rest airport-list)))]))

(check-within (total-distance trip2)
              (spherical-distance (airport-gps indy)
                                  (airport-gps boston)) 0.1)
(check-expect (total-distance (list)) 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercises - Part 3, Challenge
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; 3a

; Design a function which takes two airports and returns #true iff the
; first airport is strictly more northerly of the second.

;;;;; 3b

; The northern hemisphere is under a severe winter storm warning.  My
; plane is about to safely take off from my home airport.  Which
; airports are likely to be safe to travel to?  Assume that it's only
; dangerous to fly north.  Design a recursive function that takes two
; arguments.  Which two pieces of information do you need from me in
; order to answer my previous question?
