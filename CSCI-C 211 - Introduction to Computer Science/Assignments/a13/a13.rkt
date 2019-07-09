;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname a13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "a13")
(define collaboration-statement "I worked alone.")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

#|
  A Nat is one of
  - 0
  - (add1 Nat)

  A Strategy is one of [Nat -> Nat]

  A Plater is one of (make-player [Symbol Strategy]
|#

(define-struct player [name strategy])

(define greedy-witch
  (make-player 'Alice
               (lambda (tiles)
                 (min tiles 3))))
(define wicked-witch
  (make-player 'Elphaba
               (lambda (tiles)
                 (cond
                   [(<= tiles 5) 1]
                   [else 3]))))
(define good-witch
  (make-player 'Glinda
               (lambda (tiles)
                 (cond
                   [(<= tiles 2) 1]
                   [(<= tiles 4) (sub1 tiles)]
                   [else (add1 (random 3))]))))

(check-expect (player? wicked-witch) #true)
(check-expect (player-name wicked-witch) 'Elphaba)

;;;;; 1b

#|
  A Game is one of
  - (cons Nat (cons Symbol '()))
  - (cons Nat Game)
|#

; play : Nat Player Player -> Game
; (play tiles player1 player2)  returns a list containing the number of
; tiles at each turn followed by the name of the winner

(define (play tiles player1 player2)
  (cond
    [(<= tiles 0) (cons 0 (cons (player-name player1) '()))]
    [else (cons tiles (play (- tiles ((player-strategy player1) tiles))
                            player2
                            player1))]))

;;;;; 1c

(define smart-witch
  (make-player 'Dorothy
               (lambda (tiles)
                 (cond
                   [(zero? (modulo (sub1 tiles) 4)) 1]
                   [(= 1 (modulo (- tiles (modulo (sub1 tiles) 4)) 4))
                    (modulo (sub1 tiles) 4)]
                   [else 1]))))

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; jumble : [ListOf X] -> [ListOf X]
; (jumble ls) takes a list and uses sort to rearrange the elements in
; random order

(define (jumble ls)
  (sort ls (lambda (x y)
             (cond
               [(= (random 2) 0) #true]
               [else #false]))))

(check-random (jumble '(a b c d e f)) (jumble '(a b c d e f)))
(check-random (jumble '(9 8 7 6 5 4 3 2 1 0))
              (jumble '(9 8 7 6 5 4 3 2 1 0)))
(check-random (list->string (jumble (string->list "Rudolph")))
              (list->string (jumble (string->list "Rudolph"))))
(check-random (jumble '(#false "hohoho" inf 6 (b c) (3 4 5)))
              (jumble '(#false "hohoho" inf 6 (b c) (3 4 5))))

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

;;;;; 3a

#|
  A Packet is a (make-packet [Symbol String Nat Nat])
|#

(define-struct packet [tag segment seq-number count])

(define a-packet (make-packet 'brian "red fish" 3 9))

(check-expect (packet-tag a-packet) 'brian)
(check-expect (packet-segment a-packet) "red fish")
(check-expect (packet-seq-number a-packet) 3)
(check-expect (packet-count a-packet) 9)

; string->packets : String Symbol Nat -> [ListOf Packet]
; (string->packets message tag size) returns a list of packets

(define (string->packets message tag size)
  (local [(define limit (ceiling (/ (string-length message) size)))
          
          (define (help message seq-num)
            (cond
              [(= seq-num limit)
               (list (make-packet tag message seq-num limit))]
              [else (cons (make-packet tag
                                       (substring message 0 size)
                                       seq-num
                                       limit)
                          (help (substring message size)
                                (add1 seq-num)))]))]
    (help message 1)))

(check-expect
 (string->packets "How does it feel to be on your own" 'foo 10)
 (list (make-packet 'foo "How does i" 1 4)
       (make-packet 'foo "t feel to " 2 4)
       (make-packet 'foo "be on your" 3 4)
       (make-packet 'foo " own" 4 4)))
(check-expect (string->packets "With no direction home" 'goo 5)
              (list (make-packet 'goo "With " 1 5)
                    (make-packet 'goo "no di" 2 5)
                    (make-packet 'goo "recti" 3 5)
                    (make-packet 'goo "on ho" 4 5)
                    (make-packet 'goo "me" 5 5)))
(check-expect (string->packets "Like a complete unknown" 'boo 7)
              (list (make-packet 'boo "Like a " 1 4)
                    (make-packet 'boo "complet" 2 4)
                    (make-packet 'boo "e unkno" 3 4)
                    (make-packet 'boo "wn" 4 4)))
(check-expect (string->packets "Like a rolling stone?" 'hoo 25)
              (list (make-packet 'hoo "Like a rolling stone?" 1 1)))

;;;;; 3b

; reconstitute : Symbol [ListOf Packet] -> [Maybe String]
; (reconstitute tag lls) returns the message string corresponding to
; the tag, if all packets are present and accounted for. Otherwise,
; return #false

(define (reconstitute tag lls)
  (local [(define (safe-check lls)
            (cond
              [(empty? lls) #false]
              [(not (= (length lls) (packet-count (first lls))))
               #false]
              [else lls]))
          (define (help lls)
            (cond
              [(equal? lls #false) #false]
              [(empty? lls) ""]
              [else (string-append (packet-segment (first lls))
                                   (help (rest lls)))]))]
    (help (safe-check
           (sort (filter (lambda (x)
                           (equal? tag (packet-tag x))) lls)
                 (lambda (x y)
                   (< (packet-seq-number x)
                      (packet-seq-number y))))))))

(define p1 (string->packets "Take that, my pretty!" 'toto 3))
(define p2 (rest
            (string->packets "There's no place like home." 'tinman 4)))
(define p3 (string->packets "We're not in Kansas anymore." 'lion 5))
(define all-together (jumble (append p1 p2 p3)))

(check-expect (reconstitute 'toto all-together) "Take that, my pretty!")
(check-expect (reconstitute 'tinman all-together) #false)
(check-expect (reconstitute 'lion all-together)
              "We're not in Kansas anymore.")

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;;;;; 4a

#|
  A Peg is one of
  - 'A
  - 'B
  - 'C
|#

;;;;; 4b

#|
  A PosInt is one of
  - 1
  - (add1 PosInt)

  A Move is one of (make-move [PosInt Peg Peg])
|#

(define-struct move [disk from to])

(check-expect (move? (make-move 1 'A 'C)) #true)
(check-expect (move-disk (make-move 63 'A 'B)) 63)
(check-expect (move-from (make-move 15 'B 'C)) 'B)
(check-expect (move-to (make-move 31 'C 'A)) 'A)

;;;;; 4c

; hanoi : Nat -> [ListOf Move]
; (hanoi n) returns the list of moves that will transfer all the disks
; from the starting peg to the ending peg

(define (hanoi n)
  (local
    [(define (help n starting ending middle)
       (cond
         [(= n 1) (list (make-move n starting ending))]
         [else (append (help (sub1 n) starting middle ending)
                       (list (make-move n starting ending))
                       (help (sub1 n) middle ending starting))]))]
    (help n 'A 'C 'B)))

(check-expect (hanoi 3)
              (list (make-move 1 'A 'C) (make-move 2 'A 'B)
                    (make-move 1 'C 'B) (make-move 3 'A 'C)
                    (make-move 1 'B 'A) (make-move 2 'B 'C)
                    (make-move 1 'A 'C)))
(check-expect (hanoi 4)
              (list (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 3 'A 'B)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 4 'A 'C)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 3 'B 'C)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C)))
(check-expect (hanoi 6)
              (list (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 3 'A 'B)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 4 'A 'C)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 3 'B 'C)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 5 'A 'B)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 3 'C 'A)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 4 'C 'B)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 3 'A 'B)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 6 'A 'C)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 3 'B 'C)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 4 'B 'A)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 3 'C 'A)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 5 'B 'C)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C) (make-move 3 'A 'B)
                    (make-move 1 'C 'A) (make-move 2 'C 'B)
                    (make-move 1 'A 'B) (make-move 4 'A 'C)
                    (make-move 1 'B 'C) (make-move 2 'B 'A)
                    (make-move 1 'C 'A) (make-move 3 'B 'C)
                    (make-move 1 'A 'B) (make-move 2 'A 'C)
                    (make-move 1 'B 'C)))
(check-expect (length (hanoi 15)) 32767)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

;;;;; 5a

; subset-sum? : [ListOf Nat] Int -> Bool
; (subset-sum? ls target) returns true if there is some subset of
; elements from ls that sums to the target, and #false otherwise

(define (subset-sum? ls target)
  (cond
    [(and (empty? ls)
          (zero? target)) #true]
    [(empty? ls) #false]
    [else (or (subset-sum? (rest ls) target)
              (subset-sum? (rest ls) (- target (first ls))))]))

(check-expect (subset-sum? '() 0) #true)
(check-expect (subset-sum? '(5 9) -2) #false)
(check-expect (subset-sum? '(5 9) 5) #true)
(check-expect (subset-sum? '(5 9) 9) #true)
(check-expect (subset-sum? '(5 9) 8) #false)
(check-expect (subset-sum? '(5 9) 14) #true)
(check-expect (subset-sum? '(1 8 2 4) 7) #true)
(check-expect (subset-sum? '(15 22 14 26 32 9 16 8) 53) #true)
(check-expect (subset-sum? '(15 22 14 26 32 9 16 8) 28) #false)

;;;;; 5b

; subset-sum : [ListOf Int] Int -> [maybe [ListOf Int]]
; (subset-sum ls target) returns #false if there is no subset of
; elements from ls that sums to the target. In the case that a subset
; exists, return one of the subsets

(define (subset-sum ls target)
  (cond
    [(not (subset-sum? ls target)) #false]
    [else (local [(define (help ls target)
                    (cond
                      [(or (empty? ls)
                           (zero? target)) '()]
                      [(= (first ls) target) (cons (first ls) '())]
                      [(subset-sum? (rest ls) (- target (first ls)))
                       (cons (first ls) (help (rest ls)
                                              (- target (first ls))))]
                      [else  (help (rest ls) target)]))]
            (help ls target))]))

(check-expect (subset-sum '() 0) '())
(check-expect (subset-sum '(5 9) 5) (list 5))
(check-expect (subset-sum '(5 9) 9) (list 9))
(check-expect (subset-sum '(5 9) 8) #false)
(check-expect (subset-sum '(5 9) 14) (list 5 9))
(check-expect (subset-sum '(-5 -9) -14) (list -5 -9))
(check-expect (subset-sum '(1 8 2 4) 7) (list 1 2 4))
(check-expect (subset-sum '(1 3 -2 9 2 5) 6) (list 1 3 2))
(check-expect (subset-sum '(1 3 -2 9 2 5 -8) -4) (list 1 3 -2 2 -8))
(check-expect (subset-sum '(15 22 14 26 32 9 16 8) 53) (list 15 22 16))
(check-expect (subset-sum '(15 22 14 26 32 9 16 8) 28) #false)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

#|
  A [TreeOf X] is one of
  - (make-empty-tree)
  - (make-node X [TreeOf X] [TreeOf X])
|#

(define-struct empty-tree [])
(define-struct node [data left right])

(define et (make-empty-tree))

;;;;; 6a

(define tr1 (make-node 5 et et))
(define tr2 (make-node 7 tr1 et))
(define tr3 (make-node 4 tr1 tr2))
(define tr4 (make-node 8
                       (make-node 9
                                  (make-node 8 et et)
                                  et)
                       (make-node 3
                                  et
                                  (make-node 2 et et))))
(define tr5 (make-node 3
                       (make-node 4 et et)
                       (make-node 1
                                  (make-node 6 et et)
                                  et)))
(define tr6 (make-node 7 tr4 tr5))

(check-expect (node-data tr4) 8)
(check-expect (node-data tr5) 3)
(check-expect (node-data tr6) 7)
(check-expect (node-data (node-left (node-right tr6))) 4)

;;;;; 6b

; tree-of? [X X -> Bool] X -> Bool
; (tree-of? rel? item) returns #true if and only if the node-data (item)
; satisfies the relational predicate throughout the whole tree

(define (tree-of? rel? item)
  (or (empty-tree? item)
      (and (node? item)
           (rel? (node-data item))
           (tree-of? rel? (node-left item))
           (tree-of? rel? (node-right item)))))

(define (x? any) #true)
(check-expect (tree-of? x? 5) #false)
(check-expect (tree-of? x? '()) #false)
(check-expect (tree-of? number? tr6) #true)
(check-expect (tree-of? string? tr6) #false)
(check-expect (tree-of? number? (make-node 1 2 3)) #false)
(check-expect
 (tree-of? number?
           (make-node 1 (make-node 'a tr4 (make-node 4 5 tr6)) tr5))
 #false)

;;;;; 6c

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

(check-expect (tree-of? string? tr7) #true)

;;;;; 6d

; leaf? : X -> Bool
; (leaf? item) returns #true if it is a leaf node, and #false otherwise

(define (leaf? item)
  (and (node? item)
       (empty-tree? (node-left item))
       (empty-tree? (node-right item))))

(check-expect (leaf? (make-leaf "green")) #true)
(check-expect (leaf? (node-left tr4)) #false)
(check-expect (leaf? (node-left (node-left tr4))) #true)
(check-expect (leaf? (node-right (node-left tr4))) #false)

;;;;; 6e

; tree-size: [TreeOf X] -> Nat
; (tree-size tree) returns the number of nodes in the tree

(define (tree-size tree)
  (cond
    [(empty-tree? tree) 0]
    [(node? tree) (+ 1 (tree-size (node-left tree))
                     (tree-size (node-right tree)))]))

(check-expect (tree-size (make-empty-tree)) 0)
(check-expect (tree-size (make-leaf 'a)) 1)
(check-expect (tree-size tr4) 5)
(check-expect (tree-size tr5) 4)
(check-expect (tree-size tr6) 10)

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

; height : [TreeOf X] -> Nat
; (height tree) returns the length of the longest node-to-leaf path in
; the given tree

(define (height tree)
  (cond
    [(empty-tree? tree) 0]
    [else (max (add1 (height (node-left tree)))
               (add1 (height (node-right tree))))]))

(check-expect (height (make-empty-tree)) 0)
(check-expect (height (make-leaf 5)) 1)
(check-expect (height (make-node 8 (make-empty-tree) (make-leaf 2))) 2)
(check-expect (height (make-node 8  (make-leaf 2) (make-empty-tree))) 2)
(check-expect (height tr4) 3)
(check-expect (height tr5) 3)
(check-expect (height tr6) 4)
(check-expect (height (make-node 0 (make-empty-tree) tr6)) 5)
(check-expect (height (make-node 0 tr6 (make-empty-tree))) 5)

;;;;;;;;;;;;;;;
;; Problem 8 ;;
;;;;;;;;;;;;;;;

;;;;; 8a

#|
  An [ExprOf X] is one of
  - X
  - (make-expr [[X X -> X] [ExprOf X] [ExprOf X]])
|#

(define-struct expr [op rand1 rand2])

(define e0 5)
(define e1 (make-expr + 3 4))
(define e2 (make-expr remainder 13 5))
(define e3 (make-expr - (make-expr + 2 3) (make-expr / 12 4)))
(define e4 (make-expr /
                      (make-expr +
                                 (make-expr * 2 6)
                                 (make-expr * 3 4))
                      (make-expr - 7 5)))

;;;;; 8b

; evaluate : [ExprOf X] -> X
; (evaluate expr) returns the result of evaluating the expr

(define (evaluate expr)
  (cond
    [(or (number? expr)
         (symbol? expr)
         (string? expr)
         (image? expr)) expr]
    [else ((expr-op expr) (evaluate (expr-rand1 expr))
                          (evaluate (expr-rand2 expr)))]))

(check-expect (evaluate e0) 5)
(check-expect (evaluate e1) 7)
(check-expect (evaluate e2) 3)
(check-expect (evaluate e3) 2)
(check-expect (evaluate e4) (/ (+ (* 2 6) (* 3 4)) (- 7 5)))
(check-expect (evaluate (make-expr (lambda (x y) (+ (* 10 x) y))
                                   e2
                                   e3))
              32)

(define ev1 (make-expr string-append
                       (make-expr string-append
                                  (make-expr string-append "age" "-")
                                  (make-expr string-append "of" "-"))
                       "wisdom"))
(define ev2
  (make-expr above
             (rectangle 200 50 'solid 'orange)
             (make-expr beside
                        (make-expr above
                                   (make-expr beside
                                              (square 50 'solid 'red)
                                              (square 50 'solid
                                                      'violet))
                                   (make-expr beside
                                              (square 50 'solid 'blue)
                                              (square 50 'solid
                                                      'green)))
                        (rectangle 100 100 'solid 'yellow))))

(check-expect (evaluate ev1) "age-of-wisdom")
(check-satisfied (evaluate ev2) image?)

;;;;; 8c

; flip-expr : [ExprOf X] -> [ExprOf X]
; (flip-expr expr) returns the expression formed by swapping each
; operator’s operands in the given expression

(define (flip-expr expr)
  (cond
    [(or (number? expr)
         (symbol? expr)
         (string? expr)
         (image? expr)) expr]
    [else (make-expr (expr-op expr)
                     (flip-expr (expr-rand2 expr))
                     (flip-expr (expr-rand1 expr)))]))

(check-expect (evaluate (flip-expr ev1)) "wisdom-of-age")
(check-satisfied (evaluate (flip-expr ev2)) image?)

;;;;;;;;;;;;;;;
;; Problem 9 ;;
;;;;;;;;;;;;;;;

;;;;; 9a

; infect-op : [X X -> X] Nat String -> [X X -> X]
; (infect-op op n message) takes three arguments: a binary operator, a
; positive integer n, and a message string. The return value is an
; operator that has been infected with a virus. This virus is activated
; when the operator is executed and causes strange behavior about 1 out
; of every n times. The rest of the time, the operator runs unaltered
; and produces the same result as before. In the altered state, it
; signals an error using the message given to infect-op, which halts
; the computation

(define (infect-op op n message)
  (lambda (x y)
    (if (= (random n) 0)
        (error message)
        op)))

(define op+ (infect-op + 4 "Gotcha!!"))
(define op+2 (infect-op + 1 "Gotcha!!"))

(check-error (op+2 2 3) "Gotcha!!")

;;;;; 9b

; infect-expr : [ExprOf X] Nat String -> [ExprOf X]
; (infect-expr expr n message) takes three arguments: an expression, a
; positive integer n, and a message string. The return value is an
; expression that appears to be the same as the given expression except
; that each operator has been infected with a virus, as specified by
; infect-op. The virus is activated when the operator is executed

(define (infect-expr expr n message)
  (cond
    [(number? expr) expr]
    [else (make-expr (infect-op (expr-op expr) n message)
                     (infect-expr (expr-rand1 expr) n message)
                     (infect-expr (expr-rand2 expr) n message))]))

(define ei3
  (make-expr + (make-expr - 5 3) (make-expr * 4 6)))
(define ei4 (infect-expr e3 10 "ILOVEYOU"))