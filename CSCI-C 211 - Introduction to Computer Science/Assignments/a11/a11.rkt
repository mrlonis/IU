;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname a11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a11")
(define collaboration-statement "I worked alone")

; join-together : [ListOf X] [ListOf X] -> [ListOf X]
; (join-together ls1 ls2) returns a list consisting of the top-level
; elements of ls1 followed by the top-level elements of ls2

(define (join-together ls1 ls2)
  (local 
    [; help : [ListOf X] -> [ListOf X]
     ; (help ls1) drops the invariant argument ls2
     
     (define (help ls1)
       (cond
         [(empty? ls1) ls2]
         [else (cons (first ls1) 
                     (help (rest ls1)))]))]
    
    (help ls1)))

(check-expect (join-together '() '(a b c d e f)) '(a b c d e f))
(check-expect (join-together '(a)  '(b c d e f)) '(a b c d e f))
(check-expect (join-together '(a b)  '(c d e f)) '(a b c d e f))
(check-expect (join-together '(a b c ) '(d e f)) '(a b c d e f))
(check-expect (join-together '(a b c d)  '(e f)) '(a b c d e f))
(check-expect (join-together '(a b c d e)  '(f)) '(a b c d e f))
(check-expect (join-together '(a b c d e f) '()) '(a b c d e f))

; flatten/v1 : [ListOf [ListOf X]] -> [ListOf X]
; (flatten/v1 lls) returns the result of appending together all the
; sublists in lls

(define (flatten/v1 lls)
  (cond
    [(empty? lls) '()]
    [else (join-together (first lls)
                         (flatten/v1 (rest lls)))]))

; flatten : [ListOf [ListOf X]] -> [ListOf X]
; (flatten lls) returns the result of appending together all the
; sublists in lls

(define flatten flatten/v1)

(check-expect (flatten '((a) (b) (c) (d) (e) (f)))
              '(a b c d e f))
(check-expect (flatten '((a b) (c d) (e f) (g h) (i j)))
              '(a b c d e f g h i j))
(check-expect (flatten '(() () () () () () ())) '())
(check-expect (flatten '(() (a) (b c) (d e f) (g h i j)))
              '(a b c d e f g h i j))

; list-head : Nat [ListOf X] -> [ListOf X]
; (list-head n ls) returns the first n elements of ls,
; signaling an error if n is too large for ls

(define (list-head init-n init-ls)
  (local 
    [; help : Nat [ListOf X] -> [ListOf X]
     ; (help n ls) runs the recursion on n and ls, preserving
     ; the initial values for the error message
     (define (help n ls)
       (cond
         [(zero? n) '()]
         [(empty? ls) 
          (error 'list-head 
                 (format "~s is too large for ~s" 
                         init-n init-ls))]
         [else 
          (cons (first ls)
                (help (sub1 n) (rest ls)))]))]
    (help init-n init-ls)))

(check-expect (list-head 0 '(a b c)) '())
(check-expect (list-head 1 '(a b c)) '(a))
(check-expect (list-head 2 '(a b c)) '(a b))
(check-expect (list-head 3 '(a b c)) '(a b c))
(check-error (list-head 4 '(a b c)) 
             "list-head: 4 is too large for (a b c)")

; list-tail : Nat [ListOf X] -> [ListOf X]
; (list-tail n ls) returns the result applying rest to ls n times

(define (list-tail init-n init-ls)
  (local 
    [; help : Nat [ListOf X] -> [ListOf X]
     ; (help n ls) runs the recursion on n and ls, preserving
     ; the initial values for the error message
     (define (help n ls)
       (cond
         [(zero? n) ls]
         [(empty? ls) 
          (error 'list-tail 
                 (format "~s is too large for ~s"
                         init-n init-ls))]
         [else 
          (help (sub1 n) (rest ls))]))]
    (help init-n init-ls)))

(check-expect (list-tail 0 '(a b c)) '(a b c))
(check-expect (list-tail 1 '(a b c)) '(b c))
(check-expect (list-tail 2 '(a b c)) '(c))
(check-expect (list-tail 3 '(a b c)) '())
(check-error (list-tail 4 '(a b c)) 
             "list-tail: 4 is too large for (a b c)")

#|
  A PosInt is an Int in [1..infinity)
|#

; pop-up : PosInt [ListOf X] -> [ListOf [ListOf X]]
; (pop-up n ls) returns the result of grouping the elements of ls
; into sublists of size n, assuming n divides the length of ls

(define (pop-up n ls)
  (local
    [; help : [ListOf X] -> [ListOf [ListOf X]]
     ; help drop the invariant argument n
     (define (help ls)
       (cond
         [(empty? ls) '()]
         [else (cons (list-head n ls)
                     (help (list-tail n ls)))]))]
    (help ls)))

(check-expect (pop-up 1 '(a b c d e f g))
              '((a) (b) (c) (d) (e) (f) (g)))
(check-expect (pop-up 2 '(a b c d e f g h))
              '((a b) (c d) (e f) (g h)))
(check-expect (pop-up 3 '(a b c d e f g h i))
              '((a b c) (d e f) (g h i)))
(check-expect (pop-up 4 '(a b c d e f g h))
              '((a b c d) (e f g h)))
(check-expect (pop-up 5 '(a b c d e))
              '((a b c d e)))

; overwrite : [ListOf X] Nat X -> [ListOf X]
; (overwrite ls i x) returns the result of replacing the i-th
; element of ls with x, signaling an error if n is out of
; bounds for ls

(define (overwrite orig-ls orig-i x)
  (local
    [; help : [ListOf X] Nat -> [ListOf X]
     ; help drops the invariant argument x and preserves
     ; the initial values for the error message
     (define (help ls i)
       (cond
         [(empty? ls) (error 'overwrite
                             (format "~s is out of bounds for ~s"
                                     orig-i orig-ls))]
         [(zero? i) (cons x (rest ls))]
         [else 
          (cons (first ls)
                (help (rest ls) (sub1 i)))]))]
    (help orig-ls orig-i)))

(check-expect (overwrite '(a) 0 'b) '(b))
(check-expect (overwrite '(a b c) 0 '_) '(_ b c))
(check-expect (overwrite '(a b c) 1 '_) '(a _ c))
(check-expect (overwrite '(a b c) 2 '_) '(a b _))
(check-expect (overwrite '(x x x _ x x x x) 3 'x) (make-list 8 'x))
(check-error (overwrite '(a b c) 4 'd) 
             "overwrite: 4 is out of bounds for (a b c)")
(check-error (overwrite '(a b c) -3 'd) 
             "overwrite: -3 is out of bounds for (a b c)")

;;;;;;;;;;;;;;
;; The Model
;;;;;;;;;;;;;;

#|
   A PowerOfTwo is one of
   - 1
   - (* 2 PowerOfTwo)

   A TileValue is one of
   - '_
   - a PowerOfTwo in [2..2048]
 
   A Row is one of
   - (cons TileValue '())
   - (cons TileValue Row)

   A Board is one of
   - (cons Row '())
   - (cons Row Board)
|#

; We represent the blank with '_

(define BLANK '_)

(check-expect BLANK '_)

; blank? : X -> Bool
; (blank? x) returns #true iff x is the blank space

(define (blank? x)
  (equal? x BLANK))

(check-satisfied BLANK blank?)
(check-expect (blank? " ") #false)
(check-expect (blank? 'blank) #false)

; Three sample boards

(define b1 '((64 32) (16 16)))

(define b2
  (list
   (list 2 2 2 2)
   (list 4 '_ 4 '_)
   (list '_ 8 8 8)
   (list 16 '_ '_ 16)))

(define b3
  (list
   (list 16 64 8 256 4)
   (list 1024 1024 1024 32 128)
   (list 64 32 128 '_ '_)
   (list 4 4 32'_ '_)
   (list 2 '_ '_ 512 '_)))

; board-full? : Board -> Bool
; (board-full? board) returns #true iff board contains no
; blank tiles 

(define (board-full? board)
  (empty? (filter blank? (flatten board))))

(check-expect (board-full? '((4))) #true)
(check-expect (board-full? b1) #true)
(check-expect (board-full? b2) #false)

; add-new-tile : Board -> Board
; (add-new-tile board) returns the board with one of the existing blank
; tiles replaced by either a 2 or a 4. The blank tile to replace is
; selected at random and with equal probability. A 2 replaces the blank
; tile 80% of the time. If there's no room on the board for a new tile,
; the board is returned unchanged.

(define (add-new-tile board)
  (if (board-full? board)
      board
      (local 
        [(define n (length (first board)))
         (define flat-board (flatten board))
         (define num-tiles (* n n))
         (define new-tile-val (if (zero? (random 5)) 4 2))
         ; try : Nat -> Nat
         ; (try i) returns i if the element at index i in flat-board
         ; is a blank, otherwise it tries a new random index
         (define (try i)
           (if (blank? (list-ref flat-board i))
               i
               (try (random num-tiles))))]
        (pop-up n (overwrite flat-board 
                             (try (random num-tiles))
                             new-tile-val)))))

(check-expect (add-new-tile '((4))) (list (list 4)))
(check-expect (add-new-tile b1) (list (list 64 32) (list 16 16)))
(check-random (add-new-tile b2) (add-new-tile b2))
(check-random (add-new-tile b3) (add-new-tile b3))

; iterate : [X -> X] Nat X -> X
; (iterate f n x) returns the result of applying f n times, starting
; with x, and then cycling resulting values through f, 
; i.e., (f (f (... (f x))))

(define (iterate f n x)
  (local
    [; help : Nat X -> X
     ; (help n x) drops the invariant argument f
     (define (help n x)
       (cond
         [(zero? n) x]
         [else (help (sub1 n) (f x))]))]
    (help n x)))

(check-expect (iterate add1 0 "no problem") "no problem")
(check-expect (iterate string-length 1 "hello") 5)
(check-expect (iterate not 17 #true) #false)
(check-expect (iterate add1 5 2) (add1 (add1 (add1 (add1 (add1 2))))))
(check-expect (iterate rest 3 '(a b c d e f g))
              '(d e f g))
(check-expect (iterate sqr 4 2) (sqr (sqr (sqr (sqr 2)))))

; make-board : PosInt Nat -> Board
; (make-board n) returns a new nxn board with m initial
; non-blank tiles

(define (make-board n m)
  (iterate add-new-tile 
           m
           (make-list n (make-list n BLANK))))

(check-expect (length (flatten (make-board 10 40))) (* 10 10))
(check-expect (length (filter blank?
                              (flatten (make-board 10 40))))
              (- (* 10 10) 40))

; game-won? : Board -> Bool
; (game-won? board) returns #true iff board contains a 2048 tile

(define (game-won? board)
  (member? 2048 (flatten board)))

(check-expect
 (game-won?
  (list (list 2 2 2) (list 2 2048 2) (list BLANK BLANK BLANK)))
 #true)
(check-expect (game-won? b3) #false)

;;;;;;;;;;;;;;
;; The View
;;;;;;;;;;;;;;

(define TILE-SIZE 120)
(define FONT-SIZE (quotient TILE-SIZE 2))

(define GRID-SPACING (quotient TILE-SIZE 20)) 
(define GRID-COLOR (color 186 172 160))

#|
  A RGB is an integer in the range [0..255]

  A Color is one of
  - Symbol
  - String
  - (make-color RGB RGB RGB)

  A Tile is a (make-tile TileValue Nat Color Color)
|#

(define-struct tile [val font fg bg])

(define the-tiles
  (list 
   ;;         Tile    Font         Foreground      Background
   ;;         Value   Size         Color           Color
   (make-tile BLANK   FONT-SIZE    'dimgray       (color 204 192 179))
   (make-tile    2    FONT-SIZE    'dimgray       (color 238 228 218))
   (make-tile    4    FONT-SIZE    'dimgray       (color 237 224 200))
   (make-tile    8    FONT-SIZE     'white        (color 242 177 121))
   (make-tile   16    FONT-SIZE     'white        (color 245 149  99))
   (make-tile   32    FONT-SIZE     'white        (color 246 124  95))
   (make-tile   64    FONT-SIZE     'white        (color 246  94  59))
   (make-tile  128 (- FONT-SIZE 4)  'white        (color 237 207 114))
   (make-tile  256 (- FONT-SIZE 4)  'white        (color 237 204  97))
   (make-tile  512 (- FONT-SIZE 4)  'white        (color 237 200  80))
   (make-tile 1024 (- FONT-SIZE 8)  'white        (color 237 197  63))
   (make-tile 2048 (- FONT-SIZE 8)  'white        (color 237 194  46))))

; tile->image : TileValue Nat Color Color -> Image
; (tile->image tile-val font-size foreground-color background-color) 
; returns the image corresponding to a tile with the given properties

(define (tile->image tile-val font-size 
                     foreground-color background-color)
  (local
    [(define back-image (overlay 
                         (square TILE-SIZE 'solid background-color)
                         (square (+ TILE-SIZE (* 2 GRID-SPACING))
                                 'solid GRID-COLOR)))]
    (if (blank? tile-val)
        back-image
        (overlay 
         (text (format "~s" tile-val) font-size foreground-color)
         back-image))))

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
 (+ TILE-SIZE (* 2 GRID-SPACING)))
(check-satisfied
 (tile->image 2048 (- FONT-SIZE 8)
              (make-color 255 255 255) (make-color 237 194 46)) image?)

; val->image : TileVal -> Image
; (val->image val) returns a square, properly colored, image labeled
; with val

(define (val->image val)
  (local
    [(define tile (val->tile val))]
    (tile->image (tile-val tile)
                 (tile-font tile)
                 (tile-fg tile)
                 (tile-bg tile))))

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
(check-error (val->image 255) "val->tile: unknown tile value 255")

; val->tile : TileValue -> Tile
; (val->tile val) returns the tile associated with val in the-tiles.
; (This is a utility function used by val->image.)

(define (val->tile val)
  (local 
    [; lookup : [ListOf Tile] -> Tile
     ; (lookup tiles) searches tiles for the one matching val
     (define (lookup tiles)
       (cond
         [(empty? tiles)
          (error 'val->tile
                 (format "unknown tile value ~s" val))]
         [(equal? val (tile-val (first tiles))) (first tiles)]
         [else
          (lookup (rest tiles))]))]
    (lookup the-tiles)))

(check-satisfied (val->tile 2048) tile?)
(check-expect (val->tile BLANK) (first the-tiles))
(check-expect (val->tile 2) (second the-tiles))
(check-expect (val->tile 4) (third the-tiles))
(check-expect (val->tile 8) (fourth the-tiles))
(check-error (val->tile 3) "val->tile: unknown tile value 3")

; board->image : Board -> Image
; (board->image board) returns an image corresponding to the given 
; board

(define (board->image board)
  (local 
    [(define n (length (first board)))
     (define back-image
       (square (+ (* n TILE-SIZE) (* 2 (add1 n) GRID-SPACING))
               'solid GRID-COLOR))]
    (overlay
     (local
       [; build-row-image : [ListOf Image] -> Image
        ; (build-row-image tile-images) returns the result of joining  
        ; all the tile-images for a single row into one image
        (define (build-row-image tile-images)
          (foldr beside empty-image tile-images))
        ; build-board-image : [ListOf Image] -> Image
        ; (build-board-image row-images) returns the result of stacking
        ; all the images in row-images into a column
        (define (build-board-image row-images)
          (foldr above empty-image row-images))]
       (build-board-image 
        (map build-row-image (board-map val->image board))))  
     back-image)))

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
 540)
(check-expect
 (image-height
  (board->image (list (list BLANK 2 4 8)
                      (list 16 BLANK 32 64)
                      (list 128 256 BLANK 512)
                      (list BLANK 1024 2048 BLANK))))
 540)

; board-map : [TileValue -> X] Board -> [ListOf [ListOf X]]
; (board-map fun board) returns the result of mapping fun over
; the board. (This is a utility function used by board->image.)

(define (board-map fun board)
  (local [(define n (length (first board)))]
    (pop-up n (map fun (flatten board)))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; a11 - Part II: 2048 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

; invert/v1 : [ListOf X] -> [ListOf X]
; (invert/v1 ls) returns the result of reversing the top-level
; elements of ls

(define (invert/v1 ls)
  (local [; help : [ListOf X] [ListOf X] -> [ListOf X]
          (define (help ls acc)
            (cond
              [(empty? ls) acc]
              [else (help (rest ls) (cons (first ls) acc))]))]
    (help ls '())))

; invert/v2 : [ListOf X] -> [ListOf X]
; (invert/v2 ls) returns the result of reversing the top-level
; elements of ls

(define (invert/v2 ls)
  (cond
    [(empty? ls) '()]
    [else (append (invert/v2 (rest ls)) (list (first ls)))]))

;;;;; 1a

#|

(invert/v1 '(a b c d e))
== (help '(a b c d e) '())
== (help (rest '(a b c d e)) (cons (first '(a b c d e)) '()))
== (help '(b c d e) (cons (first '(a b c d e)) '()))
== (help '(b c d e) (cons 'a '()))
== (help '(b c d e) '(a))
== (help (rest '(b c d e)) (cons (first '(b c d e)) '(a)))
== (help '(c d e) (cons (first '(b c d e)) '(a)))
== (help '(c d e) (cons 'b '(a)))
== (help '(c d e) '(b a))
== (help (rest '(c d e)) (cons (first '(c d e)) '(b a)))
== (help '(d e) (cons (first '(c d e)) '(b a)))
== (help '(d e) (cons 'c '(b a)))
== (help '(d e) '(c b a))
== (help (rest '(d e)) (cons (first '(d e)) '(c b a)))
== (help '(e) (cons (first '(d e)) '(c b a)))
== (help '(e) (cons 'd '(c b a)))
== (help '(e) '(d c b a))
== (help (rest '(e)) (cons (first '(e)) '(d c b a)))
== (help '() (cons (first '(e)) '(d c b a)))
== (help '() (cons 'e  '(d c b a)))
== (help '() '(e d c b a))
== [(empty? '()) '(e d c b a)]
== [#true '(e d c b a)]
== '(e d c b a)

|#

;;;;; 1b

#|

(invert/v2 '(a b c d e))
== (append (invert/v2 (rest '(a b c d e))) (list (first '(a b c d e))))
== (append (invert/v2 '(b c d e)) (list (first '(a b c d e))))
== (append
    (append (invert/v2 (rest '(b c d e))) (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append (invert/v2 '(c d e) (list (first '(b c d e))))
    (list (first '(a b c d e)))))
== (append
    (append
     (append (invert/v2 (rest '(c d e))) (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append (invert/v2 '(d e)) (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append (invert/v2 (rest '(d e))) (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append (invert/v2 '(e)) (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append
       (append (invert/v2 (rest '(e))) (list (first '(e))))
       (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append
       (append (invert/v2 '()) (list (first '(e))))
       (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append
       (append '() (list (first '(e))))
       (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append
       (append '() (list 'e))
       (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append (list 'e) (list (first '(d e))))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append
      (append (list 'e) (list 'd))
      (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append (list 'e 'd) (list (first '(c d e))))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append
     (append (list 'e 'd) (list 'c))
     (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append (list 'e 'd 'c) (list (first '(b c d e))))
    (list (first '(a b c d e))))
== (append
    (append (list 'e 'd 'c) (list 'b))
    (list (first '(a b c d e))))
== (append (list 'e 'd 'c 'b) (list (first '(a b c d e))))
== (append (list 'e 'd 'c 'b) (list 'a))
(list 'e 'd 'c 'b 'a)

|#

;;;;; 1c

#|

The local help function in invert/v1 is tail recursive because each
recursion contains the answer by merely redefining help so that when it
gets (empty? ls) as #true, it doesn't need to do any calculations, it
just returns acc

|#

;;;;; 1d

#|

invert/v2 is not tail-recursive because when it checks it's base case,
it has to calculate the answer by running through each append function
causing it to take longer to calculate the result

|#

;;;;; 1e

(define (ignore x) #true)

#|
 n       invert/v1     invert/v2     reverse
-------------------------------------------------
    100     0             0             0
   1000     0             32            0
  10000     0             1000          0
 100000     110           177375        16
1000000     1219          :             172


Windows 10 32 Bit DrRacket
|#

;;;;; 1f

#|

invert/v2 is much slower than v1 because it is recuring using append,
so once it hits its base case it has to perform more calculations to
return the answer whereas invert/v1 is tail recursive and brings the
answer with it so when it hits its base case it just returns the
accumulator

|#

;;;;; 1g

(define invert invert/v1)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;;;;; 2a

;;;;; 2b

#|
 A TileValueF is one of
   - TileValue
   - #false
|#

; slide-row-left : Board -> Board
; (slide-row-left board) returns the result of moving each tile to the
; left. If two same value tiles come into contact the get merged into
; the next tile size up. If the tiles cannot move then board is
; returned unchanged

(define (slide-row-left board)
  (slide-row-left/help board #false '()))

; slide-row-left/help : Board TileValueF [ListOf X] -> Board
; (slide-row-left board) moves each number into the last-number tracker
; and if a new number is removed that is the same as last-number it
; knows that a new combined number is the first in the list. The pile
; keeps track of the blanks

(define (slide-row-left/help board last-number pile)
  (cond
    [(and (empty? board)
          (equal? last-number #false))
     pile]
    [(and (empty? board)
          (not (equal? last-number #false)))
     (cons last-number pile)]
    [(equal? (first board) BLANK)
     (slide-row-left/help (rest board) last-number (cons BLANK pile))]
    [(equal? (first board) last-number)
     (cons (+ (first board) last-number)
           (slide-row-left/help (cons BLANK (rest board))
                                #false
                                pile))]
    [(and (not (equal? (first board) last-number))
          (not (equal? last-number #false)))
     (cons last-number
           (slide-row-left/help (rest board)
                                (first board)
                                pile))]
    [else (slide-row-left/help (rest board)
                               (first board)
                               pile)]))

(check-expect (slide-row-left '()) '())
(check-expect (slide-row-left '(_)) (list '_))
(check-expect (slide-row-left '(2)) (list 2))
(check-expect (slide-row-left '(_ _)) (list '_ '_))
(check-expect (slide-row-left '(2 _)) (list 2 '_))
(check-expect (slide-row-left '(_ 2)) (list 2 '_))
(check-expect (slide-row-left '(2 2)) (list 4 '_))
(check-expect (slide-row-left '(2 4)) (list 2 4))
(check-expect (slide-row-left '(4 4)) (list 8 '_))
(check-expect (slide-row-left '(_ _ _)) (list '_ '_ '_))
(check-expect (slide-row-left '(2 _ _)) (list 2 '_ '_))
(check-expect (slide-row-left '(_ 2 _)) (list 2 '_ '_))
(check-expect (slide-row-left '(_ _ 2)) (list 2 '_ '_))
(check-expect (slide-row-left '(2 2 _)) (list 4 '_ '_))
(check-expect (slide-row-left '(2 _ 2)) (list 4 '_ '_))
(check-expect (slide-row-left '(_ 2 2)) (list 4 '_ '_))
(check-expect (slide-row-left '(2 4 _)) (list 2 4 '_))
(check-expect (slide-row-left '(2 _ 4)) (list 2 4 '_))
(check-expect (slide-row-left '(_ 2 4)) (list 2 4 '_))
(check-expect (slide-row-left '(2 2 2)) (list 4 2 '_))
(check-expect (slide-row-left '(4 2 2)) (list 4 4 '_))
(check-expect (slide-row-left '(2 4 2)) (list 2 4 2))
(check-expect (slide-row-left '(2 2 4)) (list 4 4 '_))
(check-expect (slide-row-left '(2 4 8)) (list 2 4 8))
(check-expect (slide-row-left '(_ _ 2 2 _ 2 4 _ _ 4))
              '(4 2 8 _ _ _ _ _ _ _))
(check-expect (slide-row-left '(2 2 _ _)) '(4 _ _ _))
(check-expect (slide-row-left '(2 _ 2 _)) '(4 _ _ _))
(check-expect (slide-row-left '(2 _ _ 2)) '(4 _ _ _))
(check-expect (slide-row-left '(2 2 _ 2)) '(4 2 _ _))


;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; slide-row-right : Board -> Board
; (slide-row-right board) returns the result of moving each tile to the
; right. If two same value tiles come into contact the get merged into
; the next tile size up. If the tiles cannot move then board is
; returned unchanged

(define (slide-row-right board)
  (reverse (slide-row-left (reverse board))))

(check-expect (slide-row-right '()) '())
(check-expect (slide-row-right '(_)) (list '_))
(check-expect (slide-row-right '(2)) (list 2))
(check-expect (slide-row-right '(_ _)) (list '_ '_))
(check-expect (slide-row-right '(2 _)) (list '_ 2))
(check-expect (slide-row-right '(_ 2)) (list '_ 2))
(check-expect (slide-row-right '(2 2)) (list '_ 4))
(check-expect (slide-row-right '(2 4)) (list 2 4))
(check-expect (slide-row-right '(4 4)) (list '_ 8))
(check-expect (slide-row-right '(_ _ _)) (list '_ '_ '_))
(check-expect (slide-row-right '(2 _ _)) (list '_ '_ 2))
(check-expect (slide-row-right '(_ 2 _)) (list '_ '_ 2))
(check-expect (slide-row-right '(_ _ 2)) (list '_ '_ 2))
(check-expect (slide-row-right '(2 2 _)) (list '_ '_ 4))
(check-expect (slide-row-right '(2 _ 2)) (list '_ '_ 4))
(check-expect (slide-row-right '(_ 2 2)) (list '_ '_ 4))
(check-expect (slide-row-right '(2 4 _)) (list '_ 2 4))
(check-expect (slide-row-right '(2 _ 4)) (list '_ 2 4))
(check-expect (slide-row-right '(_ 2 4)) (list '_ 2 4))
(check-expect (slide-row-right '(2 2 2)) (list '_ 2 4))
(check-expect (slide-row-right '(4 2 2)) (list '_ 4 4))
(check-expect (slide-row-right '(2 4 2)) (list 2 4 2))
(check-expect (slide-row-right '(2 2 4)) (list '_ 4 4))
(check-expect (slide-row-right '(2 4 8)) (list 2 4 8))
(check-expect (slide-row-right '(_ _ 2 2 _ 2 4 _ _ 4))
              (list '_ '_ '_ '_ '_ '_ '_ 2 4 8))

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; slide-left : Board -> Board
; (slide-left board) returns the result of mapping slide-row-left to
; each row in the board

(define (slide-left board)
  (map slide-row-left board))

; slide-right : Board -> Board
; (slide-right board) returns the result of mapping slide-row-right to
; each row in the board

(define (slide-right board)
  (map slide-row-right board))

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; transpose : [ListOf X] -> [ListOf X]
; (transpose lls) takes a non-empty list of lists lls, where each
; sublist is the same length as all other sublists, and returns the
; result of reflecting the elements along the main diagonal

(define (transpose lls)
  (cond
    [(or (empty? lls)
         (empty? (first lls))) '()]
    [else (cons (map first lls) (transpose (map rest lls)))]))

(check-expect (transpose '(())) '())
(check-expect (transpose '((5))) (list (list 5)))
(check-expect (transpose '((a b c) (d e f) (g h i)))
              (list (list 'a 'd 'g) (list 'b 'e 'h) (list 'c 'f 'i)))
(check-expect (transpose '((1 2) (3 4) (5 6)))
              (list (list 1 3 5) (list 2 4 6)))
(check-expect (equal? (transpose (transpose b2)) b2) #true)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

; slide-down : Board -> Board
; (slide-down board) returns the result of moving each tile in the
; downwards direction. If two same value tiles come into contact the get
; merged into the next tile size up. If the tiles cannot move then
; board is returned unchanged

(define (slide-down board)
  (transpose (slide-right (transpose board))))

(check-expect (slide-down (list (list 2 2)
                                (list 4 4)))
              (list (list 2 2)
                    (list 4 4)))
(check-expect (slide-down (list (list 2 2)
                                (list '_ '_)))
              (list (list  '_ '_)
                    (list 2 2)))

; slide-up : Board -> Board
; (slide-up board) returns the result of moving each tile in the
; upwards direction. If two same value tiles come into contact the get
; merged into the next tile size up. If the tiles cannot move then
; board is returned unchanged

(define (slide-up board)
  (transpose (slide-left (transpose board))))

(check-expect (slide-up (list (list 2 2)
                                (list 4 4)))
              (list (list 2 2)
                    (list 4 4)))
(check-expect (slide-up (list (list '_ '_)
                                (list 4 4)))
              (list (list 4 4)
                    (list '_ '_)))

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;; 7a

; game-lost? : Board -> Bool
; (game-lost? board)  returns #true if it represents a losing
; configuration, and #false otherwise

(define (game-lost? board)
  (and (equal? (slide-up board) board)
       (equal? (slide-down board) board)
       (equal? (slide-left board) board)
       (equal? (slide-right board) board)))

(check-expect (game-lost? '((2))) #true)
(check-expect (game-lost? '((2048))) #true)
(check-expect (game-lost? '((2 4) (8 4))) #false)
(check-expect (game-lost? '((2 4 8) (16 8 4) (8 4 2))) #true)
(check-expect (game-lost? b1) #false)

;;;;; 7b

; game-over? : Board -> Bool
; (game-over? board) returns #true if it represents either a winning or
; a losing configuration, and #false otherwise

(define (game-over? board)
  (or (game-lost? board)
      (game-won? board)))

(check-expect (game-over? '((1024))) #true)
(check-expect (game-over? '((2048 4) (8 4))) #true)
(check-expect (game-over? '((2 4 8) (16 8 4) (8 4 2))) #true)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

#|

A KeyStroke is one of:
- "left"
- "right"
- "down"
- "up"

|#

; key-handler : Board KeyStroke -> Board
; (key-handler board key) returns the board that results from
; processing the keyboard input. If the key is anything other than an
; arrow key, the board is returned unchanged. Otherwise, the board is
; shifted in the indicated direction and a new tile is attempted to be
; added to the board

(define (key-handler board key)
  (cond
    [(and (equal? key "right")
          (not (equal? (slide-right board) board)))
     (add-new-tile (slide-right board))]
    [(and (equal? key "left")
          (not (equal? (slide-left board) board)))
     (add-new-tile (slide-left board))]
    [(and (equal? key "up")
          (not (equal? (slide-up board) board)))
     (add-new-tile (slide-up board))]
    [(and (equal? key "down")
          (not (equal? (slide-down board) board)))
     (add-new-tile (slide-down board))]
    [else board]))

(define b4 (key-handler b1 "right"))
(define b5 (key-handler b4 "up"))
(define b6 (key-handler b5 "a"))
(define b7 (key-handler b2 "left"))
(define b8 (key-handler b7 "down"))
(define b9 '((2 4) (_ _)))

(check-expect (key-handler b9 "up") (list (list 2 4) (list '_ '_)))
(check-expect (key-handler b9 "left") (list (list 2 4) (list '_ '_)))
(check-expect (key-handler b9 "right") (list (list 2 4) (list '_ '_)))
(check-random (key-handler b9 "down") (key-handler b9 "down"))

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

; play : Nat -> Board
; (play n) returns the result of running big-bang on a nxn board with
; two non-blank tiles. Returns a board when game-over? is satisfied

(define (play n)
  (big-bang (make-board n 2)
            [to-draw board->image]
            [on-key key-handler]
            [stop-when game-over?]
            [name "2048"]))