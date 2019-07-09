;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "lecture-apr18")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Andrew Andjelic")


(define waldo (bitmap/url
               "http://cgi.soic.indiana.edu/~c211/images/waldo.jpg"))

(big-bang
 (make-posn 0 0)
 [to-draw
  ; Posn -> Image  
  (lambda (p)
    (above waldo
           (text (format "(~s, ~s)" (posn-x p) (posn-y p))
                 24 'black)))]
 [on-mouse
  ; Posn Nat Nat String -> Posn
  (lambda (p x y mouse-event)
    (if (equal? mouse-event "move")
        (make-posn x y)
        p))])


;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Grant Eller")

; wheres-waldo : [NonEmptyListOf X] -> Nat
; (wheres-waldo ls) returns the leftmost index of 'waldo in ls
; Precondition: 'waldo must exist somewhere in ls

(define (wheres-waldo ls)
  (cond
    [(equal? (first ls) 'waldo) 0]
    [else
     (add1 (wheres-waldo (rest ls)))]))

(check-expect (wheres-waldo '(waldo germany france greece russia)) 0)
(check-expect (wheres-waldo '(germany waldo france greece russia)) 1)
(check-expect (wheres-waldo '(germany france waldo greece russia)) 2)
(check-expect (wheres-waldo '(germany france greece waldo russia)) 3)
(check-expect (wheres-waldo '(germany france greece russia waldo)) 4)

; wheres-waldo/v2 : [ListOf X] -> [Maybe Nat]
; (wheres-waldo/v2 ls) returns the leftmost index of 'waldo in ls,
; if it exists, and #false otherwise

(define (wheres-waldo/v2 ls)
  (cond
    [(empty? ls) #false]
    [(equal? (first ls) 'waldo) 0]
    [else
     (local
       [(define ans (wheres-waldo/v2 (rest ls)))]
       (if (false? ans)
           #false
           (add1 ans)))]))


(check-expect (wheres-waldo/v2 '(waldo germany france greece russia)) 0)
(check-expect (wheres-waldo/v2 '(germany waldo france greece russia)) 1)
(check-expect (wheres-waldo/v2 '(germany france waldo greece russia)) 2)
(check-expect (wheres-waldo/v2 '(germany france greece waldo russia)) 3)
(check-expect (wheres-waldo/v2 '(germany france greece russia waldo)) 4)
(check-expect (wheres-waldo/v2 '(germany france greece russia)) #false)


;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Josh Lipe-Melton")
; wheres-waldo/v3 : [ListOf X] -> [Maybe Nat]
; (wheres-waldo/v3 ls) returns the leftmost index of 'waldo in ls,
; if it exists, and #false otherwise

(define (wheres-waldo/v3 ls)
  (local [;loop : [ListOfX] Nat -> [Maybe Nat]
          ;i is the current index in ls
          (define (loop ls i)
            (cond
              [(empty? ls) #false]
              [(equal? (first ls) 'waldo) i]
              [else (loop (rest ls) (add1 i))]))]
    (loop ls 0)))

(check-expect (wheres-waldo/v3 '(waldo germany france greece russia)) 0)
(check-expect (wheres-waldo/v3 '(germany waldo france greece russia)) 1)
(check-expect (wheres-waldo/v3 '(germany france waldo greece russia)) 2)
(check-expect (wheres-waldo/v3 '(germany france greece waldo russia)) 3)
(check-expect (wheres-waldo/v3 '(germany france greece russia waldo)) 4)
(check-expect (wheres-waldo/v3 '(germany france greece russia)) #false)


;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Andre Quan")

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

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

; tree-member? : X [TreeOf X] -> Bool
; (tree-member? x tr) returns #true iff x appears in some node of tr

(define (tree-member? x tr)
  (and (not (empty-tree? tr))
       (or (equal? (node-data tr) x)
           (tree-member? x (node-left tr))
           (tree-member? x (node-right tr)))))  


(check-expect (tree-member? 'a tr) #true)
(check-expect (tree-member? 'b tr) #true)
(check-expect (tree-member? 'c tr) #true)
(check-expect (tree-member? 'd tr) #true)
(check-expect (tree-member? 'e tr) #true)
(check-expect (tree-member? 'f tr) #true)
(check-expect (tree-member? 'g tr) #false)
(check-expect (tree-member? 'h tr) #true)
(check-expect (tree-member? 'i tr) #false)



;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

(define scribe5 "Grant Eller")

; completely-balanced : [TreeOf X] -> [Maybe Nat]
; (completely-balanced tr) returns the height of the tree iff tr is
; height-balanced at every node, and #false otherwise

(define (completely-balanced tr)
  (cond
    [(empty-tree? tr) 0]
    [else
     (local
       [(define ansl (completely-balanced (node-left tr)))]
       (if (false? ansl)
           #false
           (local [(define ansr (completely-balanced (node-right tr)))]
             (if (false? ansr)
                 #false
                 (if (= ansr ansl)
                     (add1 ansr)
                     #false)))))]))  


(check-expect (completely-balanced et) 0)
(check-expect (completely-balanced (make-node 'a et et)) 1)
(check-expect (completely-balanced (make-node 'a et et)) 1)
(check-expect (completely-balanced
               (make-node 'a
                          (make-node 'b et et)
                          (make-node 'c et et))) 2)
(check-expect (completely-balanced
               (make-node 'a
                          et
                          (make-node 'c et et))) #false)
(check-expect (completely-balanced
               (make-node 'a
                          (make-node 'b et et)
                          et)) #false)
(check-expect (completely-balanced
               (make-node 'a
                          (make-node 'b
                                     (make-node 'd et et)
                                     (make-node 'e et et))
                          (make-node 'c et et))) #false)
(check-expect (completely-balanced
               (make-node 'a
                          et
                          (make-node 'c
                                     (make-node 'f et et)
                                     (make-node 'g et et)))) #false)

(check-expect (completely-balanced
               (make-node 'a
                          (make-node 'b
                                     (make-node 'd et et)
                                     (make-node 'e et et))
                          (make-node 'c
                                     (make-node 'f et et)
                                     (make-node 'g et et)))) 3)


;;;;;;;;;;;;;;
;; Problem 6
;;;;;;;;;;;;;;

(define scribe6 "Josh Lipe-Melton")


(check-expect (map (compose sub1 abs)
                   '(6 8 -3 2 4 -8))
              (list 5 7 2 1 3 7))
(check-expect (filter (compose not zero?)
                      '(0 0 0 0 5 0 0 -8 0 3))
              (list 5 -8 3))
