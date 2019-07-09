;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a10")
(define collaboration-statement "Iworked alone.")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

; join-together : [ListOf X] [ListOf X] -> [ListOf X]
; (join-together ls1 ls2) returns the list consisting of all top-level
; elements of ls1 followed by the top-level elements of ls2

(define (join-together ls1 ls2)
  (local [; help : [ListOf X] -> [ListOf X]
          ; (help ls) drops the invariant argument ls2
          (define (help ls)
            (cond
              [(empty? ls) ls2]
              [else (cons (first ls) (help (rest ls)))]))]
    (help ls1)))

(check-expect (join-together '(a b c) '(d e f g h))
              (list 'a 'b 'c 'd 'e 'f 'g 'h))
(check-expect (join-together '() '(7 2 0 1 8 3 4))
              (list 7 2 0 1 8 3 4))
(check-expect (join-together (list 1 2) '()) (list 1 2))
(check-expect (join-together '() '(a b c d e f)) '(a b c d e f))
(check-expect (join-together '(a)  '(b c d e f)) '(a b c d e f))
(check-expect (join-together '(a b)  '(c d e f)) '(a b c d e f))
(check-expect (join-together '(a b c ) '(d e f)) '(a b c d e f))
(check-expect (join-together '(a b c d)  '(e f)) '(a b c d e f))
(check-expect (join-together '(a b c d e)  '(f)) '(a b c d e f))
(check-expect (join-together '(a b c d e f) '()) '(a b c d e f))

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;;;;; 2a

; flatten/v1 : [ListOf [ListOf X]] -> [ListOf X]
; (flatten/v1 lls) returns the result of joining together all lists
; within lls into a single list

(define (flatten/v1 lls)
  (cond
    [(empty? lls) '()]
    [else (join-together (first lls)
                         (flatten/v1 (rest lls)))]))

(check-expect (flatten/v1 '()) '())
(check-expect
 (flatten/v1 '((a a a a) (b b) (c c c c c c) () (d) (e e e)))
 (list 'a 'a 'a 'a 'b 'b 'c 'c 'c 'c 'c 'c 'd 'e 'e 'e))

; flatten/v2 : [ListOf [ListOf X]] -> [ListOf X]
; (flatten/v2 lls) returns the result of joining together all lists
; within lls into a single list

(define (flatten/v2 lls)
  (cond
    [(empty? lls) '()]
    [(empty? (rest lls)) (first lls)]
    [else (flatten/v2 (cons (join-together (first lls) (second lls))
                            (rest (rest lls))))]))

(check-expect (flatten/v2 '()) '())
(check-expect
 (flatten/v2 '((a a a a) (b b) (c c c c c c) () (d) (e e e)))
 (list 'a 'a 'a 'a 'b 'b 'c 'c 'c 'c 'c 'c 'd 'e 'e 'e))

;;;;; 2b

#|
(flatten/v1 '((a b c) (d e) (f g h i)))
== (join-together '(a b c) (flatten/v1 '((d e) (f g h i))))
== (join-together '(a b c) (join-together '(d e)
                                          (flatten/v1 '(f g h i))))
== (join-together '(a b c)
                  (join-together '(d e)
                                 (join-together '(f g h i)
                                                (flatten/v1 '()))))
== (join-together '(a b c)
                  (join-together '(d e)
                                 (join-together '(f g h i) '())))
== (join-together '(a b c)
                  (join-together '(d e) '(f g h i)))
== (join-together '(a b c) '(d e f g h i))
== '(a b c d e f g h i)
|#

;;;;; 2c

#|
(flatten/v2 '((a b c) (d e) (f g h i)))
== (flatten/v2 (cons (join-together '(a b c) '(d e)) '((f g h i))))
== (flatten/v2 (cons '(a b c d e) '((f g h i))))
== (flatten/v2 '((a b c d e) (f g h i)))
== (flatten/v2 (cons (join-together '(a b c d e) '(f g h i)) '()))
== (flatten/v2 (cons '(a b c d e f g h i) '()))
== (flatten/v2 '((a b c d e f g h i)))
== '(a b c d e f g h i)
|#

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; (ignore x) : X -> Bool
; (ignore x) returns #true

(define (ignore x) #true)

(check-expect (ignore 3) #true)

;;;;; 3a

(define ls1 (make-list 20 (make-list 3 'a)))
(define ls2 (make-list 50 (make-list 3 'a)))
(define ls3 (make-list 100 (make-list 3 'a)))
(define ls4 (make-list 200 (make-list 3 'a)))
(define ls5 (make-list 300 (make-list 3 'a)))
(define ls6 (make-list 400 (make-list 3 'a)))
(define ls7 (make-list 500 (make-list 3 'a)))
(define ls8 (make-list 1000 (make-list 3 'a)))
(define ls9 (make-list 2000 (make-list 3 'a)))
(define ls10 (make-list 3000 (make-list 3 'a)))

#|
  n | flatten/v1 | flatten/v2
20       0            0
50       0            16
100      0            16  
200      0            78
300      0            156
400      0            282
500      0            485
1000     16           1844
2000     15           6453
3000     31           14469

Using Windows 10 with 32 bit DrRacket
|#

;;;;; 3b

(define flatten flatten/v1)

;;;;; 3c

#|

flatten/v1 is a lot faster than flatten/v2 as shown in the table above.
The reason for this is because flatten/v2 is running to empty? checks.
One on lls and one on (rest lls). This causes for a very cpu intensive
loop and a rather unneccessary step. Flatten/v1 only checks for
(empty? lls). The reason flatten/v1 can het away with this single check
is in the way it implements its use of (join-together ..). Instead of
making a (cons (join-together (first lls) (second lls))) [This is what
calls for checking if (rest lls) is empty in flatten/v2] flatten/v1
does (join-together (first lls) (flatten/v1 (rest lls)))])). This
allows it to only check for (empty? lls) since it isnt using the
(second lls) like flatten/v2 does.

|#

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; list-to-string : [ListOf X] -> [StringOf X]
; (list-to-string ls) returns a list into a string to be used in the
; error messages

(define (list-to-string ls)
  (local
    [; symbol-or-number? : [ListOf X] -> [StringOf X]
     ; (symbol-or-number? item) returns the function need to be used in
     ; (string-append whether the first item in the list is either a
     ; symbol or a number
     (define (symbol-or-number? item)
       (cond
         [(symbol? (first ls)) (symbol->string (first ls))]
         [(number? (first ls)) (number->string (first ls))]
         [else (first ls)]))]
    (cond
      [(and (= 1 (length ls))
            (not (list? (first ls)))) (symbol-or-number? ls)]
      [(not (= 1 (length ls)))
       (string-append (symbol-or-number? ls)
                      " "
                      (list-to-string (rest ls)))]
      [else (error "list-to-string: See Problem 4")])))

(check-expect (list-to-string '(a b c)) "a b c")
(check-expect (list-to-string '(1 2 3)) "1 2 3")
(check-expect (list-to-string (list "x" "y" "z")) "x y z")
(check-error (list-to-string (list (list 1 2 3)))
             "list-to-string: See Problem 4")

; list-head -> Nat [ListOf X] -> [ListOf X]
; (list-head n ls) returns the first n elements of ls

(define (list-head n ls)
  (cond
    [(= n 0) '()]
    [(> n (length ls))
     (error
      (string-append "list-head: "
                     (number->string n) " is too large for ("
                     (list-to-string ls)
                     ")"))]
    [else (cons (first ls)
                (list-head (sub1 n) (rest ls)))]))

(check-error
 (list-head 5 '(a b c)) "list-head: 5 is too large for (a b c)")
(check-expect (list-head 2 (list 1 2 3)) (list 1 2))

; list-tail -> Nat [ListOf X] -> [ListOf X]
; (list-tail n ls) returns ls with the first n elements missing

(define (list-tail n ls)
  (cond
    [(= n 0) ls]
    [(> n (length ls))
     (error
      (string-append "list-tail: "
                     (number->string n) " is too large for ("
                     (list-to-string ls)
                     ")"))]
    [else (list-tail (sub1 n) (rest ls))]))

(check-error
 (list-tail 5 '(a b c)) "list-tail: 5 is too large for (a b c)")
(check-expect (list-tail 2 (list 1 2 3)) (list 3))

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; pop-up : Nat [ListOf Y] -> [ListOf [ListOf Y]]
; (pop-up n ls)  returns the result of grouping runs of length n in ls
; into sublists

(define (pop-up n ls)
  (cond
    [(empty? ls) '()]
    [else (cons (list-head n ls) (pop-up n (list-tail n ls)))]))

(check-expect
 (pop-up 2 '(a b c d e f g h))
 (list (list 'a 'b) (list 'c 'd) (list 'e 'f) (list 'g 'h)))
(check-expect
 (pop-up 3 '(a b c d e f))
 (list (list 'a 'b 'c) (list 'd 'e 'f)))
(check-expect
 (pop-up 5 (make-list 20 0))
 (list (list 0 0 0 0 0) (list 0 0 0 0 0) (list 0 0 0 0 0)
       (list 0 0 0 0 0)))

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

; overwrite/slow : [ListOf X] Nat X -> [ListOf X]
; (overwrite/slow ls i x) returns the list that results from
; replacing the element at index i in ls with x.

(define (overwrite/slow ls i x)
  (join-together (list-head i ls)
                 (join-together (list x) (list-tail (add1 i) ls))))

(check-expect (overwrite/slow '(a) 0 'b) '(b))
(check-expect (overwrite/slow '(a b c) 0 '_) '(_ b c))
(check-expect (overwrite/slow '(a b c) 1 '_) '(a _ c))
(check-expect (overwrite/slow '(a b c) 2 '_) '(a b _))
(check-expect (overwrite/slow '(x x x _ x x x x) 3 'x) (make-list 8 'x))

;;;;; 6a

; overwrite -> [ListOf X] Nat X -> [ListOf X]
; (overwrite ls i x) returns the list that results from
; replacing the element at index i in ls with x

(define (overwrite ls i x)
  (local [; help : [ListOf X] Nat X -> [ListOf X]
          ; (help ls i x) returns the list that results from replacing
          ; the element at index i in ls with x
          (define (help ls i x)
            (cond
              [(or (>= i (length ls))
                   (negative? i))
               (error (string-append "overwrite: " (number->string i)
                                     " is too large for ("
                                     (list-to-string ls) ")"))]
              [else (append (list-head i ls)
                            (list x)
                            (list-tail (add1 i) ls))]))]
    (help ls i x)))

(check-expect (overwrite '(a b c) 1 '_)
              (list 'a '_ 'c))
(check-error (overwrite '(5 4 3 2 1) 5 6)
             "overwrite: 5 is too large for (5 4 3 2 1)")
(check-error (overwrite '(5 4 3 2 1) -3 6)
             "overwrite: -3 is too large for (5 4 3 2 1)")
(check-error (overwrite '(a b c d e f) -3 6)
             "overwrite: -3 is too large for (a b c d e f)")

;;;;; 6b

#|
  n | overwrite/slow | overwrite
10000     296              297 
20000     1172             1000
30000     2579             2500
40000     4579             4437
50000     7235             6703
100000    27656            28156
200000     
300000      
400000      
500000

Using Windows 10 with 32 bit DrRacket
|#

#|

In general overwrite is faster than overwrite/slow. This is due to two
things. First, overwrite uses append instead of two join-together
functions which dramatically speeds up cpu time and removes the weasel
function. Second, overwrite checks for error in the input before
jumping into the code which prevents the code from returning an error
which in turn speeds up the process. If bad input is given the
overwrite simply needs to process the first check and return the error
whereas overwrite/slow has to process the entire join-together bulk
until it realizes that the code isnt valid

|#

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;; The Model ;;
;;;;;;;;;;;;;;;

;;;;; 7a

#|
  A TileValue is one of
  - '_
  - '2
  - '4
  - '8
  - '16
  - '32
  - '64
  - '128
  - '256
  - '512
  - '1024
  - '2048
|#

;;;;; 7ai

(define BLANK '_)

;;;;; 7aii

; blank? : X -> Bool
; (blank? tile) returns #true if and only if the title is blank

(define (blank? tile)
  (equal? BLANK tile))

(check-expect (blank? BLANK) #true)
(check-expect (blank? 2048) #false)
(check-expect (blank? blank?) #false)

;;;;; 7b

#|
  A Board is a [ListOf [ListOf TileValue]]
|#

(define b1
  (list (list 64 32)
        (list 16 16)))

(define b2
  (list (list 2 2 2 2)
        (list 4 '_ 4 '_)
        (list '_ 8 8 8)
        (list 16 '_ '_ 16)))

(define b3
  (list (list 16 64 8 256 4)
        (list 1024 1024 1024 32 128)
        (list 64 32 128 '_ '_)
        (list 4 4 32 '_ '_)
        (list 2 '_ '_ 512 '_)))

;;;;; 7c

; board-full? : X -> Bool
; (board-full? board)  returns #true if the board has no blank tiles,
; and #false otherwise

(define (board-full? board)
  (= (length (filter blank? (flatten board))) 0))

(check-expect (board-full? '((4))) #true)
(check-expect (board-full? b1) #true)
(check-expect (board-full? b2) #false)

;;;;; 7d

; add-new-tile : X -> X
; (add-new-tile board) takes a board and attempts to replace one of the
; blank tiles with a new tile. The blank is selected at random and with
; equal probability. The new tile has value either 2 or 4. A 2 value is
; chosen 80% of the time. In the case that the board is full, it is
; returned unchanged

(define (add-new-tile board)
  (local [(define flatten-board (flatten board))
          (define list-random (random (length flatten-board)))
          ; new-tile-number : Nat -> Nat
          ; (new-tile-number n) returns a number, either 2 or 4, with 2
          ; having an 80% chance of being returned
          (define (new-tile-number n)
            (cond
              [(= (sub1 n) (random n)) 4]
              [else 2]))]
    (cond
      [(board-full? board) board]
      [(blank? (list-ref flatten-board list-random))
       (pop-up (length (first board))
               (overwrite flatten-board
                          list-random
                          (new-tile-number 5)))]
      [else (add-new-tile board)])))

(check-expect (add-new-tile '((4))) (list (list 4)))
(check-expect (add-new-tile b1) (list (list 64 32) (list 16 16)))
(check-random (add-new-tile b2) (add-new-tile b2))
(check-random (add-new-tile b3) (add-new-tile b3))

;;;;; 7e

;;;;; 7ei

; iterate : Nat [Any -> Any] Any -> Any
; (iterate f n x) returns the result of applying f n times
; strating with x

(define (iterate f n x)
  (cond
    [(zero? n) x]
    [else (iterate f (sub1 n) (f x))]))

(check-expect (iterate add1 3 4) 7)
(check-expect (iterate rest 4 '(a b c d e f g)) (list 'e 'f 'g))

; half : Nat -> Num
; (half x) returns the value of x divided by 2

(define (half x) (quotient x 2))

(check-expect (half 2) 1)
(check-expect (half 4) 2)

(check-expect (iterate half 1 8) 4)
(check-expect (iterate half 5 32) 1)

;;;;; 7eii

#|

This is an example of tail-recursive function because each recursive
call has no completion step and is instead just defining iterate with
different variables to be used.

|#

;;;;; 7eiii

; make-board : Nat Nat -> Board
; (make-board n m) returns an nxn board with m non-blank tiles

(define (make-board n m)
  (iterate add-new-tile
           m
           (pop-up n (make-list (* n n) '_))))

(check-expect (make-board 1 0) (list (list '_)))
(check-random (make-board 3 5) (make-board 3 5))
(check-expect (board-full? (make-board 3 5)) #false)
(check-random (make-board 7 25) (make-board 7 25))
(check-expect (board-full? (make-board 7 25)) #false)
(check-expect (board-full? (make-board 3 9)) #true)

;;;;; 7f

; board-square? : Board -> Boolean
; (board-square? board) returns #true iff the board is a nxn board

(define (board-square? board)
  (if (equal? board '())
      #false
      (= (foldr min (length board) (map length board))
         (foldr max (length board) (map length board)))))

(check-expect (board-square? '()) #false)
(check-expect (board-square? b3) #true)
(check-expect (board-square? (make-board 123 0)) #true)
(check-expect (board-square? '((2 4) (8 16 32))) #false)
(check-expect (board-square? '((2 2 2 2) (4 4 4 4) (2 2 2) (4 4 4 4)))
              #false)

;;;;; 7g

; game-won? : [ListOf [ListOf X]] -> Bool
; (game-won? board) returns #true if the board contains a 2048 tile,
; and #false otherwise

(define (game-won? board)
  (member? 2048 (flatten board)))

(check-expect
 (game-won?
  (list (list 2 2 2) (list 2 2048 2) (list BLANK BLANK BLANK)))
 #true)
(check-expect (game-won? b3) #false)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;
;; The View ;;
;;;;;;;;;;;;;;

;;;;; 8a

(define TILE-SIZE 50)
(define FONT-SIZE (half TILE-SIZE))
(define GRID-SPACING 5)
(define GRID-COLOR (make-color 186 172 160))

;;;;; 8b

; tile->image : TileValue Nat Color Color -> Image
; (tile->image tile-value font-size foreground background) takes a
; TileValue, a font size, a foreground color, and a background color,
; and produces an image of the tile with the given properties

(define (tile->image tile-value font-size foreground background)
  (if (number? tile-value)
      (overlay (text/font (number->string tile-value)
                          font-size
                          foreground
                          #f
                          'default
                          'normal
                          'normal
                          #f)
               (square (- TILE-SIZE GRID-SPACING) "solid" background)
               (square TILE-SIZE "solid" GRID-COLOR))
      (overlay (square (- TILE-SIZE GRID-SPACING) "solid" background)
               (square TILE-SIZE "solid" GRID-COLOR))))

(check-satisfied
 (tile->image BLANK FONT-SIZE
              (make-color 105 105 105) (make-color 204 192 179)) image?)
(check-satisfied
 (tile->image 64 FONT-SIZE
              (make-color 255 255 255) (make-color 246 94 59)) image?)
(check-expect
 (image-width
  (tile->image 64 FONT-SIZE
               (make-color 255 255 255) (make-color 246 94 59)))
 TILE-SIZE)
(check-satisfied
 (tile->image 2048 (- FONT-SIZE 8)
              (make-color 255 255 255) (make-color 237 194 46)) image?)

;;;;; 8c

; val->image : TileValue -> Img
; takes a TileValue and produces the corresponding image, using the
; game sizes and colors

(define (val->image tile-value)
  (cond
    [(equal? tile-value BLANK)
     (tile->image BLANK FONT-SIZE
                  (make-color 105 105 105) (make-color 204 192 179))]
    [(= tile-value 2)
     (tile->image 2 FONT-SIZE
                  (make-color 105 105 105) (make-color 238 228 218))]
    [(= tile-value 4)
     (tile->image 4 FONT-SIZE
                  (make-color 105 105 105) (make-color 237 224 200))]
    [(= tile-value 8)
     (tile->image 8 FONT-SIZE
                  (make-color 255 255 255) (make-color 242 177 121))]
    [(= tile-value 16)
     (tile->image 16 FONT-SIZE
                  (make-color 255 255 255) (make-color 245 149 99))]
    [(= tile-value 32)
     (tile->image 32 FONT-SIZE
                  (make-color 255 255 255) (make-color 246 124 95))]
    [(= tile-value 64)
     (tile->image 64 FONT-SIZE
                  (make-color 255 255 255) (make-color 246 94 59))]
    [(= tile-value 128)
     (tile->image 128 (- FONT-SIZE 4)
                  (make-color 255 255 255) (make-color 237 207 114))]
    [(= tile-value 256)
     (tile->image 256 (- FONT-SIZE 4)
                  (make-color 255 255 255) (make-color 237 204 97))]
    [(= tile-value 512)
     (tile->image 512 (- FONT-SIZE 4)
                  (make-color 255 255 255) (make-color 237 200 80))]
    [(= tile-value 1024)
     (tile->image 1024 (- FONT-SIZE 8)
                  (make-color 255 255 255) (make-color 237 197 63))]
    [(= tile-value 2048)
     (tile->image 2048 (- FONT-SIZE 8)
                  (make-color 255 255 255) (make-color 237 194 46))]
    [else (error (string-append "val->image: unknown tile value "
                                (number->string tile-value)))]))

(check-satisfied (val->image BLANK) image?)
(check-satisfied (val->image 2) image?)
(check-satisfied (val->image 4) image?)
(check-satisfied (val->image 8) image?)
(check-satisfied (val->image 16) image?)
(check-satisfied (val->image 32) image?)
(check-satisfied (val->image 64) image?)
(check-satisfied (val->image 128) image?)
(check-satisfied (val->image 256) image?)
(check-satisfied (val->image 512) image?)
(check-satisfied (val->image 1024) image?)
(check-satisfied (val->image 2048) image?)
(check-error (val->image 255) "val->image: unknown tile value 255")

;;;;; 8d

; board->image : Board -> Image
; (board->image board) returns the corresponding image of a board

(define (board->image board)
  (local [(define (list-image list)
            (cond
              [(empty? list) empty-image]
              [else (beside (first list)
                            (list-image (rest list)))]))]
    (foldr above
           empty-image
           (map list-image
                (pop-up (length (first board))
                        (map val->image (flatten board)))))))

(check-satisfied
 (board->image (list (list BLANK 2 4 8)
                     (list 16 BLANK 32 64)
                     (list 128 256 BLANK 512)
                     (list BLANK 1024 2048 BLANK)))
 image?)
(check-expect
 (image-width
  (board->image (list (list BLANK 2 4 8)
                      (list 16 BLANK 32 64)
                      (list 128 256 BLANK 512)
                      (list BLANK 1024 2048 BLANK))))
 200)
(check-expect
 (image-height
  (board->image (list (list BLANK 2 4 8)
                      (list 16 BLANK 32 64)
                      (list 128 256 BLANK 512)
                      (list BLANK 1024 2048 BLANK))))
 200)