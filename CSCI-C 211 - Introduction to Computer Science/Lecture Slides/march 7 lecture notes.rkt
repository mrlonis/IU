;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |march 7 lecture notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lecture-mar07")
(define team "yellow9")

#|
#|
  A NumF is one of
  - Num
  - #false

  A ListOfNum is one of
  - '()
  - (cons Num ListOfNum)
|#

; process-nums : ListOfNum -> ...
; (process-nums nums) returns ...
(define (process-nums nums)
  (cond
    [(empty? nums) ...]
    [else (... (first nums) ...
               (process-nums (rest nums)))]))

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

; first-negative : ListOfNum -> ...
; (first-negative nums) returns the leftmost negative number in nums,
; or #false if no such number exists

(define (first-negative nums)
  (cond
    [(empty? nums) #false]
    [(negative? (first nums)) (first nums)]
    [else (first-negative (rest nums))]))

(check-expect (first-negative '()) #false)
(check-expect (first-negative '(7 2 3 4)) #false)
(check-expect (first-negative '(7 -2 3 4 -6 3)) -2)

;; Experiment in the repl with the range and make-list functions
(check-expect (first-negative (range 0 100 1)) #false)
(check-expect (first-negative (make-list 25 1)) #false)


#|
Two abbreviated hand traces
===========================

1. (first-negative '(7 2 3 4))
   == (first-negative '(2 3 4))
   == (first-negative '(3 4))
   == (first-negative '(4))
   == (first-negative '())
   == #false 


2. (first-negative '(7 -2 3 4 -6 3))
   == (first-negative '(-2 3 4 -6 3))
   == -2

|#

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

; last-negative : ListOfNum -> ...
; (last-negative nums) returns the rightmost negative number in nums,
; or #false if no such number exists

(define (last-negative nums)
  (cond
    [(empty? nums) #false]
    [(negative? (first nums))(if (false? (last-negative (rest nums)))
                                 (first nums)
                                 (last-negative (rest nums)))]
    [else (last-negative (rest nums))]))



(check-expect (last-negative '()) #false)
(check-expect (last-negative '(7 2 3 4)) #false)

(check-expect (last-negative '(7 -2 3 4 -6 3)) -6)
(check-expect (last-negative (range 0 100 1)) #false)
(check-expect (last-negative (range 0 -10 -1)) -9)
(check-expect (last-negative (make-list 25 1)) #false)
(check-expect (last-negative (make-list 20 -1)) -1)

#|
Two abbreviated hand traces
===========================

1. (last-negative '(7 2 3 4))
   == (last-negative '(2 3 4))
   == (last-negative '(3 4)
   == (last-negative '(4))
   == (last-negative '())
   == #false

2. (last-negative '(7 -2 3 4 -6 3))
   == (last-negative '(-2 3 4 -6 3))
   == (if (false? (last-negative '( 3 4 -6 3)))
                          (last-negative '(-2 3 4 -6 3))
   == (if (false? 

  

|#





;;;;;;;;;;;;;;
;; Problem 6
;;;;;;;;;;;;;;

#|

  A Coin is one of
  - 'penny
  - 'nickel
  - 'dime
  - 'quarter

  A PiggyBank is one of
  - '()
  - (cons Coin PiggyBank)

|#

; penny-pincher : PiggyBank -> PiggyBank
; (penny-pincher bank) returns the result of removing all pennies
; from bank

(define (penny-pincher bank)
  (cond
    [(empty? bank) '()]
    [else (local [(define answer (penny-pincher (rest bank)))]
            (cond
              [(equal? (first bank) 'penny) answer]
              [else (cons (first bank) answer)]))]))

#|
(penny-pincher '(penny dime penny penny nickel))
== (penny-pincher '(dime penny penny nickel))
== (cons 'dime (penny-pincher '(penny penny nickel)))
== ...
|#

(check-expect (penny-pincher '()) '())
(check-expect (penny-pincher '(penny dime penny penny nickel))
              '(dime nickel))

;;;;;;;;;;;;;;
;; Problem 7
;;;;;;;;;;;;;;

; last-negative/v2 : ListOfNum -> ...
; (last-negative/v2 nums) returns the rightmost negative number in nums,
; or #false if no such number exists

(define (last-negative/v2 nums)
  (cond
    [(empty? nums) #false]
    [else (local [(define answer (last-negative/v2 (rest nums)))]
            (cond
              [(negative? (first nums))(if (false? answer)
                                 (first nums)
                                 answer)]
              [else answer]))]))

(check-expect (last-negative/v2 '()) #false)
(check-expect (last-negative/v2 '(7 2 3 4)) #false)
(check-expect (last-negative/v2 '(7 -2 3 4 -6 3)) -6)
(check-expect (last-negative/v2 (range 0 100 1)) #false)
(check-expect (last-negative/v2 (range 0 -10 -1)) -9)
(check-expect (last-negative/v2 (make-list 25 1)) #false)
(check-expect (last-negative/v2 (make-list 20 -1)) -1)
(check-expect (last-negative/v2 (make-list 25 -1)) -1)
(check-expect (last-negative/v2 (make-list 1000 -1)) -1)

|#