;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Final) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

(define et (make-empty-tree))

; bst-parent : Int [TreeOf Int] -> [Maybe Int]
; (bst-parent x bst) retunrs the result of searching for an occurence of
; x in bst and if found returns the data in its parent node (if one
; exists). Otherwise, #false is returned

(define (bst-parent x bst)
  (cond
    [(empty-tree? bst) #false]
    [(and (equal? (node-left bst)
                  et)
          (equal? (node-right bst)
                  et))
     #false]
    [(and (node? (node-left bst))
          (equal? (node-data (node-left bst))
                  x))
     (node-data bst)]
    [(and (node? (node-right bst))
          (equal? (node-data (node-right bst))
                  x))
     (node-data bst)]
    [else (local [(define right (bst-parent x (node-right bst)))
                  (define left (bst-parent x (node-left bst)))]
            (cond
              [(number? right) right]
              [(number? left) left]
              [else #false]))]))


(check-expect (bst-parent 5 (make-empty-tree)) #false)
(check-expect (bst-parent 5 (make-node 5 et et)) #false)
(define bst
  (make-node 5
             (make-node 3
                        et
                        (make-node 4 et et))
             (make-node 7
                        (make-node 6 et et)
                        (make-node 8 et et))))
(check-expect (bst-parent 6 bst) 7)
(check-expect (bst-parent 2 bst) #false)
(check-expect (bst-parent 4 bst) 3)
(check-expect (bst-parent 7 bst) 5)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

(define tiles (map bitmap/file
                   (list "cats.jpg" "stonewall.jpg" "darkfire.jpg")))

; lay-tiles : Nat Nat Img -> Img
; (lay-tiles width height img) returns the result of tiling the
; background (a solid white rectangle with width and height given in
; the function) with the given image

(define (lay-tiles width height img)
  (local [(; help : Nat Nat Img -> Img
           ; (help x y new-img) returns the result of applying the img
           ; to the current recursion of the background
           define (help x y new-img)
            (cond
              [(>= x width) (help 0 (+ (image-height img) y) new-img)]
              [(>= y height) new-img]
              [else
               (help
                (+ x (image-width img)) y
                (place-image/align
                 img x y "left" "top" new-img))]))]
    (help 0 0 (rectangle width height "solid" "white"))))

(check-satisfied (lay-tiles 876 321 (first tiles)) image?)
(check-expect (image-width (lay-tiles 876 321 (first tiles))) 876)
(check-satisfied (lay-tiles 543 210 (second tiles)) image?)
(check-satisfied (lay-tiles 903 129 (third tiles)) image?)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

; raffle-off-help : [ListOf X] [ListOf X] -> [ListOf X]
; (raffle-off-help ls1 ls2) returns ls1 with all the elements found in
; ls2 removed

(define (raffle-off-help ls1 ls2)
  (cond
    [(empty? ls2) ls1]
    [else (raffle-off-help (remove (first ls2) ls1)
                           (rest ls2))]))

(check-expect (raffle-off-help '(a b c d e f g) '(d e g a))
              '(b c f))

; raffle-off : [ListOf X] [ListOf X] -> [ListOf X]
; (raffle-off ls1 ls2) returns a randomly selected element from ls1 as
; long as it doesn't exist in ls2

(define (raffle-off ls1 ls2)
  (local [(define ls (raffle-off-help ls1 ls2))]
    (list-ref ls (random (length ls)))))

(check-random (raffle-off '(a b c d e f g) '(d e g a))
              (raffle-off '(a b c d e f g) '(d e g a)))