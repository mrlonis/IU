;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a14")
(define collaboration-statement "I worked alone.")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

; image-map : [X -> Y] Img -> Img
; (image-map fn img) returns the image that results from applying the
; given function on each pixel in the given image

(define (image-map fn img)
  (color-list->bitmap (map fn (image->color-list img))
                      (image-width img)
                      (image-height img)))

(define prince (bitmap "prince.png"))

;;;;; 1b

; image-negative : Img -> Img
; (image-negative img) returns an image with all the color values
; inverted

(define (image-negative img)
  (image-map (; Nat -> Color
              lambda (x)
               (make-color (- 255 (color-red x))
                           (- 255 (color-green x))
                           (- 255 (color-blue x))))
             img))

(define marilyn (bitmap "marilyn.png"))

(define baboon (bitmap "baboon.png"))

(define tiny-dino (bitmap "tiny-dino.png"))

;;;;; 1c

; image-spin : Img -> Img
; (image-spin img) returns the image with all the color values rotated
; one time

(define (image-spin img)
  (image-map (; Nat -> Color
              lambda (x)
               (make-color (color-blue x)
                           (color-red x)
                           (color-green x)))
             img))

(define soup (bitmap "soup.png"))

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; warhol : Img Nat -> Img
; (warhol img n) If n is zero, then the given image is returned.
; Otherwise, a new image of (roughly) the same size is formed from four
; smaller images in a 2x2 grid pattern. The images in the upper left,
; lower left, and lower right quadrants are reduced versions of the
; given image. They are reduced in size by half in each dimension. The
; image in the upper right is a warhol fractal of depth n-1

(define (warhol img n)
  (local [(define scale-img
            (scale 0.5 img))]
    (cond
      [(zero? n) img]
      [else (above (beside scale-img (warhol scale-img (sub1 n)))
                   (beside scale-img scale-img))])))

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; interleave : [ListOf X] [ListOf X] -> [ListOf X]
; (interleave ls1 ls2)  returns the result of meshing the two lists
; together by alternating items, starting with the first list

(define (interleave ls1 ls2)
  (cond
    [(empty? ls1) ls2]
    [(empty? ls2) ls1]
    [else (cons (first ls1) (interleave ls2 (rest ls1)))]))

(check-expect (interleave '() '()) '())
(check-expect (interleave '(X X X X X X) '(O O O O O))
              (list 'X 'O 'X 'O 'X 'O 'X 'O 'X 'O 'X))
(check-expect (interleave '(1 2 3) '(a b c d e f))
              (list 1 'a 2 'b 3 'c 'd 'e 'f))
(check-expect (interleave '(1 2 3 4 5 6) '(a b))
              (list 1 'a 2 'b 3 4 5 6))

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

; flatten : [ListOf [ListOf X]] -> [ListOf X]
; (flatten lls) returns the result of appending together all the
; sublists in lls

(define (flatten lls)
  (foldr append '() lls))

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

; pop-up : PosInt [ListOf X] -> [ListOf [ListOf X]]
; (pop-up n ls) returns the result of grouping the elements of ls
; into sublists of size n, assuming n divides the length of ls

(define (pop-up n ls)
  (local
    [; help : [ListOf X] -> [ListOf [ListOf X]]
     ; help drops the invariant argument n
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

; image-interleave : Img Img > Img
; (image-interleave img1 img2) returns the result of meshing the two
; images together by alternating rows, starting with the first image

(define (image-interleave img1 img2)
  (local [(; help : [List [ListOf Color]]
           ;                     [List [ListOf Color]] -> [ListOf Color]
           define (help img1 img2)
            (flatten (interleave img1 img2)))]
    (color-list->bitmap
     (help (pop-up (image-width img1)
                   (image->color-list img1))
           (pop-up (image-width img2)
                   (image->color-list img2)))
     (image-width img1)
     (+ (image-height img1)
        (image-height img2)))))

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

; flip : [X X -> X] ->[X X -> X]
; (flip f) returns a function of two arguments. The returned function
; should work exactly the same as f except that the order of the
; arguments is reversed

(define (flip f)
  (; X X -> [X X -> X]
   lambda (x y)
    (f y x)))

(check-expect ((flip -) 5 6) 1)
(check-expect ((flip quotient) 5 23) 4)
(check-expect ((flip cons) '(b c d e f g h) 'a)
              (list 'a 'b 'c 'd 'e 'f 'g 'h))
(check-expect ((flip (flip string-append)) "basket" "ball")
              "basketball")

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

; unique-only : [ListOf X] -> [ListOf X]
; (unique-only ls) returns those elements that appear only once in the
; order in which they first appear in the given list

(define (unique-only ls)
  (cond
    [(empty? ls) '()]
    [else (cons (first ls) (unique-only (if (member? (first ls) ls)
                                            (remove-all (first ls) ls)
                                            (rest ls))))]))

(check-expect (unique-only '()) '())
(check-expect (unique-only '(4)) (list 4))
(check-expect (unique-only '(a a a b c b b c b a a a d a b c d d e))
              (list 'a 'b 'c 'd 'e))

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

; seeing-double : [ListOf X] -> Nat
; (seeing-double ls) returns the number of occurrences of exactly two
; consecutive identical elements. Sequences longer than two are not
; included in the count

(define (seeing-double ls)
  (local [(; help : [ListOf X] Nat [Maybe X] Nat -> Nat
           define (help ls state last-value count)
            (cond
              [(empty? ls) count]
              [(and (equal? (first ls) last-value)
                    (empty? (rest ls)))
               (help (rest ls) (add1 state) (first ls) (add1 count))]
              [(and (equal? (first ls) last-value)
                    (equal? (first ls) (second ls)))
               (help (rest (rest ls)) (add1 state) #false count)]
              [(and (equal? (first ls) last-value)
                    (not (equal? (first ls) (second ls))))
               (help (rest ls) (add1 state) (first ls) (add1 count))]
              [else (help (rest ls) (add1 state) (first ls) count)]))]
    (help ls 1 #false 0)))

(check-expect (seeing-double '(a b c d e f)) 0)
(check-expect (seeing-double '(a a b b c)) 2)
(check-expect (seeing-double '(a a b b c c)) 3)
(check-expect (seeing-double '(a a b b c c c)) 2)
(check-expect (seeing-double '(a a)) 1)
(check-expect (seeing-double '(a a a)) 0)
(check-expect (seeing-double '(a a a a)) 0)
(check-expect (seeing-double '(a a a b b a)) 1)
(check-expect (seeing-double '(a a b a a)) 2)
(check-expect (seeing-double '(a a b b c c d d e e f f g g h h)) 8)
(check-expect (seeing-double '(a a a b a a a b b b c c c c a b c)) 0)
(check-expect (seeing-double '(a b c d e f g)) 0)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

#|
(define (divide pred? ls)
  (local [(define (help ls ls1 ls2)
            (cond
              [(empty? ls) (list (reverse ls1) (reverse ls2))]
              [(pred? (first ls))
               (help (rest ls) (cons (first ls) ls1) ls2)]
              [else (help (rest ls) ls1 (cons (first ls) ls2))]))]
    (help ls '() '())))
|#
#|
(define (divide pred? ls)
  (cond
    [(empty? ls) (list '() '())]
    [else (local [(define ans (divide pred? (rest ls)))]
            (cond
              [(pred? (first ls))
               (cons (cons (first ls)
                           (first ans))
                     (rest ans))]
              [else (cons (first ans)
                          (list (cons (first ls)
                                      (first (rest ans)))))]))]))
|#

; divide : [X -> Bool] [ListOf X] -> [ListOf [ListOf X] [ListOf X]]
; (divide pred? ls) returns a list with two sublists: those elements in
; ls that satisfy the predicate and those that don’t. The order of the
; elements in each sublist is preserved

(define (divide pred? ls)
  (foldr (; X [ListOf X] -> [List [ListOf X] [ListOf X]]
          lambda (item acc)
           (if (pred? item)
               (list (cons item (first acc)) (first (rest acc)))
               (list (first acc) (cons item (first (rest acc))))))
         (list '() '()) ls))

(check-expect (divide zero? '(1 1 0 1 0 1 0 0 1 1))
              (list (list 0 0 0 0) (list 1 1 1 1 1 1)))
(check-expect (divide negative? '(9 3 -5 8 -7 2 9))
              (list (list -5 -7) (list 9 3 8 2 9)))
(check-expect (divide (lambda (x) (not (equal? x 'snow)))
                      '(snow rain hail snow snow sleet))
              (list (list 'rain 'hail 'sleet) (list 'snow 'snow 'snow)))

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

(define et (make-empty-tree))

#|
  A Leaf is a (make-node X (make-empty-tree) (make-empty-tree))
|#

; make-leaf : X -> Leaf
; (make-leaf x)  returns a tree with exactly one node, and that node
; contains the given x in its data field

(define (make-leaf x)
  (make-node x et et))

(check-expect (make-leaf "green")
              (make-node "green" (make-empty-tree) (make-empty-tree)))
(check-expect (node? (make-leaf 'a))
              #true)
(check-expect (node-data (make-leaf '(a b c)))
              (list 'a 'b 'c))
(check-expect (node-left (make-leaf 7))
              (make-empty-tree))
(check-expect (node-right (make-leaf #true))
              (make-empty-tree))

(define tr7
  (make-node "dog"
             (make-node "cat"
                        (make-leaf "cat")
                        et)
             (make-node "rat"
                        (make-leaf "gnu")
                        et)))

; leaf? : X -> Bool
; (leaf? item) returns #true if it is a leaf node, and #false otherwise

(define (leaf? item)
  (and (node? item)
       (empty-tree? (node-left item))
       (empty-tree? (node-right item))))

(check-expect (leaf? (make-leaf "green")) #true)

; longest-path-help : [TreeOf X] -> [ListOf Nat X]
; (longest-path-help tr) returns a list containing the height of the
; tree, followed by the data along the longest path

(define (longest-path-help tr)
  (cond
    [(empty-tree? tr) (list 0)]
    [(leaf? tr) (list 1 (node-data tr))]
    [else (local [(define right (longest-path-help (node-right tr)))
                  (define left (longest-path-help (node-left tr)))]
            (cond
              [(>= (first left) (first right))
               (cons (add1 (first left))
                     (cons (node-data tr) (rest left)))]
              [else (cons (add1 (first right))
                          (cons (node-data tr) (rest right)))]))]))

(check-expect (longest-path-help (make-empty-tree))
              (list 0))
(check-expect (longest-path-help (make-leaf 'a))
              (list 1 'a))
(check-expect (longest-path-help (make-node 'a
                                            (make-leaf 'b)
                                            (make-leaf 'c)))
              (list 2 'a 'b))
(define tr (make-node 'a
                      (make-leaf 'b)
                      (make-node 'c
                                 (make-empty-tree)
                                 (make-leaf 'd))))
(check-expect (longest-path-help tr)
              (list 3 'a 'c 'd))
(check-expect (longest-path-help (make-node 'x
                                            tr
                                            (make-node 'y
                                                       (make-empty-tree)
                                                       tr)))
              (list 5 'x 'y 'a 'c 'd))

; longest-path : [TreeOf X] -> [ListOf X]
; (longest-path tr) returns a list consisting of the data in the tree
; along the longest root to leaf path. If there is more than one such
; path, return the one with the leftmost leaf

(define (longest-path tr)
  (rest (longest-path-help tr)))

(check-expect (longest-path (make-empty-tree))
              '())
(check-expect (longest-path (make-leaf 'a))
              (list 'a))
(check-expect (longest-path (make-node 'a
                                       (make-leaf 'b)
                                       (make-leaf 'c)))
              (list 'a 'b))
(check-expect (longest-path (make-node 'a
                                       (make-leaf 'b)
                                       (make-node 'c
                                                  (make-empty-tree)
                                                  (make-leaf 'd))))
              (list 'a 'c 'd))

;;;;;;;;;;;;;;;;
;; Problem 10 ;;
;;;;;;;;;;;;;;;;

;;;;; 10a

; get-index : Nat Nat Nat ->  Nat
; (get-index x y width) returns the index of the pixel in the
; corresponding flat list of colors

(define (get-index x y width)
  (+ x (* y width)))

(check-expect (get-index 0 0 1000) 0)
(check-expect (get-index 0 20 100) 2000)
(check-expect (get-index 20 0 100) 20)
(check-expect (get-index 23 55 30) 1673)
(check-expect (get-index 23 55 50) 2773)

;;;;; 10b

; out-of-bounds? : Nat Nat Nat Nat -> Bool
; (out-of-bounds? x y width height) returns #true iff the coordinate is
; outside the perimeter of the image

(define (out-of-bounds? x y width height)
  (or (>= x width)
      (< x 0)
      (>= y height)
      (< y 0)))

(check-expect (out-of-bounds? -1 5 10 20) #true)
(check-expect (out-of-bounds? 1 -5 10 20) #true)
(check-expect (out-of-bounds? 10 4 10 20) #true)
(check-expect (out-of-bounds? 3 30 10 30) #true)
(check-expect (out-of-bounds? 3 35 10 30) #true)
(check-expect (out-of-bounds? 0 0 10 10) #false)

;;;;; 10c

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

; flood-fill : Img Nat Nat Color -> Img
; (flood-fill img x y color) returns the result of filling the region
; accessible from the coordinate with the color

#|
(define (flood-fill img x y color)
  (color-list->bitmap
   (local [(define height (image-height img))
           (define width (image-width img))
           (define old-color
             (list-ref (image->color-list img)
                       (get-index x y width)))
           (; help : [ListOf Color] Nat Nat Color -> [ListOf Color]
            define (help img-ls x y color)
             (cond
               [(out-of-bounds? x y width height) img-ls]
               [(not (equal? old-color
                             (list-ref img-ls
                                       (get-index x y width))))
                img-ls]
               [else (help
                      (overwrite
                       (help
                        (overwrite
                         (help
                          (overwrite
                           (help
                            (overwrite
                             (help
                              (overwrite img-ls
                                         (get-index x y width) color)
                              x y color)
                             (get-index x y width) color)
                            (add1 x) y color)
                           (get-index x y width) color)
                          (sub1 x) y color)
                         (get-index x y width) color)
                        x (add1 y) color)
                       (get-index x y width) color)
                      x (sub1 y) color)]))]
     (help (image->color-list img) x y color))
   (image-width img)
   (image-height img)))
|#

; overwrite/xy -> [ListOf X] Nat Nat Color -> [ListOf X]
; (overwrite ls i x) returns the list that results from
; replacing the element at index i in ls with x

(define (overwrite/xy ls x y color)
  (overwrite ls y (overwrite (list-ref ls y) x color)))

; flood-fill/fast : Img Nat Nat Color -> Img
; (flood-fill/fast img x y color) returns the result of filling the
; region accessible from the coordinate with the color

(define (flood-fill/fast img x y color)
  (color-list->bitmap
   (local [(define height (image-height img))
           (define width (image-width img))
           (define old-color
             (list-ref (image->color-list img)
                       (get-index x y width)))
           (; help : [ListOf Color] Nat Nat Color -> [ListOf Color]
            define (help img-ls x y color)
             (cond
               [(out-of-bounds? x y width height) img-ls]
               [(not (equal? old-color
                             (list-ref (list-ref img-ls y) x)))
                img-ls]
               [else (help
                      (help
                       (help
                        (help
                         (overwrite/xy img-ls x y color)
                         (add1 x) y color)
                        (sub1 x) y color)
                       x (add1 y) color)
                      x (sub1 y) color)]))]
     (flatten (help (pop-up (image-width img) (image->color-list img))
                    x y color)))
   (image-width img)
   (image-height img)))

;;;;; 10d

#|
  A World is one of (make-world [Img Nat Nat])
|#

(define-struct world [img x y])

; paint : Img -> Img
; (paint img) runs a big-bang on an image, which displays the
; coordinates of the mouse as it moves. On a "button-down" event, run a
; flood fill for the image at the current coordinates using a randomly
; selected color.

(define (paint img)
  (big-bang
   (make-world img 0 0)
   [to-draw
    (; World -> Image
     lambda (world)
      (above (world-img world)
             (text (format "(~s, ~s)" (world-x world) (world-y world))
                   24 'black)))]
   [on-mouse
    (; World Nat Nat String -> Posn
     lambda (world x y mouse-event)
      (cond
        [(equal? mouse-event "move")
         (make-world (world-img world) x y)]
        [(equal? mouse-event "button-down")
         (make-world (flood-fill/fast (world-img world) x y
                                      (make-color (random 255)
                                                  (random 255)
                                                  (random 255)))
                     x y)]
        [else world]))]))