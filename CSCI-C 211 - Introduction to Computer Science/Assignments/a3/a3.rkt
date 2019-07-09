;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "a3")
(define collaboration-statement "I worked by myself")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

#|
   A Season is one of
   - 'spring
   - 'summer
   - 'fall
   - 'winter
 
   An Icon is an Image of dimensions 32x32
 
   A DiceRoll is an Int in the interval [2..12]
|#

;;;;; 1a

(define my-lab-instructor 'menzel)
(define tis-the-season 'winter)
(define purple-icon (square 32 "solid" "purple"))
(define craps 2)

;;;;; 1b

(check-satisfied my-lab-instructor symbol?)
(check-satisfied tis-the-season symbol?)
(check-member-of tis-the-season 'spring 'summer 'fall 'winter)
(check-expect (image-width purple-icon) (image-height purple-icon))
(check-range craps 2 12)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

#|
   A coin-flip is one of
   - 'heads
   - 'tails
|#

; flip-coin : Symbol -> Symbol

(define (flip-coin coin-flip)
  (cond ((equal? coin-flip 'heads) 'tails)
        (else 'heads)))

(check-expect (flip-coin 'heads) 'tails)
(check-expect (flip-coin 'tails) 'heads)
(check-expect (flip-coin (flip-coin 'tails)) 'tails)

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

#|
   rps1 is ideally one of
   - 'rock
   - 'paper
   - 'scissors

   however it can take any kind of symbol
|#

; wins-rps? : Symbol Symbol -> Boolean

(define (wins-rps? rps1 rps2)
  (if (and (equal? rps1 'rock) (equal? rps2 'scissors))
      #true
      (if (and (equal? rps1 'scissors) (equal? rps2 'paper))
          #true
          (if (and (equal? rps1 'paper) (equal? rps2 'rock))
              #true
              #false))))

(check-expect (wins-rps? 'rock 'scissors) #true)
(check-expect (wins-rps? 'scissors 'paper) #true)
(check-expect (wins-rps? 'paper 'rock) #true)
(check-expect (wins-rps? 'paper 'paper) #false)
(check-expect (wins-rps? 'rock 'paper) #false)
(check-expect (wins-rps? 'lizard 'spock) #false)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

#|
   num1, num2, num3 are all in the number category
|#

; fib-like? : Num Num Num -> Boolean

(define (fib-like? num1 num2 num3)
  (cond
    [(= (+ num1 num2) num3) #true]
    [else #false]))

(check-expect (fib-like? 3 5 8) #true)
(check-expect (fib-like? 0 0 0) #true)
(check-expect (fib-like? 7 -2 5) #true)
(check-expect (fib-like? 10 15 20) #false)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

#|
   dog-age is in the NatNum range of
   [0..29]

   I choose 29 as a cap because scientifically speaking there is a
   recorded dog lifespan of 29 human years
|#

; dog-years->human-years : dog-age -> Num

(define (dog-years->human-years dog-age)
  (cond
    [(<= dog-age 2) (* dog-age 7)]
    [(<= dog-age 29) (+ 21 (* 4 (- dog-age 2)))]
    [else "Would be dead"]))

(check-expect (dog-years->human-years 0) 0)
(check-expect (dog-years->human-years 1) 7)
(check-expect (dog-years->human-years 2) 14)
(check-expect (dog-years->human-years 3) 25)
(check-expect (dog-years->human-years 4) 29)
(check-expect (dog-years->human-years 7) 41)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

#|
   TeeSize is one of
   - 'x-small
   - 'small
   - 'medium
   - 'large
   - 'x-large
|#

;;;;; 6a

; tee-size? : TeeSize -> Boolean
; (tee-size? TeeSize) returns a boolean of either #true or #false
; depending whether or not the input for TeeSize is within the
; enumeration listed above for possible TeeSize

(define (tee-size? TeeSize)
  (cond
    [(equal? TeeSize 'x-small) #true]
    [(equal? TeeSize 'small) #true]
    [(equal? TeeSize 'medium) #true]
    [(equal? TeeSize 'large) #true]
    [(equal? TeeSize 'x-large) #true]
    [else #false]))
    
(check-satisfied 'x-small tee-size?)
(check-satisfied 'small tee-size?)
(check-satisfied 'medium tee-size?)
(check-satisfied 'large tee-size?)
(check-satisfied 'x-large tee-size?)
(check-expect (tee-size? 'xx-large) #false)

;;;;; 6b

; next-size-up : TeeSize -> TeeSize
; (next-size-up TeeSize) returns the next TeeSize subsequent
; to the input a user inserts for TeeSize

(define (next-size-up TeeSize)
  (cond
    [(equal? TeeSize 'x-small) 'small]
    [(equal? TeeSize 'small) 'medium]
    [(equal? TeeSize 'medium) 'large]
    [(equal? TeeSize 'large) 'x-large]
    [(equal? TeeSize 'x-large) 'x-large]
    [else "Error: Invalid input for TeeSeize"]))

(check-expect (next-size-up 'small) 'medium)
(check-expect (next-size-up 'x-large) 'x-large)
(check-satisfied (next-size-up 'large) tee-size?)

;;;;; 6c

; tee>=? : TeeSize TeeSize -> Boolean
; (tee>=? TeeSize1 TeeSize) returns a boolean value if the TeeSize1
; is of greater size than TeeSize2

(define (tee>=? TeeSize1 TeeSize2)
  (cond
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'x-large)) #true]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'large)) #true]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'medium)) #true]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'small)) #true]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'x-small)) #true]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'x-large)) #false]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'large)) #true]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'medium)) #true]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'small)) #true]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'x-small)) #true]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'x-large)) #false]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'large)) #false]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'medium)) #true]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'small)) #true]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'x-small)) #true]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'x-large)) #false]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'large)) #false]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'medium)) #false]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'small)) #true]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'x-small)) #true]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'x-large)) #false]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'large)) #false]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'medium)) #false]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'small)) #false]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'x-small)) #true]
    [else #false]))

(check-expect (tee>=? 'x-large 'x-large) #true)
(check-expect (tee>=? 'x-large 'large) #true)
(check-expect (tee>=? 'x-large 'medium) #true)
(check-expect (tee>=? 'x-large 'small) #true)
(check-expect (tee>=? 'x-large 'x-small) #true)
(check-expect (tee>=? 'large 'x-large) #false)
(check-expect (tee>=? 'large 'large) #true)
(check-expect (tee>=? 'large 'medium) #true)
(check-expect (tee>=? 'large 'small) #true)
(check-expect (tee>=? 'large 'x-small) #true)
(check-expect (tee>=? 'medium 'x-large) #false)
(check-expect (tee>=? 'medium 'large) #false)
(check-expect (tee>=? 'medium 'medium) #true)
(check-expect (tee>=? 'medium 'small) #true)
(check-expect (tee>=? 'medium 'x-small) #true)
(check-expect (tee>=? 'small 'x-large) #false)
(check-expect (tee>=? 'small 'large) #false)
(check-expect (tee>=? 'small 'medium) #false)
(check-expect (tee>=? 'small 'small) #true)
(check-expect (tee>=? 'small 'x-small) #true)
(check-expect (tee>=? 'x-small 'x-large) #false)
(check-expect (tee>=? 'x-small 'large) #false)
(check-expect (tee>=? 'x-small 'medium) #false)
(check-expect (tee>=? 'x-small 'small) #false)
(check-expect (tee>=? 'x-small 'x-small) #true)

;;;;; 6d

; tee-max : TeeSize TeeSize -> TeeSize
; (tee-max TeeSize1 TeeSize2) returns a symbol of TeeSize that is the
; largest TeeSize out of the two inputs

(define (tee-max TeeSize1 TeeSize2)
  (cond
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'x-large)) 'x-large]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'large)) 'x-large]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'medium)) 'x-large]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'small)) 'x-large]
    [(and (equal? TeeSize1 'x-large)
          (equal? TeeSize2 'x-small)) 'x-large]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'x-large)) 'x-large]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'large)) 'large]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'medium)) 'large]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'small)) 'large]
    [(and (equal? TeeSize1 'large)
          (equal? TeeSize2 'x-small)) 'large]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'x-large)) 'x-large]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'large)) 'large]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'medium)) 'medium]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'small)) 'medium]
    [(and (equal? TeeSize1 'medium)
          (equal? TeeSize2 'x-small)) 'medium]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'x-large)) 'x-large]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'large)) 'large]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'medium)) 'medium]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'small)) 'small]
    [(and (equal? TeeSize1 'small)
          (equal? TeeSize2 'x-small)) 'small]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'x-large)) 'x-large]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'large)) 'large]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'medium)) 'medium]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'small)) 'small]
    [(and (equal? TeeSize1 'x-small)
          (equal? TeeSize2 'x-small)) 'x-small]
    [else "error"]))

(check-expect (tee>=? 'x-large 'x-large) #true)
(check-expect (tee>=? 'x-large 'large) #true)
(check-expect (tee>=? 'x-large 'medium) #true)
(check-expect (tee>=? 'x-large 'small) #true)
(check-expect (tee>=? 'x-large 'x-small) #true)
(check-expect (tee>=? 'large 'x-large) #false)
(check-expect (tee>=? 'large 'large) #true)
(check-expect (tee>=? 'large 'medium) #true)
(check-expect (tee>=? 'large 'small) #true)
(check-expect (tee>=? 'large 'x-small) #true)
(check-expect (tee>=? 'medium 'x-large) #false)
(check-expect (tee>=? 'medium 'large) #false)
(check-expect (tee>=? 'medium 'medium) #true)
(check-expect (tee>=? 'medium 'small) #true)
(check-expect (tee>=? 'medium 'x-small) #true)
(check-expect (tee>=? 'small 'x-large) #false)
(check-expect (tee>=? 'small 'large) #false)
(check-expect (tee>=? 'small 'medium) #false)
(check-expect (tee>=? 'small 'small) #true)
(check-expect (tee>=? 'small 'x-small) #true)
(check-expect (tee>=? 'x-small 'x-large) #false)
(check-expect (tee>=? 'x-small 'large) #false)
(check-expect (tee>=? 'x-small 'medium) #false)
(check-expect (tee>=? 'x-small 'small) #false)
(check-expect (tee>=? 'x-small 'x-small) #true)

;;;;; 6e

; tee-max3 : TeeSize TeeSize TeeSize -> TeeSize
; (tee-max3 TeeSize1 TeeSize2 TeeSize3) returns the largest TeeSize out
; of the three given TeeSize inputs

(define (tee-max3 TeeSize1 TeeSize2 TeeSize3)
  (tee-max (tee-max TeeSize1 TeeSize2) (tee-max TeeSize2 TeeSize3)))

(check-satisfied (tee-max3 'large 'large 'large) tee-size?)
(check-member-of (tee-max3 'medium 'small 'large) 'medium 'small 'large)
(check-expect (tee-max3 'x-large 'large 'medium) 'x-large)
(check-expect (tee-max3 'large 'medium 'small) 'large)
(check-expect (tee-max3 'medium 'small 'x-small) 'medium)
(check-expect (tee-max3 'small 'x-small 'x-large) 'x-large)
(check-expect (tee-max3 'x-small 'x-large 'large) 'x-large)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

#|
   A DayOfWeek is one of
   - 'mon
   - 'tue
   - 'wed
   - 'thu
   - 'fri
   - 'sat
   - 'sun
|#

;;;;;7a

; sleep-in? : DayOfWeek -> Boolean
; (sleep-in? DayOfWeek) retunrs a boolean of #true iff the DayOfWeek is
; either 'sat or 'sun and #false for all other possible values

(define (sleep-in? DayOfWeek)
  (cond
    [(equal? DayOfWeek 'mon) #false]
    [(equal? DayOfWeek 'tue) #false]
    [(equal? DayOfWeek 'wed) #false]
    [(equal? DayOfWeek 'thu) #false]
    [(equal? DayOfWeek 'fri) #false]
    [(equal? DayOfWeek 'sat) #true]
    [(equal? DayOfWeek 'sun) #true]
    [else false]))

(check-expect (sleep-in? 'mon) #false)
(check-expect (sleep-in? 'tue) #false)
(check-expect (sleep-in? 'wed) #false)
(check-expect (sleep-in? 'thu) #false)
(check-expect (sleep-in? 'fri) #false)
(check-expect (sleep-in? 'sat) #true)
(check-expect (sleep-in? 'sun) #true)

;;;;; 7b

; tomorrow : DayOfWeek -> DayOfWeek
; (tomorrow DayOfWeek) returns a DayOfWeek that is after the input
; for DayOfWeek

(define (tomorrow DayOfWeek)
  (cond
    [(equal? DayOfWeek 'mon) 'tue]
    [(equal? DayOfWeek 'tue) 'wed]
    [(equal? DayOfWeek 'wed) 'thu]
    [(equal? DayOfWeek 'thu) 'fri]
    [(equal? DayOfWeek 'fri) 'sat]
    [(equal? DayOfWeek 'sat) 'sun]
    [(equal? DayOfWeek 'sun) 'mon]
    [else "error"]))

(check-expect (tomorrow 'mon) 'tue)
(check-expect (tomorrow 'tue) 'wed)
(check-expect (tomorrow 'wed) 'thu)
(check-expect (tomorrow 'thu) 'fri)
(check-expect (tomorrow 'fri) 'sat)
(check-expect (tomorrow 'sat) 'sun)
(check-expect (tomorrow 'sun) 'mon)

;;;;; 7c

; day-after-tomorrow : DayOfWeek -> DayOfWeek
; (day-after-tomorrow DayOfWeek) returns a DayOfWeek that is two days
; after the input for DayOfWeek

(define (day-after-tomorrow DayOfWeek)
  (tomorrow (tomorrow DayOfWeek)))

(check-expect (day-after-tomorrow 'mon) 'wed)
(check-expect (day-after-tomorrow 'tue) 'thu)
(check-expect (day-after-tomorrow 'wed) 'fri)
(check-expect (day-after-tomorrow 'thu) 'sat)
(check-expect (day-after-tomorrow 'fri) 'sun)
(check-expect (day-after-tomorrow 'sat) 'mon)
(check-expect (day-after-tomorrow 'sun) 'tue)

;;;;; 7d

; part-on? : DayOfWeek -> Boolean
; (party-on? DayOfWeek) returns a boolean value if the DayOfWeek
; is followed by a sleep in day

(define (party-on? DayOfWeek)
  (cond
    [(sleep-in? (tomorrow DayOfWeek)) #true]
    [else #false]))

(check-expect (party-on? 'mon) #false)
(check-expect (party-on? 'tue) #false)
(check-expect (party-on? 'wed) #false)
(check-expect (party-on? 'thu) #false)
(check-expect (party-on? 'fri) #true)
(check-expect (party-on? 'sat) #true)
(check-expect (party-on? 'sun) #false)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

;;;;; 8a

; next-odd : Int -> Int
; (next-odd n) returns the next odd integer after the given input

(define (next-odd n)
  (cond
    [(odd? n) (+ 2 n)]
    [(even? n) (+ 1 n)]
    [else "error"]))

(check-expect (next-odd 5) 7)
(check-expect (next-odd -2) -1)
(check-expect (next-odd
               (next-odd
                (next-odd 6))) 11)

;;;;; 8b

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

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

#|
   length is in the range [o..inf)

   vector-direction is one of
   - "ver"
   - "hor"
   and corresponds to whether the line is vertical or horizontal

   thickness is in the range [1..10]
|#

; number-crop : Int Int Thickness -> Thickness
; (number-crop thickness) returns a thickness that fits within the
; the interval given for thickness as defined in the above data
; defenition

(define (number-crop thickness)
  (cond
    [(> thickness 10) 10]
    [(< thickness 1) 1]
    [else thickness]))

(check-expect (number-crop 10) 10)
(check-expect (number-crop 11) 10)
(check-expect (number-crop 0) 1)
(check-expect (number-crop -1) 1)
(check-expect (number-crop -5) 1)

; make-line -> length vector-direction thickness String -> Image
; (make-line length vector-direction thickness color) returns
; a line with the given features based up the variables input

(define (make-line length vector-direction thickness color)
  (cond
    [(equal? vector-direction "ver")
     (rectangle (number-crop thickness) length "solid" color)]
    [(equal? vector-direction "hor")
     (rectangle length (number-crop thickness) "solid" color)]))

(check-satisfied (make-line 300 "hor" 1 "black") image?)
(check-satisfied (make-line 500 "hor" 3 "chartreuse") image?)
(check-satisfied (make-line 30 "ver" 10 "lightsalmon") image?)
(check-satisfied (make-line 42 "ver" 7 "my favorite color") image?)

;;;;;;;;;;;;;;;
;; Problem 10 ;
;;;;;;;;;;;;;;;

;;;;; 10a

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

;;;;; 10b

; next-sweetest : Nat -> Nat
; (next-sweetest n) returns the next natural number that is sweet

(define (next-sweetest n)
  (cond
    [(sweet? (+ n 1)) (+ n 1)]
    [(sweet? (+ n 2)) (+ n 2)]
    [(sweet? (+ n 3)) (+ n 3)]
    [else "error"]))

(check-expect (next-sweetest 6) 9)
(check-expect (next-sweetest 21) 24)
(check-expect (next-sweetest (next-sweetest (next-sweetest 42))) 50)
(check-expect (next-sweetest 429237489284723749274982734982734982734892)
429237489284723749274982734982734982734895)
(check-expect (next-sweetest 2) 3)
(check-expect (next-sweetest 1) 3)