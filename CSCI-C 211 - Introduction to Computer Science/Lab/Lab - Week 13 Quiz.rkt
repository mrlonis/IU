;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 13 Quiz|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|

  A LoveLetter is one of
  - 'X
  - 'O

  ListOfLove is [ListOf LoveLetter]

|#

; merge : [X X -> Bool] [ListOf X] [ListOf X] -> [SortedListOf X]
; (merge rel? ls1 ls2) return the result of combining the list elements
; into a single sorted list

(define (merge rel? ls1 ls2)
  (cond
    [(and (empty? ls1)
          (empty? ls2))
     '()]
    [(empty? ls1) ls2]
    [(empty? ls2) ls1]
    [(rel? (first ls1) (first ls2))
     (cons (first ls1) (merge rel? (rest ls1) ls2))]
    [else (cons (first ls2) (merge rel? ls1 (rest ls2)))]))

(check-expect (merge < '() '()) '())
(check-expect (merge < '(1 2 3) '(4 5 6 7 8))
              (list 1 2 3 4 5 6 7 8))
(check-expect (merge <= '(1 1 3 3 5 5 7 7) '(0 0 2 2 4 4 6 6))
              (list 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7))
(check-expect (merge > '(9 8 7 3 2 1) '(13 12 11 10 6 5 4))
              (list 13 12 11 10 9 8 7 6 5 4 3 2 1))
(check-expect (merge string<? '("cat" "dog" "pig") '("bat" "cow" "rat"))
              (list "bat" "cat" "cow" "dog" "pig" "rat"))

; group-sorted-sequences :
; [X X -> Bool] [ListOf X] -> [ListOf [SortedListOf X]]
; (group-sorted-sequences rel? ls) returns the list with each sorted
; sequence grouped in a sublist

(define (group-sorted-sequences rel? ls)
  (cond
    [(empty? ls) '()]
    [(empty? (rest ls)) (list ls)]
    [else (local [(define ans (group-sorted-sequences rel? (rest ls)))]
            (cond
              [(rel? (first ls) (second ls))
               (cons (cons (first ls) (first ans)) (rest ans))]
              [else (cons (list (first ls)) ans)]))]))

(check-expect (group-sorted-sequences > '()) '())
(check-expect (group-sorted-sequences < '(1 2 3))
              (list (list 1 2 3)))
(check-expect (group-sorted-sequences >= '(2 2 2 2))
              (list (list 2 2 2 2)))
(check-expect (group-sorted-sequences < '(5 4 3 2 1))
              (list (list 5) (list 4) (list 3) (list 2) (list 1)))
(check-expect
 (group-sorted-sequences < '(1 2 3 4 2 3 4 5 6 1 2 9 8 7))
 (list (list 1 2 3 4) (list 2 3 4 5 6) (list 1 2 9) (list 8) (list 7)))

; merge-adjacent-sequences :
; [X X -> Bool] [ListOf [SortedListOf X]] -> [SortedListOf X]
; (merge-adjacent-sequences rel? ls) returns the list after merging
; adjacent lists together

(define (merge-adjacent-sequences rel? ls)
  (cond
    [(empty? ls) ls]
    [(empty? (rest ls)) ls]
    [else (cons (merge rel? (first ls) (second ls))
                (merge-adjacent-sequences rel? (rest (rest ls))))]))

(check-expect (merge-adjacent-sequences < '()) '())
(check-expect (merge-adjacent-sequences < '((1 2))) (list (list 1 2)))
(check-expect (merge-adjacent-sequences < '((2 5) (4 7 8) (3 7) (6)))
              (list (list 2 4 5 7 8) (list 3 6 7)))
(check-expect
 (merge-adjacent-sequences < '((2 5) (4 7 8) (3 7) (6) (0 1)))
 (list (list 2 4 5 7 8) (list 3 6 7) (list 0 1)))
(check-expect
 (merge-adjacent-sequences
  <
  (group-sorted-sequences < '(1 2 3 4 2 3 4 5 6 1 2 9 8 7)))
 (list (list 1 2 2 3 3 4 4 5 6) (list 1 2 8 9) (list 7)))

; mergesort : [X X -> Bool] [ListOf X] -> [SortedListOf X]
; (mergesort rel? ls) returns the result of sorting the elements in ls
; according to rel? using the Merge Sort algorithm

(define (mergesort rel? ls)
  (cond
    [(empty? ls) '()]
    [else (local
            [; help : [ListOf [ListOf X]] -> [SortedListOf X]
             (define (help ls)
               (cond
                 [(empty? (rest ls)) (first ls)]
                 [else (help (merge-adjacent-sequences rel? ls))]))]
            (help (group-sorted-sequences rel? ls)))]))

(check-expect (mergesort > '()) '())
(check-expect (mergesort > '(42)) (list 42))
(check-expect
 (mergesort string<? '("cow" "ant" "boa" "bat" "dog" "rat" "sow" "pig"))
 (list "ant" "bat" "boa" "cow" "dog" "pig" "rat" "sow"))
(check-expect (mergesort > '(1 2 3 4 5 6 7 8)) (list 8 7 6 5 4 3 2 1))
(check-expect (mergesort < '(8 7 6 5 4 3 2 1)) (list 1 2 3 4 5 6 7 8))
(check-expect
 (mergesort < '(-3 9 5 1 -4 15 -7 25 29 33 6 8 2 9 4 -3 9 10 29 55))
 (list -7 -4 -3 -3 1 2 4 5 6 8 9 9 9 10 15 25 29 29 33 55))

; sort-lol : ListOfLove -> ListOfLove
; (sort-lol ls) returns ls sorted by x before o's

#|
(define (sort-lol ls)
  (local [; rel? : LoveLetter LoveLetter -> Bool
          (define (rel? x y)
            (and (equal? x 'X)
                 (equal? y 'O)))]
    (mergesort rel? ls)))
|#

(define (sort-lol ls)
  (mergesort
   (; LoveLetter LoveLetter -> Bool
    lambda (x y)
     (and (equal? x 'X)
          (equal? y 'O))) ls))

(check-expect (sort-lol '(X X O O X X O)) '(X X X X O O O))