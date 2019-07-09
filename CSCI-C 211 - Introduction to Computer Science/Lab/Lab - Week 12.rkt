;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lab12")
(define partner "Chris Canaday (crcanada)")
(define collaboration-statement
  (string-append "I worked with " partner "."))

#|
  A [SortedListOf X] is one that is sorted yo
|#

; selection-sort : [ListOf X] > [ListOf X]

(define (selection-sort ls)
  (local [; list-max : [ListOf X] -> X
          ; (list-max this-ls) returns the maximum elemen in a list
          (define (list-max this-ls)
            (foldl max (first this-ls) (rest this-ls)))
          ; loop : [ListOf X] [SortedListOf X] -> [SortedListOf X]
          (define (loop this-ls sorted)
              (cond
                [(empty? this-ls) sorted]
                [else (local [(define ls-max (list-max this-ls))]
                        (loop (remove ls-max this-ls)
                            (cons ls-max sorted)))]))]
    (loop ls '())))

(check-expect (selection-sort '(3 2 1)) '(1 2 3))
(check-expect (selection-sort '(9 10 3 8 1 47 1001 10 20))
              '(1 3 8 9 10 10 20 47 1001))
(check-expect (selection-sort '(-100 -1002232432))
              '(-1002232432 -100))

; image-area : Image -> PosNum

(define (image-area img)
  (* (image-width img)
     (image-height img)))

; image-max : [NonemptyListOf Image] -> Image
; (image-max ls) returns the image with the biggest area in the list

(define (image-max ls-img)
  (foldl (lambda (next-image big-image)
           (if (< (image-area next-image)
                  (image-area big-image))
               big-image
               next-image))
         empty-image
         ls-img))

(check-expect (image-max (list (square 40 "solid" "red")
                               (square 20 "solid" "yellow")))
              (square 40 "solid" "red"))
(check-expect (image-max (list (square 40 "solid" "red")))
              (square 40 "solid" "red"))

; sort-by-area : [ListOf Img] -> [SortedListOf Img]
; (sort-by-area ls) returns a list of images sorted by increasing image
; area

(define (sort-by-area ls)
  (local [; loop : [ListOf X] [SortedListOf X] -> [SortedListOf X]
          (define (loop this-ls sorted)
            (local [(define ls-max (image-max this-ls))]
              (cond
                [(empty? this-ls) sorted]
                [else (loop (remove ls-max this-ls)
                            (cons ls-max sorted))])))]
    (loop ls '())))

(check-expect (sort-by-area (list (square 40 "solid" "red")
                               (square 20 "solid" "yellow")))
              (list (square 20 "solid" "yellow")
                    (square 40 "solid" "red")))
(check-expect (sort-by-area (list (square 40 "solid" "red")))
              (list (square 40 "solid" "red")))

; selection-sort/v2 : [X X -> Bool] [ListOf X] -> [ListOf X]
; (selection-sort/v2 rel? ls) takes a relation (ie >, <, image-greater?)
; and a list and returns the sorted list based on the relation

; selection-sort : [ListOf X] [X X -> Bool] -> [ListOf X]

(define (selection-sort/v2  ls rel?)
  (local [; list-max : [ListOf X] -> X
          ; (list-max this-ls) returns the maximum elemen in a list
          (define (list-rel this-ls)
            (foldl (lambda (max min)
                     (if (rel? max min)
                         max
                         min))
                   (first this-ls) (rest this-ls)))
          ; loop : [ListOf X] [SortedListOf X] -> [SortedListOf X]
          (define (loop this-ls sorted)
              (cond
                [(empty? this-ls) sorted]
                [else (local [(define ls-rel (list-rel this-ls))]
                        (loop (remove ls-rel this-ls)
                            (cons ls-rel sorted)))]))]
    (loop ls '())))

(check-expect (selection-sort/v2 '(3 2 1) >) '(1 2 3))
(check-expect (selection-sort/v2 '(9 10 3 8 1 47 1001 10 20) >)
              '(1 3 8 9 10 10 20 47 1001))
(check-expect (selection-sort/v2 '(-100 -1002232432) >)
              '(-1002232432 -100))
(check-expect (selection-sort/v2 '(3 2 1) <) '(3 2 1))
(check-expect (selection-sort/v2 '(9 10 3 8 1 47 1001 10 20) <)
              '(1001 47 20 10 10 9 8 3 1))
(check-expect (selection-sort/v2 '(-100 -1002232432) <)
              '(-100 -1002232432))