;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname a7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "a7")
(define collaboration-statement "I worked alone")

; logical constants
(define WIDTH 7)    ; the number of blocks horizontally
(define HEIGHT 10)  ; the number of blocks vertically

; graphical constants
(define BLOCK-SIZE 50)  ; size of a rendered block (blocks are square)
(define SCENE-WIDTH (* WIDTH BLOCK-SIZE))      ; scaled width of scene
(define SCENE-HEIGHT (* HEIGHT BLOCK-SIZE))    ; scaled height of scene

; pool of possible block colors
(define POOL
  (list "red" "orange" "yellow" "green" "blue" "indigo" "violet"))

#|
   A Hue is a Color in POOL
 
   A Block is a (make-block [1..HEIGHT] [1..WIDTH] Hue)
 
   A Landscape is one of:
   – '()
   – (cons Block Landscape)
 
   A World is a (make-world Block Landscape)

   A Scene is an (empty-scene SCENE-WIDTH SCENE-HEIGHT)
|#

(define-struct block [row col color])
(define-struct world [piece land])

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

(define w0
  (make-world (make-block 1 4 "indigo")
              (list (make-block (sub1 HEIGHT) 2 "red")
                    (make-block HEIGHT 1 "green")
                    (make-block HEIGHT 2 "blue")
                    (make-block HEIGHT WIDTH "yellow"))))

(define w1
  (make-world (make-block 3 6 "red")
              (list (make-block 6 4 "green")
                    (make-block 7 4 "blue")
                    (make-block 8 3 "orange")
                    (make-block 8 4 "green")
                    (make-block 9 3 "violet")
                    (make-block 9 4 "yellow")
                    (make-block 9 7 "indigo")
                    (make-block 10 1 "red")
                    (make-block 10 2 "red")
                    (make-block 10 3 "red")
                    (make-block 10 4 "red")
                    (make-block 10 5 "red")
                    (make-block 10 7 "red"))))

(define w2
  (make-world (make-block 1 4 "green")
              (list (make-block 2 4 "yellow")
                    (make-block 3 4 "indigo")
                    (make-block 4 4 "orange")
                    (make-block 5 4 "indigo")
                    (make-block 6 3 "yellow")
                    (make-block 6 4 "indigo")
                    (make-block 7 1 "blue")
                    (make-block 7 3 "green")
                    (make-block 7 4 "green")
                    (make-block 8 1 "violet")
                    (make-block 8 3 "indigo")
                    (make-block 8 4 "blue")
                    (make-block 8 7 "yellow")
                    (make-block 9 1 "orange")
                    (make-block 9 2 "red")
                    (make-block 9 3 "indigo")
                    (make-block 9 4 "green")
                    (make-block 9 5 "indigo")
                    (make-block 9 7 "green")
                    (make-block 10 1 "yellow")
                    (make-block 10 2 "blue")
                    (make-block 10 3 "yellow")
                    (make-block 10 4 "violet")
                    (make-block 10 5 "red")
                    (make-block 10 6 "yellow")
                    (make-block 10 7 "red"))))

(check-expect (block-color (world-piece w2)) "green")
(check-expect (length (world-land w2)) 26)

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;;;;; 2a

#|
  A Speed is one of:
  - 'slow
  - 'medium
  - 'fast
|#

;;;;; 2b

#|
  A FrameRate is in the interval (0..1]
|#

; speed->rate : Speed -> FrameRate
; (speed->rate speed) returns a FrameRate corresponding to the Speed
; input

(define (speed->rate speed)
  (cond
    [(equal? speed 'slow) 1]
    [(equal? speed 'medium) .6]
    [(equal? speed 'fast) .2]
    [else (error "See Problem 2b")]))

(check-expect (speed->rate 'slow) 1)
(check-within (speed->rate 'medium) .6 0.1)
(check-within (speed->rate 'fast) .2 0.1)
(check-error (speed->rate 'SuperFast) "See Problem 2b")

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

;;;;; 3a

; horizontal-line : Num -> Img
; (horizontal-line x) produces a horizontal line with width x and
; a height of 1

(define (horizontal-line x)
  (rectangle x 1 "solid" "black"))

(check-expect (image-width (horizontal-line 100)) 100)
(check-expect (image-height (horizontal-line 100)) 1)
(check-expect (image-width (horizontal-line 200)) 200)
(check-expect (image-height (horizontal-line 200)) 1)
(check-expect (image-width (horizontal-line 150)) 150)
(check-expect (image-height (horizontal-line 150)) 1)
(check-expect (image-width (horizontal-line 300)) 300)
(check-expect (image-height (horizontal-line 300)) 1)

; vertical-line : Num -> Img
; (vertical-line x) produces a vertical line with width 1 and
; a height of x

(define (vertical-line x)
  (rectangle 1 x "solid" "black"))

(check-expect (image-width (vertical-line 30)) 1)
(check-expect (image-height (vertical-line 30)) 30)
(check-expect (image-width (vertical-line 60)) 1)
(check-expect (image-height (vertical-line 60)) 60)
(check-expect (image-width (vertical-line 45)) 1)
(check-expect (image-height (vertical-line 45)) 45)

; add-frame : Block -> Img
; (add-frame image) adds black lines around the border of a Block

(define (add-frame block)
  (beside/align
   "middle"
   (vertical-line BLOCK-SIZE)
   (above/align "middle" (horizontal-line (- BLOCK-SIZE 2))
                (square (- BLOCK-SIZE 2) "solid" (block-color block))
                (horizontal-line (- BLOCK-SIZE 2)))
   (vertical-line BLOCK-SIZE)))

(check-expect (image-width
               (add-frame (make-block 1 2 "violet"))) BLOCK-SIZE)
(check-expect (image-height
               (add-frame (make-block 1 2 "violet"))) BLOCK-SIZE)

(check-expect (image-width
               (add-frame (make-block 8 3 "yellow"))) BLOCK-SIZE)
(check-expect (image-height
               (add-frame (make-block 8 3 "yellow"))) BLOCK-SIZE)

; block->image : Block -> Image
; (block->image block) returns a solid square of dimension BLOCK-SIZE
; filled in with the block's color and surrounded by a black outline

(define (block->image block)
  (add-frame block))

(check-satisfied (block->image (make-block 1 2 "violet")) image?)
(check-satisfied (block->image (make-block 8 3 "yellow")) image?)
(check-expect
 (- (image-height (block->image (make-block 8 3 "yellow"))) BLOCK-SIZE)
 0)
(check-expect
 (- (image-width (block->image (make-block 8 3 "yellow"))) BLOCK-SIZE)
 0)

;;;;; 3b

; place-block : Block Scene -> Img
; (place-block block scene) takes a Block and an Image representing the
; state of the world, and returns the result of placing the block on
; the scene at the block’s grid coordinates

(define (place-block block scene)
  (place-image/align (block->image block)
                     (- (* (block-col block) BLOCK-SIZE) BLOCK-SIZE)
                     (- (* (block-row block) BLOCK-SIZE) BLOCK-SIZE)
                     "left" "top"
                     scene))

(check-satisfied (place-block (make-block 1 2 "blue")
                              (empty-scene SCENE-WIDTH SCENE-HEIGHT))
                 image?)
(check-satisfied
 (place-block
  (make-block 1 2 "blue")
  (place-block
   (make-block 8 3 "yellow")
   (place-block
    (make-block 9 3 "indigo")
    (place-block
     (make-block 10 3 "red")
     (place-block
      (make-block 10 6 "yellow")
      (place-block
       (make-block 10 4 "orange")
       (empty-scene SCENE-WIDTH SCENE-HEIGHT)))))))
 image?)

;;;;; 3c

; world->image-helper : Landscape -> Image
; (world->image-helper landscape) returns an result of running
; place-block on the Landscape of a World

(define (world->image-helper landscape)
  (cond
    [(empty? landscape) (empty-scene SCENE-WIDTH SCENE-HEIGHT)]
    [else (place-block (first landscape)
                       (world->image-helper (rest landscape)))]))

; world->image : World -> Image
; (world->image world) returns the corresponding image of a World

(define (world->image world)
  (place-block
   (world-piece world) (world->image-helper (world-land world))))

(check-satisfied (world->image w0) image?)
(check-satisfied (world->image w1) image?)
(check-satisfied (world->image w2) image?)

;;;;;;;;;;;;;;;
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;;;;; 4a

#|
  A Direction is one of:
  - "left"
  - "right"
  - "down"
|#

;;;;; 4b

; next-block : Block Direction -> Block
; (next-block block dir) returns a Block that is the result of moving
; the Block in the indicated Direction, if possible

(define (next-block block dir)
  (cond
    [(and (equal? dir "down")
          (not (= (block-row block) HEIGHT)))
     (make-block (+ 1 (block-row block)) (block-col block)
                 (block-color block))]
    [(and (equal? dir "right")
          (not (= (block-col block) WIDTH)))
     (make-block (block-row block) (+ 1 (block-col block))
                 (block-color block))]
    [(and (equal? dir "left")
          (not (= (block-col block) 1)))
     (make-block (block-row block) (- (block-col block) 1)
                 (block-color block))]
    [else block]))

(define b1 (make-block 5 4 "yellow"))
(check-expect (next-block b1 "down") (make-block 6 4 "yellow"))
(check-expect (next-block b1 "left") (make-block 5 3 "yellow"))
(check-expect (next-block b1 "right") (make-block 5 5 "yellow"))
(check-expect (next-block b1 "up") (make-block 5 4 "yellow"))
(define b2 (make-block 10 7 "red"))
(check-expect (next-block b2 "down") (make-block 10 7 "red"))
(check-expect (next-block b2 "right") (make-block 10 7 "red"))
(define b3 (make-block 5 1 "blue"))
(check-expect (next-block b3 "left") (make-block 5 1 "blue"))
(check-expect (next-block b3 "right") (make-block 5 2 "blue"))
(check-expect (next-block (make-block 1 1 "red") "down")
              (make-block 2 1 "red"))
(check-expect (next-block (make-block 10 7 "green") "down")
              (make-block 10 7 "green"))
(check-expect (next-block (make-block 1 1 "red") "left")
              (make-block 1 1 "red"))
(check-expect (next-block (make-block 10 7 "green") "left")
              (make-block 10 6 "green"))
(check-expect (next-block (make-block 1 1 "red") "right")
              (make-block 1 2 "red"))
(check-expect (next-block (make-block 1 1 "red") "up")
              (make-block 1 1 "red"))

;;;;; 4c

; same-location? Block Block -> Boolean
; (smae-location? b1 b2) returns #true iff the two Blocks have the same
; location

(define (same-location? b1 b2)
  (and (= (block-row b1) (block-row b2))
       (= (block-col b1) (block-col b2))))  

(check-expect (same-location? (make-block 2 7 "red")
                              (make-block 2 7 "green")) #true)
(check-expect (same-location? (make-block 3 7 "red")
                              (make-block 2 7 "green")) #false)

;;;;; 4d

; exists? : Block Landscape -> Boolean
; (exists? block landscape) returns #true iff the Block has the same
; location as some other Block in the Landscape

(define (exists? block landscape)
  (cond
    [(empty? landscape) #false]
    [(same-location? block (first landscape)) #true]
    [else (exists? block (rest landscape))]))

(check-expect (exists? (make-block 2 7 "red")
                       (list (make-block 3 7 "green")
                             (make-block 2 7 "yellow")
                             (make-block 7 2 "red")
                             (make-block 5 4 "blue")))
              #true)
(check-expect (exists? (make-block 2 7 "red")
                       (list (make-block 3 7 "green")
                             (make-block 4 7 "yellow")
                             (make-block 7 2 "red")
                             (make-block 5 4 "blue")))
              #false)

;;;;; 4e

; at-rest? : Block Landscape -> Bool
; (at-rest? block landscape) returns #true iff the Block cannot
; move any further down

(define (at-rest? block landscape)
  (cond
    [(= HEIGHT (block-row block)) #true]
    [(empty? landscape) #false]
    [(same-location? (next-block block "down")
                     (first landscape)) #true]
    [else (at-rest? block (rest landscape))]))

(check-expect (at-rest? (world-piece w0) (world-land w0)) #false)
(check-expect (at-rest? (world-piece w1) (world-land w1)) #false)
(check-expect (at-rest? (world-piece w2) (world-land w2)) #true)
(check-expect (at-rest? (make-block 10 7 "red")
                        (list (make-block 10 1 "green"))) #true)
(check-expect (at-rest? (make-block 10 7 "red")
                        (list)) #true)

;;;;;;;;;;;;;;;
;; Problem 5 ;;
;;;;;;;;;;;;;;;

;;;;; 5a

#|
  A NonEmptyList is one of:
  - '(Any)
  - '(NonEmptyList)
|#

;;;;; 5b

; pick-one : NonEmptyList -> Any
; (pick-one non-empty-list) returns an element of the list selected at
; random and with equal probability

(define (pick-one non-empty-list)
  (cond
    [(= (length non-empty-list) 1) (first non-empty-list)]
    [(= (random (length non-empty-list))
        (- (length non-empty-list) 1))
     (first non-empty-list)]
    [else (pick-one (rest non-empty-list))]))

(check-random (pick-one '(me)) (pick-one '(me)))
(check-random (pick-one POOL) (pick-one POOL))
(check-random (pick-one (range -8 24 3)) (pick-one (range -8 24 3)))

; probe : Nat List Any -> Nat
; (probe n list list-item) returns the number of times that an item in
; a list is returned when pick-one is performed on a list

(define (probe n list list-item)
  (cond
    [(zero? n) 0]
    [(equal? (pick-one list)
             list-item)
     (add1 (probe (sub1 n) list list-item))]
    [else
     (probe (sub1 n) list list-item)]))

(check-within (probe 7000 POOL "red") 1000 100)
(check-within (probe 7000 POOL "orange") 1000 100)
(check-within (probe 7000 POOL "yellow") 1000 100)
(check-within (probe 7000 POOL "green") 1000 100)
(check-within (probe 7000 POOL "blue") 1000 100)
(check-within (probe 7000 POOL "indigo") 1000 100)
(check-within (probe 7000 POOL "violet") 1000 100)

;;;;; 5c

#|
  A LegalRow is one in the interval [1..HEIGHT]
|#

; make-piece : LegalRow -> Block
; (make-piece row) returns a Block positioned in the center of the
; given row with a randomly selected Hue

(define (make-piece row)
  (make-block row 4 (pick-one POOL)))

(check-random (make-piece 1) (make-piece 1))
(check-random (make-piece 2) (make-piece 2))
(check-random (make-piece 3) (make-piece 3))
(check-expect (block-row (make-piece 1)) 1)
(check-expect (block-col (make-piece 1)) 4)

;;;;;;;;;;;;;;;
;; Problem 6 ;;
;;;;;;;;;;;;;;;

;;;;; 6a

#|
|#

; row-full? : Landscape LegalRow -> Landscape
; (row-full? landscape row) returns a new Landscape based on the old
; Landscape (the input) that contains only Blocks that are in the given
; row

(define (row-full? landscape row)
  (cond
    [(empty? landscape) '()]
    [(= (block-row (first landscape)) row)
     (cons (first landscape)
           (row-full? (rest landscape) row))]
    [else (row-full? (rest landscape) row)]))

(check-expect (row-full? (world-land w0) HEIGHT)
              (list (make-block 10 1 "green")
                    (make-block 10 2 "blue")
                    (make-block 10 7 "yellow")))

; bottom-row-full? : Landscape -> Boolean
; (bottom-row-full? landscape) returns #true iff the bottom row of a
; Landscape is full of Blocks

(define (bottom-row-full? landscape)
  (= (length (row-full? landscape HEIGHT)) 7))

(check-expect (bottom-row-full? (world-land w0)) #false)
(check-expect (bottom-row-full? (world-land w1)) #false)
(check-expect (bottom-row-full? (world-land w2)) #true)
(check-expect (bottom-row-full?
               (cons (make-block 10 6 "green") (world-land w1))) #true)

;;;;; 6b

; remove-bottom-row : Landscape -> Landscape
; (remove-bottom-row landscape) returns the input Landscape with every
; Block on the bottom row removed

(define (remove-bottom-row landscape)
  (cond
    [(empty? landscape) '()]
    [(= (block-row (first landscape)) HEIGHT)
     (remove-bottom-row (rest landscape))]
    [else (cons (first landscape)
                (remove-bottom-row (rest landscape)))]))

(check-expect (remove-bottom-row (world-land w0))
              (list (make-block 9 2 "red")))
(check-expect (length (remove-bottom-row (world-land w1))) 7)
(check-expect (length (remove-bottom-row (world-land w2))) 19)

;;;;; 6c

; compress : World -> World
; (compress world) takes a World and either returns it unchanged, if a
; compression is not possible, or in the case that the bottom row is
; full, it returns the World that results from removing the Blocks on
; the bottom and then dropping all Blocks above the bottom by one row.

(define (compress world)
  (cond
    [(bottom-row-full? (world-land world))
     (make-world (world-piece world)
                 (compress-helper
                  (remove-bottom-row (world-land world))))]
    [else world]))

(check-expect (length (world-land w1)) 13)
(check-expect (length (world-land (compress w1))) 13)
(check-satisfied (world->image (compress w1)) image?)
(check-expect (length (world-land w2)) 26)
(check-expect (length (world-land (compress w2))) 19)
(check-satisfied (world->image (compress w2)) image?)

; compress-helper : Landscape -> Landscape
; (compress-helper landscape) returns the Landscape that is the input as
; a new Landscape with all the Blocks shifted downwards

(define (compress-helper landscape)
  (cond
    [(empty? landscape) '()]
    [else (cons (next-block (first landscape) "down")
                (compress-helper (rest landscape)))]))

(check-expect (compress-helper (list (make-block 1 3 "red")))
              (list (make-block 2 3 "red")))

;;;;;;;;;;;;;;;
;; Problem 7 ;;
;;;;;;;;;;;;;;;

;;;;; 7a

; game-over? : World -> Boolean
; (game-over? world) takes a World and returns #true if the piece is at
; rest in the middle of the top row, and #false otherwise

(define (game-over? world)
  (cond
    [(and (at-rest? (world-piece world) (world-land world))
          (= (block-row (world-piece world)) 1))
          #true]
    [else #false]))

(check-expect (game-over? w0) #false)
(check-expect (game-over? w1) #false)
(check-expect (game-over? w2) #true)

;;;;; 7b

; tick-handler-helper : World -> World
; (tick-handler-helper world) takes a World and returns a World that
; results after one tick of the clock

(define (tick-handler-helper world)
  (cond
    [(game-over? world) world]
    [(at-rest? (world-piece world)
               (world-land world))
     (make-world (make-piece 1)
                 (cons (world-piece world)
                       (world-land world)))]
     [(at-rest? (next-block (world-piece world) "down")
               (world-land world))
     (make-world (make-piece 1)
                 (cons (next-block (world-piece world) "down")
                       (world-land world)))]
    [else (make-world (next-block (world-piece world) "down")
                      (world-land world))]))

; tick-handler : World -> World
; (tick-handler world) takes a World and returns the World that results
; after one tick of the clock

(define (tick-handler world)
  (tick-handler-helper (compress world)))


(check-expect (tick-handler w0)
              (make-world
               (make-block 2 4 "indigo")
               (list
                (make-block 9 2 "red")
                (make-block 10 1 "green")
                (make-block 10 2 "blue")
                (make-block 10 7 "yellow"))))
(check-expect (tick-handler w1)
              (make-world (make-block 4 6 "red")
                          (list (make-block 6 4 "green")
                                (make-block 7 4 "blue")
                                (make-block 8 3 "orange")
                                (make-block 8 4 "green")
                                (make-block 9 3 "violet")
                                (make-block 9 4 "yellow")
                                (make-block 9 7 "indigo")
                                (make-block 10 1 "red")
                                (make-block 10 2 "red")
                                (make-block 10 3 "red")
                                (make-block 10 4 "red")
                                (make-block 10 5 "red")
                                (make-block 10 7 "red"))))
(check-random (tick-handler w2)
              (make-world (make-piece 1)
                          (list (make-block 2 4 "green")
                                (make-block 3 4 "yellow")
                                (make-block 4 4 "indigo")
                                (make-block 5 4 "orange")
                                (make-block 6 4 "indigo")
                                (make-block 7 3 "yellow")
                                (make-block 7 4 "indigo")
                                (make-block 8 1 "blue")
                                (make-block 8 3 "green")
                                (make-block 8 4 "green")
                                (make-block 9 1 "violet")
                                (make-block 9 3 "indigo")
                                (make-block 9 4 "blue")
                                (make-block 9 7 "yellow")
                                (make-block 10 1 "orange")
                                (make-block 10 2 "red")
                                (make-block 10 3 "indigo")
                                (make-block 10 4 "green")
                                (make-block 10 5 "indigo")
                                (make-block 10 7 "green"))))
(check-random (tick-handler (make-world (make-block 10 4 "red")
                                        '()))
              (make-world (make-piece 1)
                          (list (make-block 10 4 "red"))))

;;;;; 7c

; key-handler : World Direction -> World
; (key-handler world dir) takes a World and a Direction dir, and
; returns the World that results from attempting to move the tetris
; piece in the indicated direction

(define (key-handler world dir)
  (cond
    [(at-rest? (world-piece world) (world-land world)) world]
    [(and (equal? dir "left")
          (not (exists? (next-block (world-piece world) "left")
                        (world-land world))))
     (make-world (next-block (world-piece world) "left")
                 (world-land world))]
    [(and (equal? dir "right")
          (not (exists? (next-block (world-piece world) "right")
                        (world-land world))))
     (make-world (next-block (world-piece world) "right")
                 (world-land world))]
    [(and (equal? dir "down")
          (not (exists? (next-block (world-piece world) "down")
                        (world-land world))))
     (make-world (next-block (world-piece world) "down")
                 (world-land world))]
    [else world]))

(check-expect (key-handler w0 "left")
              (make-world (make-block 1 3 "indigo")
                          (list (make-block (sub1 HEIGHT) 2 "red")
                                (make-block HEIGHT 1 "green")
                                (make-block HEIGHT 2 "blue")
                                (make-block HEIGHT WIDTH "yellow"))))
(check-expect (key-handler w0 "right")
              (make-world (make-block 1 5 "indigo")
                          (list (make-block (sub1 HEIGHT) 2 "red")
                                (make-block HEIGHT 1 "green")
                                (make-block HEIGHT 2 "blue")
                                (make-block HEIGHT WIDTH "yellow"))))
(check-expect (key-handler w0 "down")
              (make-world (make-block 2 4 "indigo")
                          (list (make-block (sub1 HEIGHT) 2 "red")
                                (make-block HEIGHT 1 "green")
                                (make-block HEIGHT 2 "blue")
                                (make-block HEIGHT WIDTH "yellow"))))
(check-expect (key-handler w0 "up") w0)

;;;;; 7d

; tetris : Speed -> World
; (tetris speed) returns an World that is the result of animating a
; world at a rate corresponding to Speed

(define (tetris speed)
  (big-bang (make-world (make-piece 1) '())
            [to-draw world->image]
            [on-tick tick-handler (speed->rate speed)]
            [on-key key-handler]
            [stop-when game-over?]
            [name "Simple Tetris"]))