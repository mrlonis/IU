;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define handin "lab11")
(define partner "Aidana Baitassova (abaitass)")
(define collaboration-statement
  (string-append "I worked with " partner "."))

#|
  A MathOp is one of:
  - Num
  - [Num Num] -> Num
|#

; rpn : [ListOf MathOp] -> Num
; (rpn ls) returns the result of the reverse polish notation formula
; given

#|
(define (rpn ls)
  (rpn/help ls '()))
|#

(define (rpn ls)
  (local [(define (rpn/help ls pile)
            (cond
              [(number? ls) (cons ls pile)]
              [else (cons (ls (first pile)
                              (second pile))
                          (rest (rest pile)))]))]
    (first (foldl rpn/help '() ls))))

; rpn/help : [ListOf MathOp] [ListOf X]
; (rpn/help ls pile) returns the result of moving all the numbers in ls
; into a pile and then performing a mathematical operation when the
; list starts with a mathematical operator

#|
(define (rpn/help ls pile)
  (cond
    [(empty? ls) (first pile)]
    [(number? (first ls))
     (rpn/help (rest ls) (cons (first ls) pile))]
    [else (rpn/help
           (rest ls)
           (cons ((first ls)
                 (first pile)
                 (second pile)) (rest (rest pile))))]))
|#

(check-expect (rpn (list 1 2 +)) 3)
(check-expect (rpn (list 1 2 + 6 + 8 +)) 17)
(check-expect (rpn (list 100 2 +)) 102)
(check-expect (rpn (list 51 2 +)) 53)
(check-expect (rpn (list 1 2 -)) 1)
(check-expect (rpn (list 1 10 -)) 9)
(check-expect (rpn (list 1 10 *)) 10)
(check-expect (rpn (list 4 10 *)) 40)
(check-within (rpn (list 4 10 /)) 2.5 0.1)
(check-within (rpn (list 10 4 /)) 0.4 0.1)
(check-expect (rpn (list 1 10 /)) 10)
(check-within (rpn (list 10 1 /)) 0.1 0.1)
(check-expect (rpn (list 10 10 / 1 /)) 1)

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

; count-coins : PiggyBank -> Nat
; (count-coins piggy-bank) retunrs a Nat for the value of coins in the
; PiggyBank

(define (count-coins coins)
  (local [(define (counting coin count)
            (+ (coin->cents coin) count))]
    (foldl counting 0 coins)))

#|
(define (count-coins piggy-bank)
  (cond
    [(empty? piggy-bank) 0]
    [else (+ (coin->cents (first piggy-bank))
             (count-coins (rest piggy-bank)))]))
|#

(check-expect (count-coins '()) 0)
(check-expect (count-coins (cons 'penny (cons 'penny '()))) 2)
(define bank (cons 'quarter
                     (cons 'penny
                           (cons 'nickel
                                 (cons 'penny
                                       (cons 'dime '()))))))
(check-expect (count-coins bank) 42)

; make-color-chart : ListOfColors -> Image
; (make-color-chart ColorList) returns an image with rectangles
; side-by-side corresponding to each color in the list

(define (make-color-chart color-list)
  (local [(define (image-maker color)
            (rectangle 30 100 "solid" color))]
  (foldr beside empty-image (map image-maker color-list))))

#|
(define (make-color-chart color-list)
  (cond
    [(empty? color-list) empty-image]
    [else (beside (rectangle 30 100 "solid" (first color-list))
                  (make-color-chart (rest color-list)))]))
|#

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