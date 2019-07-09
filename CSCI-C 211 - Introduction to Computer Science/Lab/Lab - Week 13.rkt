;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 13|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab13")
(define partner "ecrichlo")
(define collaboration-statement
  (string-append "I worked with " partner "."))

#|

A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])

|#

(define-struct empty-tree [])
(define-struct node [data left right])

(define et (make-empty-tree))

(define (process-tree tree)
  (cond
    [(empty-tree? tree) ...]
    [(node? tree) (... (node-data tree) ...
                       (process-tree (node-left tree)) ...
                       (process-tree (node-right tree) ...))]
    [else (error "not a dank tree")]))

(define friend-tree
  (make-node 5
             (make-node 1
                        (make-node 2 et et)
                        (make-node 4 et et))
             (make-node 1000
                        (make-node 1000000
                                   (make-node 100000000000 et et)
                                   (make-node 1000000000000000 et et))
                        (make-node 999999999999999999999999999 et et))))

; sum-donations : [TreeOf Num] -> Num
; (sum-donations tree) returns the total sum of all the values in the
; given tree or else it returns an error

(define (sum-donations tree)
  (cond
    [(empty-tree? tree) 0]
    [(node? tree) (+ (node-data tree)
                     (sum-donations (node-left tree))
                     (sum-donations (node-right tree)))]
    [else (error "not a dank tree")]))

(check-expect (sum-donations friend-tree) 1000000000001000100001001011)

; how-many-nets : [TreeOf Num] -> Nat
; (how-many-nets tree) returns the quotient of the sum of the tree
; divided by 5

(define (how-many-nets tree)
  (quotient (sum-donations tree) 5))

(check-expect (how-many-nets friend-tree) 200000000000200020000200202)

; twist-arms : [TreeOf Num] -> [TreeOf Num]
; (twist-arms tree) returns the tree with all the node values doubled

(define (twist-arms tree)
  (cond
    [(empty-tree? tree) et]
    [(node? tree) (make-node (* 2 (node-data tree))
                             (twist-arms (node-left tree))
                             (twist-arms (node-right tree)))]
    [else (error "not a dank tree")]))

(check-expect
 (twist-arms friend-tree)
 (make-node
  10
  (make-node 2
             (make-node 4
                        (make-empty-tree)
                        (make-empty-tree))
             (make-node 8
                        (make-empty-tree)
                        (make-empty-tree)))
  (make-node
   2000
   (make-node 2000000
              (make-node 200000000000
                         (make-empty-tree)
                         (make-empty-tree))
              (make-node 2000000000000000
                         (make-empty-tree)
                         (make-empty-tree)))
   (make-node 1999999999999999999999999998
              (make-empty-tree)
              (make-empty-tree)))))

; tree-map : [X -> Y] [TreeOf X] -> [TreeOf Y]

(define (tree-map changer tree)
  (cond
    [(empty-tree? tree) et]
    [(node? tree) (make-node (changer (node-data tree))
                             (tree-map changer (node-left tree))
                             (tree-map changer (node-right tree)))]
    [else (error "not a dank tree")]))

(check-expect (tree-map (lambda (x)
                          (* 2 x)) friend-tree)
              (twist-arms friend-tree))

(define (twist-arms/v2 tree)
  (tree-map (lambda (x)
              (* 2 x)) tree))

(check-expect (twist-arms/v2 friend-tree)
              (twist-arms friend-tree))

(define shitty-tree
  (make-node 5
             (make-node 0 et et)
             (make-node 0 et et)))
(define shitty-tree/v2
  (make-node 5
             (make-node 0
                        (make-node 5 et et)
                        et)
             (make-node 0 et et)))

; remove-zero : [TreeOf Num] -> [TreeOf Num]

(define (remove-deadbeats tree)
  (cond
    [(empty-tree? tree) et]
    [(zero? (sum-donations tree)) et]
    [(node? tree)
     (make-node (node-data tree)
                (remove-deadbeats (node-left tree))
                (remove-deadbeats (node-right tree)))]
    [else (error "not a dank tree")]))

(check-expect (remove-deadbeats shitty-tree)
              (make-node 5 et et))
(check-expect (remove-deadbeats shitty-tree/v2)
              (make-node 5
                         (make-node 0
                                    (make-node 5 et et)
                                    et)
                         et))