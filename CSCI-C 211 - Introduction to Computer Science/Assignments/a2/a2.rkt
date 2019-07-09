;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a2")
(define collaboration-statement "I worked alone")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a
; f : Num Image Bool -> String

(define (f x img b)
   "rubbish")
(check-satisfied (f 5 empty-image true) string?)

;;;;; 1b
; nonsense : Nat String Bool -> String

(define (nonsense x string b)
   "Laser")
(check-satisfied (nonsense 3 "string" true) string?)

;;;;; 1c
; palindrome? : String -> Bool

(define (palindrome? string)
   #true)
(check-satisfied (palindrome? "string") boolean?)

;;;;; 1d
; image-straighten : Num Image -> Image

(define (image-straighten x img)
  (circle 20 "solid" "blue"))
(check-satisfied
 (image-straighten 5 (square 20 "solid" "blue")) image?)

;;;;; 1e
; exclusive-or : Bool Bool -> Bool

(define (exclusive-or b bo)
  #true)
(check-satisfied (exclusive-or #true #false) boolean?)

;;;;; 1f
; date->day-of-week : String Int Int -> String

(define (date->day-of-week string x y)
  "Friday")

(check-satisfied (date->day-of-week "Thursday" 4 5) string?)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;;;;; 2a
; number-square : Num -> Num
; (number-square x) produces the result of squaring x
 
(define (number-square x)
   (expt x 2))
 
(check-expect (number-square 8) 64)
(check-within (number-square -2.3) 5.29 .1)

;;;;; 2b
; euclidian-distance : Num Num Num Num -> Num
; (euclidean-distance x1 y1 x2 y2) produces the result of the square
; root of the sum of the squared differences between (x1 & x2) and
; (y1 & y2)

(define (euclidean-distance x1 y1 x2 y2)
  (sqrt (+ (number-square (- x1 x2)) (number-square (- y1 y2)))))

(check-expect (euclidean-distance 9 12 3 4) 10)
(check-expect (euclidean-distance 18 24 6 8) 20)

;;;;; 2c
;  circle-area : Num -> Num
; (circle-area radius) produces a rounded result of the radius
; of a circle squared and then multiplied by pi

(define (circle-area radius)
  (round (* pi (number-square radius))))

(check-within (circle-area 10) 314.0 .1)
(check-within (circle-area 100) 31416.0 .1)

;;;;; 2d
; image-area : Img -> Num
; (image-area pic) produces the image area of an image by multiplying
; the image width by the image height

(define (image-area pic)
  (* (image-width pic) (image-height pic)))

(check-expect (image-area (circle 20 "solid" "green")) 1600)
(check-expect (image-area (circle 100 "solid" "green")) 40000)

;;;;; 2e
; make-name : String String String -> String
; (make-name first middle-initial last) produces a string in the form
; of "Last, First Middle-intial."

(define (make-name first middle-initial last)
  (string-append last ", " first " " middle-initial "."))

(check-expect (make-name "Matthew" "R" "Lonis") "Lonis, Matthew R.")
(check-expect (make-name "Chris" "R" "Canaday") "Canaday, Chris R.")

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; number-crop : Num Num Num -> Num
; (number-crop a b x) returns the median value of three numbers
; regardless of the order

(define (number-crop a b x)
  (min (max a b)(max b x)))

(check-expect (number-crop 4 0 10) 4)
(check-expect (number-crop 7 -2 3) 3)
(check-expect (number-crop -5 -2 3) -2)
(check-expect (number-crop -1000000 -2 5768) -2)
(check-expect (number-crop -123 456 789) 456)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; disjunction : String String -> String
; (disjunction string1 string2) returns a string-append of string1
; and string2 with " or " in between them

(define (disjunction string1 string2)
  (string-append string1 " or " string2))

(check-expect (disjunction "paper" "plastic")
              "paper or plastic")
(check-expect (disjunction "trick" "treat")
              "trick or treat")
(check-expect (disjunction "to be" "not to be")
              "to be or not to be")

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

;;;;; 5a
; string-left : String -> String
; (string-left string) returns the leftmost string of the orignal
; string entered into the function

(define (string-left string)
  (substring string 0 (quotient (string-length string) 2)))

(check-expect (string-left "") "")
(check-expect (string-left "bookworm") "book")
(check-expect (string-left "substring") "subs")

;;;;; 5b
; string-right : String -> String
; (string-right string) returns the rightmost string of the
; original string entered into the function

(define (string-right string)
  (substring string (quotient (+ 1 (string-length string)) 2)))

(check-expect (string-right "") "")
(check-expect (string-right "bookworm") "worm")
(check-expect (string-right "substring") "ring")

;;;;; 5c
; string-middle : String -> String
; (string-middle string) returns the middle character of a given
; string if one exists, otherwise it returns an empty string

(define (string-middle string)
  (if (odd? (string-length string))
      (string-ith string (quotient (string-length string) 2))
      ""))

(check-expect (string-middle "") "")
(check-expect (string-middle "bookworm") "")
(check-expect (string-middle "substring") "t")

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

; roll : Image -> Image
; (roll image) produces an image containing the original image and
; three other images next to the original that are all rotated by 90
; degree from the image to its left

(define (roll image)
  (beside image
          (rotate -90 image)
          (rotate -180 image)
          (rotate -270 image)))

(check-satisfied
 (roll (star-polygon 40 5 2 "outline" "seagreen")) image?)
(check-satisfied (roll (circle 30 "solid" "yellow")) image?)
(check-satisfied (image-width (roll empty-image)) number?)
(check-satisfied (roll (triangle 20 "solid" "red")) image?)
(check-satisfied
 (roll (roll (triangle 15 "solid" "indigo"))) image?)
(check-satisfied
 (roll (roll (roll (triangle 10 "solid" "magenta")))) image?)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

; horizontal-line : Num -> Img
; (horizontal-line x) produces a horizontal line with width x and
; a height of 1

(define (horizontal-line x)
  (rectangle x 1 "solid" "black"))

(check-expect (image-width (horizontal-line 100)) 100)
(check-expect (image-height (horizontal-line 100)) 1)
(check-expect (image-width (horizontal-line 200)) 200)
(check-expect (image-height (horizontal-line 200)) 1)
(check-expect (image-width (horizontal-line 150)) 150)
(check-expect (image-height (horizontal-line 150)) 1)
(check-expect (image-width (horizontal-line 300)) 300)
(check-expect (image-height (horizontal-line 300)) 1)

; vertical-line : Num -> Img
; (vertical-line x) produces a vertical line with width 1 and
; a height of x

(define (vertical-line x)
  (rectangle 1 x "solid" "black"))

(check-expect (image-width (vertical-line 30)) 1)
(check-expect (image-height (vertical-line 30)) 30)
(check-expect (image-width (vertical-line 60)) 1)
(check-expect (image-height (vertical-line 60)) 60)
(check-expect (image-width (vertical-line 45)) 1)
(check-expect (image-height (vertical-line 45)) 45)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

; add-left-border : Img -> Img
; (add-left-border image) adds a black vertical line to the left
; of the image that is input into the function

(define (add-left-border image)
  (beside/align "middle" (vertical-line (image-height image))
           image))

(check-expect (image-height
               (add-left-border
                (square 40 "solid" "yellow")))
              40)
(check-expect (image-width
               (add-left-border
                (square 40 "solid" "yellow")))
              41)

; add-right-border : Img -> Img
; (add-right-border image) adds a black vertical line to the right
; of the image that is input into the function

(define (add-right-border image)
  (beside/align "middle" image (vertical-line (image-height image))))

(check-expect (image-height
               (add-right-border
                (square 40 "solid" "yellow")))
              40)
(check-expect (image-width
               (add-right-border
                (square 40 "solid" "yellow")))
              41)

; add-top-border : Img -> Img
; (add-top-border image) adds a black vertical line to the top
; of the image that is input into the function

(define (add-top-border image)
  (above/align "middle" (horizontal-line (image-width image))
           image))

(check-expect (image-height
               (add-top-border
                (square 40 "solid" "yellow")))
              41)
(check-expect (image-width
               (add-top-border
                (square 40 "solid" "yellow")))
              40)

; add-bottom-border : Img -> Img
; (add-bottom-border image) adds a black vertical line to the bottom
; of the image that is input into the function

(define (add-bottom-border image)
  (above/align "middle" image (horizontal-line (image-width image))))

(check-expect (image-height
               (add-bottom-border
                (square 40 "solid" "yellow")))
              41)
(check-expect (image-width
               (add-bottom-border
                (square 40 "solid" "yellow")))
              40)

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

; add-frame : Img -> Img
; (add-frame image) adds black lines around the border of the image
; input into the equation. An addition operation in the vertical lines
; was performed to keep consistent lengths accross the entire image
; which in this case is a square

(define (add-frame image)
  (beside/align "middle" (vertical-line (+ 2 (image-height image)))
          (above/align "middle" (horizontal-line (image-width image))
                 image
                 (horizontal-line (image-width image)))
          (vertical-line (+ 2 (image-height image)))))

(check-expect (image-width
               (add-frame (square 40 "solid" "yellow"))) 42)
(check-expect (image-height
               (add-frame (square 40 "solid" "yellow"))) 42)

(check-expect (image-width
              (add-frame (square 20 "solid" "pink"))) 22)
(check-expect (image-height
               (add-frame (square 20 "solid" "pink"))) 22)

;;;;;;;;;;;;;;;
;; Problem 10 ;
;;;;;;;;;;;;;;;

; tetris-t-piece : Num String -> Img
; (tetris-t-piece num color) returns a tetris piece in the shape of
; a t with a given length/width of each square as the num and the
; color of the square designated by color

(define (tetris-t-piece num color)
  (above (beside (add-left-border
                  (add-bottom-border
                   (add-top-border
                    (square num "solid" color))))
                 (add-frame (square num "solid" color))
                 (add-right-border
                  (add-top-border
                   (add-bottom-border
                    (square num "solid" color)))))
         (add-left-border
          (add-right-border
           (add-bottom-border
            (square num "solid" color))))))

(check-expect (image-width (tetris-t-piece 50 "sky blue")) 154)
(check-expect (image-height (tetris-t-piece 50 "sky blue")) 103)

;;;;;;;;;;;;;;;
;; Problem 11 ;
;;;;;;;;;;;;;;;

; draw-piece : Img Num Img -> Image
; (draw-piece t-piece num scene) returns an image of a tetris piece
; (denoted by the variable t-piece) in a y-position (denoted
; by the num variable) on a empty-scene of 300 by 400 (as denoted
; by the variable scene. i had to make the x value in place-image/
; align as 150 in order to center the piece

(define (draw-piece t-piece num scene)
  (place-image/align t-piece
                     150 num "center" "top"
                     scene))

(check-satisfied
 (draw-piece (tetris-t-piece 50 "sky blue")
              0
              (empty-scene 300 400))
 image?)

;;;;;;;;;;;;;;;
;; Problem 12 ;
;;;;;;;;;;;;;;;

; tetris-frame : Num -> Img
; (tetris-frame t) shows the t-piece at a given time in an animate
; sequence. This works by having t correspond to the y value the piece
; would be at in the same frame as t. In other words when the piece
; is at 200 for its y value, itll be the 200th frame

(define (tetris-frame t)
  (draw-piece (tetris-t-piece 50 "magenta")
              t
              (empty-scene 300 400)))

(check-satisfied (tetris-frame 0) image?)