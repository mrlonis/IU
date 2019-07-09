;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname midterm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "midterm")

(require 2htdp/image)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;;;;; 4a

#|
  An Emotion is one of
  - 'sad
  - 'happy
|#

;;;;; 4b

#|
  A Journey is one of
  - '()
  - (cons Int '())
  - (cons Int (cons emotion Journey))
|#

;;;;; 4c

; mouse-status : Journey -> Emotion
; (mouse-status journey) returns the emotion experienced by the mouse at
; the end of its Journey

#|
(define (mouse-status journey)
  (list-ref journey (- (length journey) 1)))
|#

(define (emotion? emotion)
  (or (equal? emotion 'sad)
      (equal? emotion 'happy)))

(define (mouse-status journey)
  (cond
    [(emotion? (first journey)) (first journey)]
    [else (mouse-status (rest journey))]))

(check-expect (mouse-status '(5 6 7 6 5 4 3 sad)) 'sad)
(check-expect (mouse-status '(-3 -4 happy)) 'happy)
(check-expect (mouse-status '(1 2 3 4 5 6 5 4 3 2 1 0 happy)) 'happy)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
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

#|
  A Nat is one of
  - 0
  - (add1 Nat)
|#

; place-grid-horz-line : Nat Color Image Nat
; (place-image-horz-line n color shape tracker) returns a list of
; (- n 1) horizontal lines to be used later in a place-images function

(define (place-grid-horz-line n color shape tracker)
  (cond
    [(= tracker n) '()]
    [else (cons (horizontal-line (image-height shape))
                (place-grid-horz-line n color shape (add1 tracker)))]))

(check-expect
 (place-grid-horz-line 10 "black" (square 200 "solid" "white") 1)
 (list (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)
       (horizontal-line 200)))

; place-grid-horz-posn : Nat Color Image Nat
; (place-image-horz-line n color shape tracker) returns a list of
; (- n 1) posns to be used later in a place-images function

(define (place-grid-horz-posn n color shape tracker)
  (cond
    [(= tracker n) '()]
    [else (cons (make-posn (/ (image-height shape) 2)
                           (* tracker (/ (image-height shape) n)))
                (place-grid-horz-posn n color shape (add1 tracker)))]))

(check-expect
 (place-grid-horz-posn 10 "black" (square 200 "solid" "white") 1)
 (list
  (make-posn 100 20)
  (make-posn 100 40)
  (make-posn 100 60)
  (make-posn 100 80)
  (make-posn 100 100)
  (make-posn 100 120)
  (make-posn 100 140)
  (make-posn 100 160)
  (make-posn 100 180)))

; place-grid-horz : Nat Color Image Nat
; (place-image-horz n color shape tracker) returns an image with (- n 1)
; hoizontal lines overlayed on top of shape

(define (place-grid-horz n color shape tracker)
  (place-images
   (place-grid-horz-line n color shape tracker)
   (place-grid-horz-posn n color shape tracker)
   shape))

(check-satisfied
 (place-grid-horz 10 "black" (square 200 "solid" "white") 1)
 image?)

; place-grid-ver-line : Nat Color Image Nat
; (place-image-horz-line n color shape tracker) returns a list of
; (- n 1) vertical lines to be used later in a place-images function

(define (place-grid-ver-line n color shape tracker)
  (cond
    [(= tracker n) '()]
    [else (cons (vertical-line (image-height shape))
                (place-grid-ver-line n color shape (add1 tracker)))]))

(check-expect
 (place-grid-ver-line 10 "black" (square 200 "solid" "white") 1)
 (list (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)
       (vertical-line 200)))

; place-grid-horz-line : Nat Color Image Nat
; (place-image-horz-line n color shape tracker) returns a list of
; (- n 1) posns to be used later in a place-images function

(define (place-grid-ver-posn n color shape tracker)
  (cond
    [(= tracker n) '()]
    [else (cons (make-posn (* tracker (/ (image-height shape) n))
                           (/ (image-height shape) 2))
                (place-grid-ver-posn n color shape (add1 tracker)))]))

(check-expect
 (place-grid-ver-posn 10 "black" (square 200 "solid" "white") 1)
 (list
  (make-posn 20 100)
  (make-posn 40 100)
  (make-posn 60 100)
  (make-posn 80 100)
  (make-posn 100 100)
  (make-posn 120 100)
  (make-posn 140 100)
  (make-posn 160 100)
  (make-posn 180 100)))

; place-grid-ver : Nat Color Image Nat
; (place-image-ver n color shape tracker) returns an image with (- n 1)
; vertical lines overlayed on top of shape

(define (place-grid-ver n color shape tracker)
  (place-images
   (place-grid-ver-line n color shape tracker)
   (place-grid-ver-posn n color shape tracker)
   shape))

(check-satisfied
 (place-grid-ver 10 "black" (square 200 "solid" "white") 1)
 image?)

; place-grid : Nat Color Img -> Img
; (place-grid n color shape) return the result of superimposing a n x n
; grid over the given image, where the gridlines are in the given color

(define (place-grid n color shape)
  (place-grid-ver n color (place-grid-horz n color shape 1) 1))

(check-satisfied (place-grid 10 "black" (square 200 "solid" "white"))
                 image?)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

;;;;; 6a

; string-abbreviate : Nat String -> String
; (string-abbreviate n string) returns a possibly cropped version of the
; string a character n. If the string is cropped, then it is terminated
; with three dots. Otherwise, the string is returned unchanged

(define (string-abbreviate n string)
  (cond
    [(equal? string "") ""]
    [(zero? n) "..."]
    [(or (= n (string-length string))
         (> n (string-length string)))
     string]
    [else (string-append (substring string 0 n) "...")]))

(check-expect (string-abbreviate 0 "") "")
(check-expect (string-abbreviate 0 "To be, or not to be.") "...")
(check-expect
 (string-abbreviate 19 "One fish, two fish, red fish, blue fish")
 "One fish, two fish,...")
(check-expect
 (string-abbreviate 10 "99 bottles of beer on the wall")
 "99 bottles...")
(check-expect
 (string-abbreviate 26 "Stay hungry. Stay foolish.")
 "Stay hungry. Stay foolish.")
(check-expect
 (string-abbreviate 100 "Now is the time.")
 "Now is the time.")

;;;;; 6b

; list-abbreviate : Nat List -> List
; (list-abbreviate n list) retunrs a possibly cropped version of the
; list at list item n. If the list is cropped, then it is terminated
; with a symbol consisting of three dots. Otherwise, the list is
; returned unchanged

(define (list-abbreviate n list)
  (cond
    [(empty? list) '()]
    [(zero? n) (cons '... '())]
    [(or (= n (length list))
         (> n (length list)))
     list]
    [else (cons (first list)
                (list-abbreviate (- n 1)  (rest list)))]))

(check-expect
 (list-abbreviate 0 '()) '())
(check-expect
 (list-abbreviate 0 '(a b c)) (list '...))
(check-expect
 (list-abbreviate 2 '(a b c d e f))
 (list 'a 'b '...))
(check-expect (list-abbreviate 2 '(a b))
              (list 'a 'b))
(check-expect (list-abbreviate 100 '(a b))
              (list 'a 'b))