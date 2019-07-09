;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-mar30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-mar30")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Matthew Lonis")

#|
  A CoinDenom is one of
  - 1
  - 5
  - 10
  - 25

  A [2List X Y] is a (list X Y)
|#

; give-away : [ListOf CoinDenom] -> [2List Nat Nat]
; (give-away pocket) returns the result of giving pocket coins
; to Alice and Bob, such that the child with less money always gets
; the next coin (with ties going to Alice)

(define (give-away pocket)
  (give-away/help pocket 0 0))

(check-expect (give-away '()) '(0 0))
(check-expect (give-away '(25)) '(25 0))
(check-expect (give-away '(10 25)) '(10 25))
(check-expect (give-away '(10 5 1 5 25 10)) '(35 21))

; give-away/help : [ListOf CoinDenom] Nat Nat -> [2List Nat Nat]
; (give-away/help pocket alice bob) returns the result of giving pocket
;coins
; to Alice and Bob, such that the child with less money always gets
; the next coin (with ties going to Alice)

(define (give-away/help pocket alice bob)
  (cond
    [(empty? pocket) (list alice bob)]
    [(<= alice bob) (give-away/help (rest pocket) (+ (first pocket)
                                                     alice) bob)]
    [else (give-away/help (rest pocket) alice (+ (first pocket) bob))]))

(check-expect (give-away/help '() 50 60) '(50 60))
(check-expect (give-away/help '(25) 50 60) '(75 60))
(check-expect (give-away/help '(10 25) 50 60) '(85 60))

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Andre Quan")

#|
  A PowerOfTwo is one of
  - 1
  - (* PowerOfTwo 2) 
|#

; powers-of-two : Nat -> [ListOf PowerOfTwo]
; (powers-of-two n) returns a list of elements to the power of
; two

(define (powers-of-two n)
  (build-list n 
                 ; Nat -> PowerOfTwo
                 (λ (i) (expt 2 i))))

(check-expect (powers-of-two 0) '())
(check-expect (powers-of-two 1) '(1))
(check-expect (powers-of-two 10) '(1 2 4 8 16 32 64 128 256 512))


;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Josh Lipe-Melton")

; reverse/v1 : [ListOf X] -> [ListOf X]
; (reverse/v1 ls) returns returns the result of reversing the top-level
; elements of ls

(define (reverse/v1 ls)
  (cond
    [(empty? ls) '()]
    [else (append (reverse/v1 (rest ls)) (list (first ls)))]))

(check-expect (reverse/v1 '()) '())
(check-expect (reverse/v1 '(a b c d e f g h i)) '(i h g f e d c b a))

#|
(reverse/v1 '(1 2 (3 4) 5))
== (append (reverse/v1 '(2 (3 4) 5)) '(1))
== (append (append (reverse/v1 '((3 4) 5)) '(2)) '(1))
== (append (append (append (reverse/v1 '(5)) '((3 4) '(2)) '(1))))
== (append (append (append (append (reverse/v1 '()) '((5) (3 4) '(2))
                                   '(1)))))
== (append (append (append (append '() '((5) (3 4) '(2)) '(1)))))
== (append (append (append '(5 (3 4) '(2)) '(1))))
== (append (append '(5 '(3 4)) '(2)) '(1))
== (append '(5 '(3 4) 2) '(1))
== '(5 '(3 4) 2 1)
|#

;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Grant Eller")

; snowplow : [ListOf X] -> [ListOf X]
; (snowplow ls) returns ls with all occurrences of 'snow
; pushed to the end

(define (snowplow ls)
  (snowplow/help ls '()))

; snowplow/help : [ListOf X] [ListOf 'snow] -> [ListOf X]
; (snowplow/help ls pile) returns a list formed from all
; non-snow values in ls, followed by all the 'snow in ls,
; followed by the pile

(define (snowplow/help ls pile)
  (cond
    [(empty? ls) pile]
    [(equal? (first ls) 'snow) (snowplow/help (rest ls)
                                              (cons 'snow pile))]
    [else (cons (first ls) (snowplow/help (rest ls) pile))]))


(check-expect (snowplow '()) '())
(check-expect
 (snowplow '(sleet hail snow snow rain snow))
 '(sleet hail rain snow snow snow))
(check-expect
 (snowplow '(snow a snow b snow c d snow e))
 '(a b c d e snow snow snow snow))
(check-expect
 (snowplow '(4 2 9 7 1))
 '(4 2 9 7 1))
(check-expect (snowplow (make-list 100 'snow))
              (make-list 100 'snow))

;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

(define scribe5 "Andrew James Andjelic")

; reverse/v2 : shark -> tuna
; (reverse/v2 ls) returns the result of reversing the top-level
; elements of ls

(define (reverse/v2 ls)
  (foldl cons '() ls))


(check-expect (reverse/v2 '()) '())
(check-expect (reverse/v2 '(a b c d e f g h i)) '(i h g f e d c b a))

(define (ignore x) #true)

(local [(define n 1000)
        (define ls (build-list n (lambda (i) (random n))))]
  (list (ignore (time (reverse/v1 ls)))
        (ignore (time (reverse/v2 ls)))))

(local [(define n 10000)
        (define ls (build-list n (lambda (i) (random n))))]
  (list (ignore (time (reverse/v1 ls)))
        (ignore (time (reverse/v2 ls)))))

;SUMMARIZE and EXPLAIN your findings here:
; reverse/v2 

;;;;;;;;;;;;;;
;; Problem 6
;;;;;;;;;;;;;;

(define scribe6 "")

; give-away/v2 : ... -> ...
; (give-away/v2 pocket) returns the result of giving pocket coins
; to Alice and Bob, such that the child with less money always gets
; the next coin (with ties going to Alice)

(define (give-away/v2 pocket)
  (foldl
   ; ...
   (lambda (denom accs)
     ...)
   ...
   pocket))

#|
(check-expect (give-away/v2 '()) '(0 0))
(check-expect (give-away/v2 '(25)) '(25 0))
(check-expect (give-away/v2 '(10 25)) '(10 25))
(check-expect (give-away/v2 '(10 5 1 5 25 10)) '(35 21))
|#
