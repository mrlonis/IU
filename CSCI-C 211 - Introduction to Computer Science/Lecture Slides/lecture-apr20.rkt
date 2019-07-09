;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-apr20")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Matthew Lonis")

;; load an image for testing purposes

(define tiny-dino
  (bitmap/url
   "http://cgi.soic.indiana.edu/~c211/images/tiny-dino.png"))

#|
  A Byte is a Nat in the range [0..255]

  A Color is a (make-color Byte Byte Byte)
|#

; image-recolor : Image Color Color -> Image
; (image-recolor image old-color new-color) returns the image that
; results from replacing all occurrences of old-color with
; new-color in image

(define (image-recolor image old-color new-color)
  (color-list->bitmap
   (map (; Color -> Color
         lambda (pixel)
          (if (equal? pixel old-color)
              new-color
              pixel))
        (image->color-list image))
   (image-width image)
   (image-height image)))

;; create some standard colors

(define white (make-color 255 255 255))
(define black (make-color 0 0 0))
(define red (make-color 255 0 0))
(define green (make-color 0 255 0))
(define blue (make-color 0 0 255))
(define yellow (make-color 255 255 0))
(define purple (make-color 160 32 240))

;; use image-recolor to create a neon version of tiny-dino

(define neon-dino
  (image-recolor (image-recolor tiny-dino black green)
                 white
                 purple))

(check-expect (image-recolor (square 4 'solid 'red) red green)
              (square 4 'solid 'green))
(check-expect (first (image->color-list
                      (image-recolor tiny-dino white blue)))
              blue)
(check-expect (list-ref (image->color-list
                         (image-recolor tiny-dino black green))
                        3360)
              green)

;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Andre Quan")

; locate : X [ListOf X] -> [Maybe Nat]
; (locate x ls) returns the position of the leftmost occurrence of
; x in ls, if it exists, and #false otherwise

(define (locate x ls)
  (local [; help : [ListOf X] -> [Maybe Nat]
          (define (help ls)
            (cond
              [(empty? ls) #false]
              [(equal? x (first ls)) 0]
              [else (local [(define ans (help (rest ls)))]
                      (if (false? ans)
                          #false
                          (add1 ans)))]))]
    (help ls)))

(check-expect (locate 'waldo '(waldo germany france greece russia)) 0)
(check-expect (locate 'waldo '(germany waldo france greece russia)) 1)
(check-expect (locate 'spain '(germany france greece spain russia)) 3)
(check-expect (locate 7 '(0 1 2 3 4 5 6 7 8 9 10 11 12)) 7)
(check-expect (locate 7 '(0 1 2 3 4 5 6 8 9 10 11 12)) #false)
(check-expect (locate '() '(a (b c) (d) (e f g) () (h i))) 4)
(check-expect (locate 'x (make-list 100 'x)) 0)
(check-expect (locate "waldo" (make-list 100 "water")) #false)
(check-expect (locate 'waldo (build-list 101
                                         (lambda (i)
                                           (if (= i 100)
                                               'waldo
                                               'water))))
              100)


;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Josh Lipe-Melton")

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

;; create some trees for testing purposes

(define et (make-empty-tree))
(define tr
  (make-node 'd
             (make-node 'h
                        (make-node 'f et et)
                        (make-node 'a
                                   (make-node 'e et et)
                                   et))
             (make-node 'b
                        et
                        (make-node 'c et et))))
#|
  A Direction is one of
  - 'left
  - 'right

  A Path is a [ListOf Direction]
|#

; tree-locate : X [TreeOf X] -> [Maybe Path]
; (tree-locate x tr) returns a list of directions leading from the
; root of tr to a node containing x in the data field, if one exists,
; and #false otherwise

(define (tree-locate x tr)
  (cond
    [(empty-tree? tr) #false]
    [(equal? (node-data tr) x) '()]
    [else (local
            [(define leftlocate
               (tree-locate x (node-left tr)))
             (define rightlocate
               (tree-locate x (node-right tr)))]
            (if (false? leftlocate)
                (if (false? rightlocate)
                    #false
                    (cons 'right rightlocate))
                (cons 'left leftlocate)))]))

(check-expect (tree-locate 'x et) #false)
(check-expect (tree-locate 'd tr) '())
(check-expect (tree-locate 'h tr) '(left))
(check-expect (tree-locate 'f tr) '(left left))
(check-expect (tree-locate 'a tr) '(left right))
(check-expect (tree-locate 'e tr) '(left right left))
(check-expect (tree-locate 'b tr) '(right))
(check-expect (tree-locate 'c tr) '(right right))
(check-expect (tree-locate 'g tr) #false)


;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Andrew Andjelic")

; bst-locate : Nat [TreeOf Nat] -> [Maybe Path]
; (bst-locate x bst) returns a list of directions leading from the
; root of bst to a node containing x in the data field, if one exists,
; and #false otherwise. We assume bst is ordered on the < relation.

#|
a tuna is one of
-albacore
-solid white
|#
(define fish "tuna")


(define (bst-locate x bst)
  (cond
    [(empty-tree? bst) #f]
    [(equal? (node-data tr) x) '()]
    [else (if (> x (node-data bst))
             (cons 'right (tree-locate x (node-right bst)))
             (cons 'left (tree-locate x (node-left bst))))]))


;; create a bst of nums on < for testing purposes

(define bst
  (make-node 6
             (make-node 3
                        (make-node 1 et et)
                        (make-node 5
                                   (make-node 4 et et)
                                   et))
             (make-node 8
                        et
                        (make-node 9 et et))))
#|
(check-expect (bst-locate 0 et) #false)
(check-expect (bst-locate 6 bst) '())
(check-expect (bst-locate 3 bst) '(left))
(check-expect (bst-locate 1 bst) '(left left))
(check-expect (bst-locate 5 bst) '(left right))
(check-expect (bst-locate 4 bst) '(left right left))
(check-expect (bst-locate 8 bst) '(right))
(check-expect (bst-locate 9 bst) '(right right))
(check-expect (bst-locate 2 bst) #false)
|# 

;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

(define scribe5 "")

#|
  A Bit is one of
  - 0
  - 1
|#

; binary->decimal : [NonEmptyListOf Bit] -> Nat
; (binary->decimal bits) returns the base 10 equivalent of bits

(define (binary->decimal bits)
  ;; do this entirely in terms of foldr or foldl
  ...)

#|
(check-expect (binary->decimal '(0)) 0)
(check-expect (binary->decimal '(1)) 1)
(check-expect (binary->decimal '(1 1 0)) 6)
(check-expect (binary->decimal '(1 1 1 1)) 15)
(check-expect (binary->decimal '(1 0 0 0 1)) 17)
(check-expect (binary->decimal '(1 0 0 0 1 1 1 0)) 142)
|#

