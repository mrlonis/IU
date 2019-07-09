;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "a4")
(define collaboration-statement "I worked alone")

(require 2htdp/image)

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

; process-number : Any -> ...
; (process-number a-number) is a template for problem 1a that will
; incorporate integer? and negative? predicates

(define (process-number a-number)
  (... (integer? number) ...
       (negative? number) ...))

; nat? : Any -> Bool
; (nat? number) returns a boolean value of #true if the input for
; number is a natural number and #false for anything else

(define (nat? number)
  (and (integer? number)
       (not (negative? number))))

(check-expect (nat? 'a) #false)
(check-expect (nat? 1) #true)
(check-expect (nat? 2429374927) #true)
(check-expect (nat? 0) #true)
(check-expect (nat? "1") #false)
(check-expect (nat? -3) #false)
(check-expect (nat? 1.23) #false)

;;;;; 1b

; process-string : String -> ...
; (process-string a-string) is my template for problem 1b

(define (process-string a-string)
  (... (equal? 1 (string-length a-string)) ...
       (string? a-string)))

; 1string? : Any -> Bool
; (1string string) returns a boolean value of #true if the input
; for string is of character length 1 and #false for anything else

#|
(define (1string? string)
  (and
   (string? string)
   ))
|#

(define (1string? string)
  (and
   (string? string)
   (= (string-length string) 1)))

(check-expect (1string? 'a) #false)
(check-expect (1string? 1) #false)
(check-expect (1string? "A") #true)
(check-expect (1string? "") #false)
(check-expect (1string? "1") #true)
(check-expect (1string? "xx") #false)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;;;;; 2a

#|
   A nucleotide is one of
   - 'A
   - 'T
   - 'G
   - 'C
|#

;;;;; 2b

; process-nucleotide : Nucleotide -> ...
; (process-nucleotide a-nucleotide) is my template for problem 2b

(define (process-nucleotide a-nucleotide)
  (cond
    [(equal? a-nucleotide 'A) ...]
    [(equal? a-nucleotide 'T) ...]
    [(equal? a-nucleotide 'G) ...]
    [(equal? a-nucleotide 'C) ...]
    [else #false]))

; nucleotide? : Nucleotide -> Boolean
; (nucleotide? nucleotide) returns a boolean value of #true
; if the input for DNA is one of the enumerated types in the above
; data definition and #false for anything else

(define (nucleotide? nucleotide)
  (cond
    [(equal? nucleotide 'A) #true]
    [(equal? nucleotide 'T) #true]
    [(equal? nucleotide 'G) #true]
    [(equal? nucleotide 'C) #true]
    [else #false]))

(check-expect (nucleotide? 'a) #false)
(check-expect (nucleotide? 1) #false)
(check-expect (nucleotide? "A") #false)
(check-expect (nucleotide? 'T) #true)
(check-expect (nucleotide? "ATGC") #false)

;;;;; 2c

; process-nucleotide2 : Nucleotide -> ...
; (process-nucleotide2 a-nucleotide) is my template for problem 2c
; note it is the came as 2b's template so I added a 2 at the end
; of process-nucleotide

(define (process-nucleotide2 a-nucleotide)
  (cond
    [(equal? a-nucleotide 'A) ...]
    [(equal? a-nucleotide 'T) ...]
    [(equal? a-nucleotide 'G) ...]
    [(equal? a-nucleotide 'C) ...]
    [else (error "unknown nucleotide")]))

;;;;; 2d

; process-dna : -> Nucleotide -> ...
; (process-dna a-nucleotide) is my template for problem 2d

(define (process-dna a-nucleotide)
  (cond
    [(equal? a-nucleotide 'A) ...]
    [(equal? a-nucleotide 'T) ...]
    [(equal? a-nucleotide 'G) ...]
    [(equal? a-nucleotide 'C) ...]
    [else (error "unknown nucleotide")]))

; dna-complement : Nucleotide -> Nucleotide
; (dna-complement nucleotide) returns the complement nucleotide
; for the given input for nucleotide. If the input is not a recognized
; nucleotide the function returns an error

(define (dna-complement nucleotide)
  (cond
    [(equal? nucleotide 'A) 'T]
    [(equal? nucleotide 'T) 'A]
    [(equal? nucleotide 'G) 'C]
    [(equal? nucleotide 'C) 'G]
    [else (error "unknown nucleotide")]))

(check-expect (dna-complement 'A) 'T)
(check-expect (dna-complement 'G) 'C)
(check-error (dna-complement 'X) "unknown nucleotide")

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

#|
   A Planet is one of
   - 'mercury
   - 'venus
   - 'earth
   - 'mars
   - 'jupiter
   - 'saturn
   - 'uranus
   - 'neptune
|#

; process-planet : Planet -> ...
; (process-planet a-planet) is my template for problem 3

(define (process-planet a-planet)
  (cond
    [(equal? a-planet 'mercury) ...]
    [(equal? a-planet 'venus) ...]
    [(equal? a-planet 'earth) ...]
    [(equal? a-planet 'mars) ...]
    [(equal? a-planet 'jupiter) ...]
    [(equal? a-planet 'saturn) ...]
    [(equal? a-planet 'uranus) ...]
    [(equal? a-planet 'neptune) ...]
    [else (error "unknown planet")]))

; planet-radius : Planet -> Number
; (planet-radius planet) returns the radius for the input of panet
; if the input is indeed a planet, otherwise the function returns an
; error

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

(check-within (planet-radius 'mercury) 1524.6875 0.00001)
(check-within (planet-radius 'venus) 3782.5 0.01)
(check-within (planet-radius 'earth) 3986.25 0.001)
(check-within (planet-radius 'mars) 2122.5 0.01)
(check-within (planet-radius 'jupiter) 44682.5 0.01)
(check-within (planet-radius 'saturn) 37667.5 0.01)
(check-within (planet-radius 'uranus) 15974.375 0.0001)
(check-within (planet-radius 'neptune) 15477.5 0.01)
(check-error (planet-radius 'pluto) "unknown planet")

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

#|
   StringF is any String and the boolean value of #false
|#

; random-string : String -> StringF
; (random-string a-silly-string) is my template for problem 4

(define (random-string a-silly-string)
  (cond
    [(equal? 0 (string-length a-silly-string))
     #false]
    [(> (string-length a-silly-string) 0)
     (string-ith a-silly-string
              (random (string-length a-silly-string)))]))

; choose-one : String -> StringF
; (choose-one random-string) retunrns a random character for the given
; input of string or returns #false if the given input is a string
; with no length

(define (choose-one string)
  (cond
    [(equal? 0 (string-length string))
     #false]
    [(> (string-length string) 0)
     (string-ith string (random (string-length string)))]))

(check-member-of (choose-one "ATGC") "A" "T" "G" "C")
(check-member-of (choose-one "bcdfghjklmnpqrstvwxyz")
                 "b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n" "p" "q"
                 "r" "s" "t" "v" "w" "x" "y" "z")
(check-expect (choose-one "") #false)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; number-square : Num -> Num
; (number-square x) produces the result of squaring x
 
(define (number-square x)
   (expt x 2))
 
(check-expect (number-square 8) 64)
(check-within (number-square -2.3) 5.29 .1)

; process-distance : Posn Posn -> Num
; (process-distance a-posn1 a-posn2) is my template for problem 5

(define (process-distance a-posn1 a-posn2)
  (sqrt
   (+ (number-square (- (posn-x a-posn1)
                        (posn-x a-posn2)))
      (number-square (- (posn-y a-posn1)
                        (posn-y a-posn2))))))

; euclidian-distance : Posn Posn -> Num
; (euclidean-distance Posn1 Posn2) produces the result of the square
; root of the sum of the squared differences between the x values of
; both posns and the y values of both posns

(define (euclidean-distance posn1 posn2)
  (sqrt
   (+ (number-square (- (posn-x posn1)
                        (posn-x posn2)))
      (number-square (- (posn-y posn1)
                        (posn-y posn2))))))

(define the-origin (make-posn 0 0))
(define some-point (make-posn 3 7))
(check-within (euclidean-distance the-origin some-point)
              #i7.615773105863909 0.0000000000000001)
(check-expect (euclidean-distance (make-posn 1 1) (make-posn 4 5)) 5)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

;;;;; 6a

#|
   A Domino data type contains  color1 color2 size and orientation

   color1 and color2 are both any of the colors accepted by the Racket
   language

   size is a number used to represent the sizze of the domino

   orientation is one of
   - "hor"
   - "ver"
|#

(define-struct domino [color1 color2 size orientation])

; make-domino : color1 color2 size orientation -> Domino
; domino? : Any -> Boolean
; domino-color1 : Domino -> String
; domino-color2 : Domino -> String
; domino-size : Domino -> Num
; domino-orientation : Domino -> String

;;;;; 6b

(define d1 (make-domino "red" "black" 30 "hor"))
(define d2 (make-domino "blue" "green" 50 "ver"))

(check-satisfied d1 domino?)
(check-satisfied d2 domino?)
(check-expect (domino-color1 d1) "red")
(check-expect (domino-color2 d2) "green")
(check-expect (domino-size d1) 30)
(check-expect (domino-size d2) 50)
(check-expect (domino-orientation d1) "hor")
(check-expect (domino-orientation d2) "ver")
(check-expect (domino-color2 d1) "black")
(check-expect (domino-color1 d2) "blue")

;;;;; 6c

; process-domino : Domino -> ...
; (process-domino a-domino) is my template for problem 6c

(define (process-domino a-domino)
  (... (make-domino
        (domino-color1 a-domino)
        (domino-color2 a-domino)
        (domino-size a-domino)
        (domino-orientation a-domino) ...)))

;;;;; 6d

; domino-scale : Domino Number -> Domino
; (domino-scale domino scale) returns the same domino that was given
; in the input for domino except the size of the input is scaled
; by the number given for scale

(define (domino-scale domino scale-amount)
  (make-domino (domino-color1 domino)
               (domino-color2 domino)
               (round (* (domino-size domino) scale-amount))
               (domino-orientation domino)))

(check-expect (domino-color1 d1) "red")
(check-expect (domino-color2 d2) "green")
(check-expect (domino-size (domino-scale d1 5)) 150)
(check-expect (domino-size (domino-scale d2 1/3)) 17)

;;;;; 6e

; domino-image : Domino -> Image
; (domino-image a-domino) is my template for problem 6e

(define (domino-image a-domino)
  (cond
    [(equal? "hor" (domino-orientation a-domino))
     (beside (square (domino-size a-domino)
                     "solid"
                     (domino-color1 a-domino))
             (square (domino-size a-domino)
                     "solid"
                     (domino-color2 a-domino)))]
    [(equal? "ver" (domino-orientation a-domino))
     (above (square (domino-size a-domino)
                     "solid"
                     (domino-color1 a-domino))
             (square (domino-size a-domino)
                     "solid"
                     (domino-color2 a-domino)))]))

; domino->image : Domino -> Image
; (domino-image domino2) returns an image of the given input for
; domino2

(define (domino->image domino)
  (cond
    [(equal? "hor" (domino-orientation domino))
     (beside (square (domino-size domino)
                     "solid"
                     (domino-color1 domino))
             (square (domino-size domino)
                     "solid"
                     (domino-color2 domino)))]
    [(equal? "ver" (domino-orientation domino))
     (above (square (domino-size domino)
                     "solid"
                     (domino-color1 domino))
             (square (domino-size domino)
                     "solid"
                     (domino-color2 domino)))]))

(check-expect (image? (domino->image d1)) #true)
(check-expect (image? (domino->image d2)) #true)
(check-expect (image-width (domino->image d1)) 60)
(check-expect (image-height (domino->image d1)) 30)
(check-expect (image-height (domino->image d2)) 100)
(check-expect (image? (domino->image (domino-scale d2 4.1275))) #true)
(check-expect (image? (domino->image (domino-scale
                                      (domino-scale d1 2) 3))) #true)

;;;;; 6f

; process-domino2 : Domino -> ...
; (process-domino2 a-domino) is my template for problem 6f

(define (process-domino2 a-domino)
  (... (make-domino
        (domino-color1 (domino-color2 a-domino))
        (domino-color2 (domino-color1 a-domino))
        (domino-size a-domino)
        (domino-orientation a-domino) ...)))

; domino-reverse : Domino -> Domino
; (domino-reverse domino) returns a domino with the reverse colors
; of the input for domino3

(define (domino-reverse domino)
  (make-domino (domino-color2 domino)
               (domino-color1 domino)
               (domino-size domino)
               (domino-orientation domino)))

(check-expect (domino-color1 (domino-reverse d1)) "black")
(check-expect (domino-color1 (domino-reverse d2)) "green")

;;;;; 6g

; process-domino3 : Domino -> ...
; (process-domino a-domino) is my template for problem 6g

(define (process-domino3 a-domino)
  (... (make-domino
        (domino-color1 a-domino)
        (domino-color2 a-domino)
        (domino-size a-domino)
        (domino-orientation a-domino) ...)))

; domino-turn : Domino -> Domino
; (domino-turn domino) returns a domino in the reverse orientation
; of the input for domino

(define (domino-turn domino)
  (cond
    [(equal? "hor" (domino-orientation domino))
     (make-domino (domino-color1 domino)
                  (domino-color2 domino)
                  (domino-size domino)
                  "ver")]
    [(equal? "ver" (domino-orientation domino))
     (make-domino (domino-color1 domino)
                  (domino-color2 domino)
                  (domino-size domino)
                  "hor")]))

(check-expect (domino-orientation (domino-turn d1)) "ver")
(check-expect (domino-orientation (domino-turn d2)) "hor")

;;;;; 6h

; check-domino : Domino -> Boolean
; (check-domino a-domino5) is my template for problem 6h

(define (check-domino a-domino)
  (and (not (equal? (domino-color1 a-domino)
                    (domino-color2 a-domino)))
       (or (equal? (domino-orientation a-domino) "hor")
           (equal? (domino-orientation a-domino) "ver"))
       (> (domino-size a-domino) 0)))

; domino-valid? : Domino -> Boolean
; (domino-valid? domino) returns a boolean value of #true if the
; inout for domino5 is a valid domino and #false otherwise

(define (domino-valid? domino)
    (and (domino? domino)
         (not (equal? (domino-color1 domino)
                    (domino-color2 domino)))
       (or (equal? (domino-orientation domino) "hor")
           (equal? (domino-orientation domino) "ver"))
       (> (domino-size domino) 0)))

(check-satisfied d1 domino-valid?)
(check-satisfied d2 domino-valid?)
(check-expect (domino-valid? 5) #false)
(check-expect (domino-valid? (make-domino 1 2 3 4)) #false)
(check-expect (domino-valid? (make-domino "red" "red" 10 "hor")) #false)
(check-expect (domino-valid? (make-domino "red" "blue" 0 "ver")) #false)
(check-expect (domino-valid? (make-domino "red" "blue" 20 "vor"))
              #false)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;; 7a

#|
   An Interval is of the form:
   (make-interval end-point1 end-point2)

   - end-point1 is the lower endpoint of the interval and end-point2
     is the upper end of the interval
|#

;;;;; 7b

(define-struct interval [a b])

; make-interval : a b -> Interval
; interval? : Interval -> Bool
; interval-a : Interval -> Num
; interval-b : Interval -> Num

;;;;; 7c

; process-interval : an-interval -> ...
; (process-interval an-interval) is my template for problem 7c

(define (process-interval an-interval)
  (... (interval-a an-interval) ...
       (interval-b an-interval) ...))

;;;;; 7d

; interval-valid? : Any -> Bool
; (interval-valid? interval) returns a boolean value of #true
; if the input is a valid interval and #false otherwise

(define (interval-valid? interval)
  (and (interval? interval)
       (number? (interval-a interval))
       (number? (interval-b interval))
       (not (> (interval-a interval)
                    (interval-b interval)))))

(check-expect (interval-valid? 5) #false)
(check-expect (interval-valid? (make-interval 4 4)) #true)
(check-expect (interval-valid? (make-interval 8 2)) #false)
(check-expect (interval-valid? (make-interval 'a 'b)) #false)

;;;;; 7e

; process-neighbors : Int -> Int
; (process-neighbors an-int) is my template for problem 7e

(define (process-neighbors an-int)
  (cond
    [(interval-a an-int) ...]
    [(interval-b an-int) ...]
    [else (error "unknow input")]))

; neighbors : Int -> Interval
; (neighbors integer) returns an interval starting at the integer to
; its left and ending with the integer to its right on the number line

(define (neighbors integer)
  (make-interval (- integer 1) (+ 1 integer)))

(check-satisfied (neighbors 3) interval?)
(check-expect (interval-a (neighbors 1)) 0)
(check-expect (interval-b (neighbors -7)) -6)

;;;;; 7f

; process-overlaps? : -> Interval Interval -> Boolean
; (process-overlaps? an-interval2 an-interval3) is my template
; for problem 7f

(define (process-overlaps? an-interval2 an-interval3)
  (cond
    [(and (>= (interval-a an-interval2)
             (interval-a an-interval3))
          (<= (interval-b an-interval2)
             (interval-b an-interval3)))
     #true]
    [(and (<= (interval-a an-interval2)
             (interval-a an-interval3))
          (<= (interval-b an-interval2)
             (interval-b an-interval3)))
     #true]
    [(and (<= (interval-a an-interval2)
             (interval-a an-interval3))
          (>= (interval-b an-interval2)
             (interval-b an-interval3)))
     #true]
    [(and (>= (interval-a an-interval2)
             (interval-a an-interval3))
          (>= (interval-b an-interval2)
             (interval-b an-interval3)))
     #true]
    [else #false]))

; overlaps? : Interval Interval -> Boolean
; (overlaps? interval2 interval3) returns #true if the two inputs
; overlap or touch and #false otherwise

(define (overlaps? an-interval2 an-interval3)
  (cond
    [(< (interval-b an-interval2)
        (interval-a an-interval3))
     #false]
    [(< (interval-b an-interval3)
        (interval-a an-interval2))
     #false]
    [else #true]))

(define area (make-interval 0 5))
(check-expect (overlaps? area (make-interval 3 10)) #true)
(check-expect (overlaps? area (make-interval -3 10)) #true)
(check-expect (overlaps? area (make-interval -3 4)) #true)
(check-expect (overlaps? area (make-interval 2 3)) #true)
(check-expect (overlaps? (make-interval 1 2) (make-interval 3 4))
              #false)
(check-expect (overlaps? (make-interval 3 4) (make-interval 1 2))
              #false)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

#|
   latitude,longitude,name,desc,color,source,precision

   39.7669106,-86.1499634,"Indianapolis, IN (IND)","Indianapolis, IN",
   ,Bing Maps,city/town

   30.2675896,-97.7429886,"Austin, TX (AUS)","Austin, TX",
   ,Bing Maps,city/town
|#

;;;;; 8a

(define IND (make-posn 39.7669106 -86.1499634))
(define AUS (make-posn 30.2675896 -97.7429886))

(check-satisfied IND posn?)
(check-satisfied AUS posn?)

;;;;; 8b

; haversin : Posn Posn -> Num
; (haversin start end) computes the distance between two posns

(define (haversin start end)
  (* 2 (planet-radius 'earth)
     (asin
      (sqrt
       (+ (haversin-helper (posn-x end) (posn-x start))
          (* (cos (posn-x start))
             (cos (posn-x end))
             (haversin-helper (posn-y end) (posn-y start))))))))

;;;;; 8c

; degrees->radians : Num -> Num
; (degrees->radians degrees) returns the result of converting
; a number from degrees into radians

(define (degrees->radians degrees)
  (/ (* degrees pi) 180))

; spherical-distance : Posn Posn -> Num
; (spherical-distance posn1 posn2) returns the spherical distance
; using the haversin formula

(define (spherical-distance posn1 posn2)
  (haversin
   (make-posn (degrees->radians (posn-x posn1))
              (degrees->radians (posn-y posn1)))
   (make-posn (degrees->radians (posn-x posn2))
              (degrees->radians (posn-y posn2)))))

;;;;; 8d

; haversin-helper : Num Num -> Num
; (haversin-helper num1 num2) retunrs the value of a part of the
; haversin forumla

(define (haversin-helper num1 num2)
  (sqr (sin (/ (- num1 num2) 2))))

; My vacation destination is about #i932.8219167565819 miles away
; My result after using haversin-helper was #i932.8219167565819

(define so-far-away (spherical-distance IND AUS))

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

;;;;; 9a

#|
   Airport type is of the form (make-airport [String Symbol Posn])
|#

;;;;; 9b

(define-struct airport [location code gps])

;;;;; 9c

(define indy (make-airport "Indianapolis, IN"
                           'IND
                           IND))

(define austin (make-airport "Austin, TX"
                             'AUS
                             AUS))

(check-satisfied indy airport?)
(check-satisfied austin airport?)
(check-satisfied (airport-location indy) string?)
(check-satisfied (airport-code indy) symbol?)
(check-satisfied (airport-gps indy) posn?)
(check-satisfied (airport-location austin) string?)
(check-satisfied (airport-code austin) symbol?)
(check-satisfied (airport-gps austin) posn?)

;;;;; 9d

; get-latitude : Airport -> Num
; (get-latitude airport) retunrs the latitude of the input

(define (get-latitude airport)
  (posn-x (airport-gps airport)))

(check-within (round (get-latitude indy)) 40 0.1)
(check-within (round (get-latitude austin)) 30 0.1)

;;;;; 9e

; get-longitude : Airport -> Num
; (get-longitude airport) returns the longitude of the input

(define (get-longitude airport)
  (posn-y (airport-gps airport)))

(check-within (round (get-longitude indy)) -86 0.1)
(check-within (round (get-longitude austin)) -98 0.1)

;;;;; 9f

; airport-distance : Airport Airport -> Num
; (airport-distance airport1 airport2) returns the spherical distance
; for the two inputs

(define (airport-distance airport1 airport2)
  (spherical-distance (airport-gps airport1)
                      (airport-gps airport2)))

(check-within (round (airport-distance indy austin)) #i933 0.1)
(check-within (round (airport-distance austin indy)) #i933.0 0.1)