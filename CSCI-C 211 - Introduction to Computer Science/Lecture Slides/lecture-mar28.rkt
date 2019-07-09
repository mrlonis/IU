;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-mar28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-mar28")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Andrew Andjelic")

; list-sum/v1 : [ListOf Num] -> Num
; (list-sum/v1 nums) returns the sum of all numbers in nums

(define (list-sum/v1 nums)
  (cond
    [(empty? nums) 0]
    [else (+ (first nums) (list-sum/v1 (rest nums)))]))

; list-sum/v2 : [ListOf Num] -> Num
; (list-sum/v2 nums) returns the sum of all numbers in nums

(define (list-sum/v2 nums)
  (cond
    [(empty? nums) 0]
    [(empty? (rest nums)) (first nums)]
    [else (+ (first nums) (list-sum/v2 (rest nums)))]))

; list-sum/v3 : [ListOf Num] -> Num
; (list-sum/v3 nums) returns the sum of all numbers in nums

(define (list-sum/v3 nums)
  (cond
    [(zero? (length nums)) 0]
    [else
     (+ (first nums) (list-sum/v3 (rest nums)))]))

; ignore : X -> Bool
; (ignore x) returns #true always

(define (ignore x) #true)

#|
(local [(define nums (make-list 100000 0))]
  (ignore (list (time (list-sum/v1 nums))
                (time (list-sum/v2 nums))
                (time (list-sum/v3 nums)))))
|#

(define list-sum list-sum/v1)

#|
Summarize and explain your findings here:

list-sum/v3 is the slowest because it makes use of the length function
every time it recurs, a very cpu time intensive. list-sum/v2 is slower
than list-sum/v1 since it checks the rest of the list for empty, which
is an extra step. list-sum/v1 is faster than list-sum/v2 since it has
no such extra step.
|#

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Andre Quan")

#|
  A Smiley is one of
  - ":)"
  - ":("
|#

; smiley-flip : [ListOf Smiley] -> [ListOf Smiley]
; (smiley-flip emoticons) returns the result of substituting each
; happy smiley with a sad one, and visa versa, in emoticons

(define (smiley-flip emoticons)
  (map (lambda (x)
         (if (equal? x ":)")
             ":("
             ":)"))
       emoticons))


(check-expect (smiley-flip '()) '())
(check-expect (smiley-flip '(":)" ":)" ":(" ":)" ":(" ":(" ":("))
              '(":(" ":(" ":)" ":(" ":)" ":)" ":)"))


;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Grant Eller")

#|
  An RGB is an Int in [0..255]

  A Color is one of
  - String
  - Symbol
  - (make-color RGB RGB RBG)
|#

; make-color-chart : [ListOf Color] -> Image
; (make-color-chart colors) returns a bar chart formed from colors

#|
(define (make-color-chart colors)
  (cond
    [(empty? colors) empty-image]
    [else (beside
           (rectangle 30 100 "solid" (first colors))
           (make-color-chart (rest colors)))]))
|#

; make-color-chart : [ListOf Color] -> Image
; (make-color-chart colors) returns a bar chart formed from colors

(define (make-color-chart colors)
  (foldr (lambda (x ans)
           (beside (rectangle 30 100 "solid" x)
                   ans))
         empty-image
         colors))


(define colors '(red orange yellow green blue indigo violet))

(check-satisfied (make-color-chart colors) image?)

;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Josh Lipe-Melton")

; count-sheep/v1 : ... -> ...
; (count-sheep/v1 ls) returns the number of occurrences of 'sheep
; in ls at top level

(define (count-sheep/v1 ls)
  (length (filter (lambda (x) (equal? x 'sheep))
                  ls)))

(check-expect (count-sheep/v1 '()) 0)
(check-expect (count-sheep/v1 '(sheep sheep ewe sheep ram sheep)) 4)
(check-expect (count-sheep/v1 (make-list 1000 'sheep)) 1000)

; count-sheep/v2 : [ListOf X] -> Nat
; (count-sheep/v2 ls) returns the number of occurrences of 'sheep
; in ls at top level

(define (count-sheep/v2 ls)
  (foldr (lambda (x ans)
           (if (equal? 'sheep x)
               (add1 ans)
               (+ 0 ans)))
         0
         ls))

(check-expect (count-sheep/v2 '()) 0)
(check-expect (count-sheep/v2 '(sheep sheep ewe sheep ram sheep)) 4)
(check-expect (count-sheep/v2 (make-list 1000 'sheep)) 1000)

;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

(define scribe5 "Andrew Andjelic")

; least-positive-number : ... -> ...
; (least-positive-number ls) returns the smallest positive
; number in ls, or #false if no such number exists

(define (least-positive-number ls)
  (foldr (lambda (x ans)
           (if (false? ans)
               (if (positive? x)
                   x
                   ans)
               (if (and (positive? x) (< x ans))
               x
               ans)))
         #false
         ls))

(check-expect (least-positive-number '(-3 7 0 21 -1 5 9 -2 4)) 4) 
(check-expect (least-positive-number (make-list 100 -2)) #false)
(check-expect (least-positive-number (range -100 100 10)) 10)
(check-expect (least-positive-number (range 100 -100 -1)) 1)

;;;;;;;;;;;;;;
;; Problem 6
;;;;;;;;;;;;;;

#|
  A CoinDenom is one of
  - 1
  - 5
  - 10
  - 25

  A [2List X Y] is a (list X Y)
|#

(define scribe6 "Josh Lipe-Melton")

; give-away : ... -> ...
; (give-away pocket) returns the result of giving pocket coins
; to Alice and Bob, such that the child with less money always gets
; the next coin (with ties going to Alice)

#|(define (give-away pocket)
  )|#

#|
(check-expect (give-away '()) '(0 0))
(check-expect (give-away '(25)) '(25 0))
(check-expect (give-away '(10 25)) '(10 25))
(check-expect (give-away '(10 5 1 5 25 10)) '(35 21))
|#

#|
(define (give-away/help pocket alice bob)
  (cond
    [(empty? pocket) (list alice bob)]
    [(<= alice bob) (give-away/hel (first pocket) alice)]
    [(> alice bob) (+ (first pocket) bob)]))
|#


#|
(check-expect (give-away/help '() 50 60) '(50 60))
(check-expect (give-away/help '(25) 50 60) '(75 60))
(check-expect (give-away/help '(10 25) 50 60) '(85 60))
|#

