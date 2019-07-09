;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname a8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
  Made with DrRacket v6.4 where list? is a function. I expect to not be
  counted off for this due to the nature of the list? function being a
  built in function in DrRacket v6.4. There is no written description
  of this being some rule that i cannot update to a new version and
  take advantage of new functions that are built in. I have thouroughly
  read all the policies at
  https://cgi.soic.indiana.edu/~c211/spring16/policies.html and found
  installing a new version of racket doesn't violate any policies.

  Due to a recent dual-boot installation i had to wipe my drive. I was
  then only able to download DrRacket 6.4 and feel it unnecessary to
  revert to 6.3 and revert all of my prgoress on this assignment. I
  just realized this today when my friend couldn't use list? on DrRacket
  6.3

  If there is an issue please tell me in the grading notes to let me
  know not to use this function again. But as of now on March 8th, 2016
  their is no documentation aginsgt this action in the class. Thank you
|#

(require 2htdp/image)
(require 2htdp/universe)

(define handin "a8")
(define partner "Chris Canaday (crcanada)")
(define collaboration-statement
  (string-append "I worked with " partner "."))

(define SCENE-WIDTH 600)
(define SCENE-HEIGHT 500)

#|
  A Nat is one of
  - 0
  - (add1 Nat)

  A Whole is one of
  - 1
  - (add1 Whole)

  A Radius is a (make-radius [Whole Whole])
|#

(define-struct radius [initial-radius added-radius])

(define RADIUS (make-radius 30 0))

#|
   A ColorPool is one of
   - "red"
   - "orange"
   - "yellow"
   - "green"
   - "blue"
   - "indigo"
   - "violet"

  A NonEmptyList is one of
  - (cons Any '())
  - (cons Any NonEmptyList)

|#

(define
  COLOR-POOL
  (list "red"
        "orange" "yellow" "green" "blue" "indigo" "violet" "gold"))
(define LENGTH-POOL (length COLOR-POOL))

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
(check-random (pick-one COLOR-POOL) (pick-one COLOR-POOL))
(check-random (pick-one (range -8 24 3)) (pick-one (range -8 24 3)))

#|
  A Dot is a (make-dot [Color Nat Nat Nat)

  A ListOfDot is one of
  - '()
  - (cons Dot ListOfDot)
|#

(define-struct dot [color x y size])

(define d0 (make-dot "gold" 30 30 RADIUS))

(check-expect (dot? sd0) #false)
(check-expect (dot? d0) #true)
(check-expect (dot-x d0) 30)
(check-expect (dot-y d0) 30)
(check-expect (dot-size d0) RADIUS)

; dot->image : Dot -> Image
; (dot->image dot) returns the structure of a dot converted into an
; image

(define (dot->image dot)
  (circle (+ (radius-initial-radius (dot-size dot))
             (radius-added-radius (dot-size dot)))
          "solid" (dot-color dot)))

(check-satisfied (dot->image d0) image?)
(check-expect (image-width (dot->image d0)) 60)
(check-expect (image-width (dot->image d0)) 60)

#|
  A ShadowDot is a (make-dot [Color Nat Nat Nat String)

  A ListOfShadowDot is one of
  - '()
  - (cons ShadowDot ListOfShadowDot)
|#

(define-struct shadow-dot [color x y size shadow])

(define sd0 (make-shadow-dot "gold" 30 30 RADIUS "shadow"))

(check-expect (shadow-dot? d0) #false)
(check-expect (shadow-dot? sd0) #true)
(check-expect (shadow-dot-color sd0) "gold")
(check-expect (shadow-dot-x sd0) 30)
(check-expect (shadow-dot-y sd0) 30)
(check-expect (shadow-dot-size sd0) RADIUS)
(check-expect (shadow-dot-shadow sd0) "shadow")

#|
  A ListOfShadow&Dot is one of
  - '()
  - (cons Dot ListOfShadow&Dot)
  - (cons ShadowDot ListOfShadow&Dot)
|#

; remove-shadow-dot : ListOfShadow&Dot -> ListOfDots
; (remove-shadow-dot list-of-dots) returns the ListOfShadow&Dot with all
; the shadow dots removed

(define (remove-shadow-dot list-of-dots)
  (cond
    [(empty? list-of-dots) '()]
    [(shadow-dot? (first list-of-dots))
     (remove-shadow-dot (rest list-of-dots))]
    [else
     (cons
      (first list-of-dots) (remove-shadow-dot (rest list-of-dots)))]))

(define shadow-&-dot-list
  (list (make-shadow-dot "red" 30 30 RADIUS "shadow")
        (make-dot "gold" 100 100 RADIUS)))

(check-expect (remove-shadow-dot shadow-&-dot-list)
              (list (make-dot "gold" 100 100 RADIUS)))


; shadow-dot->image : ShadowDot -> Image
; (shadow-dot->image shadow-dot) returns the structure of a ShadowDot as
; an image

(define (shadow-dot->image shadow-dot)
  (circle (+ (radius-initial-radius (shadow-dot-size shadow-dot))
             (radius-added-radius (shadow-dot-size shadow-dot)))
          "outline" (shadow-dot-color shadow-dot)))

(check-satisfied (shadow-dot->image sd0) image?)
(check-expect (image-width (shadow-dot->image sd0)) 60)
(check-expect (image-height (shadow-dot->image sd0)) 60)

#|
  A ListWithLists is one of
  - (list ListOfShadow&Dot)
  - (cons ListOfShadow&Dot ListWithLists)

  A World is one of is a
  (make-world [Color Radius ListOfShadow&Dot ListOfDots])
|#

(define-struct world [dot-color dot-size visual-dots undone-dots])

(define w0
  (make-world "red"
              (make-radius (radius-initial-radius RADIUS) 0)
              (list (make-dot "red" 0 35 RADIUS))
              (list)))

(check-expect (world? w0) #true)

(define w0.1
  (make-world "red"
              (make-radius 30 -2)
              (list
               (make-shadow-dot "red" 394 7
                                (make-radius 30 0) "shadow")
               (make-dot "red" 0 35 (make-radius 30 0)))
              '()))

(check-expect (world? w0.1) #true)

(define w0.2
  (make-world "red"
              (make-radius 30 -2)
              (list
               (make-shadow-dot "red" 394 7
                                (make-radius 30 0) "shadow")
               (list (make-dot "red" 47 47 RADIUS))
               (make-dot "red" 0 35 (make-radius 30 0)))
              '()))

(check-expect (world? w0.2) #true)

(define w1
  (make-world "blue"
              (make-radius (radius-initial-radius RADIUS) 0)
              (list (make-dot "blue" 350 200 RADIUS)
                    (make-dot "red" 2 256 RADIUS)
                    (make-dot "green" 200 200 RADIUS)
                    (make-dot "gold" 350 100 RADIUS))
              (list (make-dot "red" 350 50 RADIUS)
                    (make-dot "yellow" 350 250 RADIUS))))

(check-expect (world? w1) #true)

(define w2
  (make-world "blue"
              (make-radius (radius-initial-radius RADIUS) 0)
              (list (make-dot "blue" 350 200 RADIUS)
                    (make-dot "red" 2 256 RADIUS)
                    (make-dot "green" 200 200 RADIUS)
                    (make-dot "gold" 350 100 RADIUS))
              (list (make-dot "red" 350 50 RADIUS)
                    (make-dot "yellow" 350 250 RADIUS)
                    (make-dot "green" 300 150 RADIUS)
                    (make-dot "orange" 20 276 RADIUS)
                    (make-dot "red" 200 200 RADIUS)
                    (make-dot "gold" 350 100 RADIUS)
                    (make-dot "blue" 350 200 RADIUS)
                    (make-dot "red" 2 256 RADIUS)
                    (make-dot "green" 219 210 RADIUS)
                    (make-dot "gold" 350 110 RADIUS))))

(check-expect (world? w2) #true)

(define w3
  (make-world "red"
              (make-radius (radius-initial-radius RADIUS) 0)
              (list (make-dot "red" 300 300 RADIUS)
                    (list (make-dot "red" 300 200 RADIUS)
                          (make-dot "red" 300 201 RADIUS)
                          (make-dot "red" 300 202 RADIUS)
                          (make-dot "red" 300 203 RADIUS)
                          (make-dot "red" 300 204 RADIUS)
                          (make-dot "red" 300 205 RADIUS)
                          (make-dot "red" 300 206 RADIUS)
                          (make-dot "red" 300 207 RADIUS)
                          (make-dot "red" 300 208 RADIUS)
                          (make-dot "red" 300 209 RADIUS)
                          (make-dot "red" 300 220 RADIUS)))
              (list)))

(define COLOR-BAR-HEIGHT (round (/ SCENE-HEIGHT 10)))
(define COLOR-BAR-WIDTH
  (round (* (/ SCENE-WIDTH LENGTH-POOL) LENGTH-POOL)))
(define COLOR-BAR-BLOCK-WIDTH (round (/ SCENE-WIDTH LENGTH-POOL)))

; color-pool-bar : ColorPool -> Image
; (color-pool-bar pool) returns an image with LENGTH-COLOR-POOL
; rectangles side by side with COLOR-BAR-BLOCK-WIDTH width and
; COLOR-BAR-HEIGHT height. The color of each rectangle corresponds to
; each color in the COLOR-POOL

(define (color-pool-bar pool)
  (cond
    [(empty? pool) empty-image]
    [else (beside
           (rectangle COLOR-BAR-BLOCK-WIDTH COLOR-BAR-HEIGHT "solid"
                      (first pool))
           (color-pool-bar (rest pool)))]))

(check-satisfied (color-pool-bar COLOR-POOL) image?)
(check-expect (image-width (color-pool-bar COLOR-POOL)) COLOR-BAR-WIDTH)
(check-expect (image-height (color-pool-bar COLOR-POOL))
              COLOR-BAR-HEIGHT)

(define BORDER 10)
(define WORK-SPACE-HEIGHT (- SCENE-HEIGHT COLOR-BAR-HEIGHT BORDER))
(define WORK-SPACE-WIDTH SCENE-WIDTH)

#|
  A ColorPoolBar is the image that corresponds to
  - (color-pool-bar COLOR-POOL)
|#

; highlight : ColorPoolBar World -> Image
; (highlight pool-bar world) returns the image with a white rectangle
; highlighting the selected color in the COLOR-POOL

(define (highlight pool-bar world)
  (cond
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 0))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 0)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 1))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 1)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 2))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 2)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 3))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 3)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 4))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 4)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 5))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 5)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 6))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 6)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [(equal? (world-dot-color world) (list-ref COLOR-POOL 7))
     (place-image/align
      (rectangle (- COLOR-BAR-BLOCK-WIDTH BORDER)
                 (- COLOR-BAR-HEIGHT BORDER)
                 "outline"
                 (pen "white" 2 "solid" "butt" "bevel"))
      (+ (/ BORDER 2) (round (* COLOR-BAR-BLOCK-WIDTH 7)))
      (round (/ BORDER 2))
      "left" "top"
      pool-bar)]
    [else pool-bar]))

(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "red" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "orange" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "yellow" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "green" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "blue" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "indigo" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "violet" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-satisfied (highlight (color-pool-bar COLOR-POOL)
                            (make-world "gold" RADIUS
                                        (list d0)
                                        (list))) image?)
(check-expect (highlight (color-pool-bar COLOR-POOL)
                            (make-world "silver" RADIUS
                                        (list d0)
                                        (list)))
              (color-pool-bar COLOR-POOL))

; work-space : World -> Image
; (work-space world) returns the black rectangle area of the world as an
; image with the dots also appearing as images within the black
; rectangle

(define (work-space world)
  (cond
    [(empty? (world-visual-dots world))
     (rectangle WORK-SPACE-WIDTH WORK-SPACE-HEIGHT "solid" "black")]
    [(shadow-dot? (first (world-visual-dots world)))
     (place-image/align
      (shadow-dot->image (first (world-visual-dots world)))
      (shadow-dot-x (first (world-visual-dots world)))
      (shadow-dot-y (first (world-visual-dots world)))
      "center" "center"
      (work-space (make-world
                   (world-dot-color world)
                   (world-dot-size world)
                   (rest (world-visual-dots world))
                   (world-undone-dots world))))]
    [(empty? (first (world-visual-dots world)))
     (work-space (make-world
                  (world-dot-color world)
                  (world-dot-size world)
                  (rest (world-visual-dots world))
                  (world-undone-dots world)))]
    [(list? (first (world-visual-dots world)))
     (place-image/align
      (dot->image (first (first (world-visual-dots world))))
      (dot-x (first (first (world-visual-dots world))))
      (dot-y (first (first (world-visual-dots world))))
      "center" "center"
      (work-space (make-world
                   (world-dot-color world)
                   (world-dot-size world)
                   (cons (rest (first (world-visual-dots world)))
                         (rest (world-visual-dots world)))
                   (world-undone-dots world))))]
    [else (place-image/align
           (dot->image (first (world-visual-dots world)))
           (dot-x (first (world-visual-dots world)))
           (dot-y (first (world-visual-dots world)))
           "center" "center"
           (work-space (make-world
                        (world-dot-color world)
                        (world-dot-size world)
                        (rest (world-visual-dots world))
                        (world-undone-dots world))))]))

(check-satisfied (work-space w0) image?)
(check-satisfied (work-space w0.1) image?)
(check-satisfied (work-space w0.2) image?)

; world->image : World -> Image
; (world->image world) returns the corresponding world into an image

(define (world->image world)
  (place-images/align
   (list (highlight (color-pool-bar COLOR-POOL) world)
         (work-space world))
   (list (make-posn 0 0)
         (make-posn 0 (+ COLOR-BAR-HEIGHT BORDER)))
   "left" "top"
   (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" "white")))

(check-satisfied (world->image w1) image?)
(check-satisfied (world->image w2) image?)
(check-satisfied (world->image w3) image?)
(check-satisfied (world->image w0) image?)
(check-satisfied (world->image w0.1) image?)
(check-satisfied (world->image w0.2) image?)

#|
   A KeyStroke is one of
   - "right"
   - "left"
|#

; key-handler : World KeyStroke -> World
; (key-handler world key) returns the world that has been modified by
; the corresponding key imput

(define (key-handler world key)
  (cond
    [(and (equal? key "r")
          (not (empty? (world-undone-dots world))))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (append (list (first (world-undone-dots world)))
                         (world-visual-dots world))
                 (rest (world-undone-dots world)))]
    [(and (equal? key "u")
          (not (empty? (world-visual-dots world)))
          (shadow-dot? (first (world-visual-dots world))))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (cons (first (world-visual-dots world))
                       (rest (rest (world-visual-dots world))))
                 (append (list
                          (first (remove-shadow-dot
                                  (world-visual-dots world))))
                         (world-undone-dots world)))]
    [(and (equal? key "u")
          (not (empty? (world-visual-dots world))))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (rest (world-visual-dots world))
                 (append (list (first (world-visual-dots world)))
                         (world-undone-dots world)))]
    [(and (equal? key "=")
          (shadow-dot? (first (world-visual-dots world))))
     (make-world (world-dot-color world)
                 (make-radius (radius-initial-radius
                               (world-dot-size world))
                              (+ (radius-added-radius
                                  (world-dot-size world))
                                 1))
                 (append
                  (list (make-shadow-dot
                         (world-dot-color world)
                         (shadow-dot-x
                          (first (world-visual-dots world)))
                         (shadow-dot-y
                          (first (world-visual-dots world)))
                         (make-radius
                          (radius-initial-radius
                           (world-dot-size world))
                          (+ (radius-added-radius
                              (world-dot-size world))
                             1))
                         "shadow"))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(equal? key "=") (make-world
                       (world-dot-color world)
                       (make-radius
                        (radius-initial-radius (world-dot-size world))
                        (+ (radius-added-radius (world-dot-size world))
                           1))
                       (world-visual-dots world)
                       (world-undone-dots world))]
    [(and (equal? key "-")
          (not (zero?
                (+ (radius-initial-radius (world-dot-size world))
                   (radius-added-radius (world-dot-size world)))))
          (shadow-dot? (first (world-visual-dots world))))
     (make-world (world-dot-color world)
                 (make-radius (radius-initial-radius
                               (world-dot-size world))
                              (- (radius-added-radius
                                  (world-dot-size world))
                                 1))
                 (append
                  (list (make-shadow-dot
                         (world-dot-color world)
                         (shadow-dot-x
                          (first (world-visual-dots world)))
                         (shadow-dot-y
                          (first (world-visual-dots world)))
                         (make-radius
                          (radius-initial-radius
                           (world-dot-size world))
                          (- (radius-added-radius
                              (world-dot-size world))
                             1))
                         "shadow"))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(and (equal? key "-")
          (not (zero?
                (+ (radius-initial-radius (world-dot-size world))
                   (radius-added-radius (world-dot-size world))))))
     (make-world (world-dot-color world)
                 (make-radius (radius-initial-radius
                               (world-dot-size world))
                              (- (radius-added-radius
                                  (world-dot-size world)) 1))
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [else world]))

(check-expect (world-visual-dots (key-handler w0 "r"))
              (append
               (world-undone-dots w0)
               (world-visual-dots w0)))
(check-expect (world? (key-handler w1 "r")) #true)
(check-expect (world? (key-handler w2 "r")) #true)
(check-expect (world? (key-handler w0 "u")) #true)
(check-expect (world? (key-handler w0.1 "u")) #true)
(check-expect (world? (key-handler w0.2 "u")) #true)
(check-expect (world? (key-handler w1 "u")) #true)
(check-expect (world? (key-handler w2 "u")) #true)
(check-expect (radius-added-radius (world-dot-size w0)) 0)
(check-expect (radius-added-radius
               (world-dot-size (key-handler w0 "=")))
              1)
(check-expect (world-visual-dots (key-handler w0.1 "="))
              (list (make-shadow-dot "red" 394 7 (make-radius 30 -1)
                                     "shadow")
                    (make-dot "red" 0 35 (make-radius 30 0))))
(check-expect (radius-added-radius
               (world-dot-size (key-handler w0 "-")))
              -1)
(check-expect (world-visual-dots (key-handler w0.1 "-"))
              (list (make-shadow-dot "red" 394 7 (make-radius 30 -3)
                                     "shadow")
                    (make-dot "red" 0 35 (make-radius 30 0))))

#|
  An Action is one of
  - "button-down"
  - "button-up"
  - "drag"
  - "move"
  - "enter"
  - "leave"
|#

; mouse-handler : World Nat Nat Action -> World
; (mouse-handler world mouse-x mouse-y mouse-event) returns ...

(define (mouse-handler world mouse-x mouse-y mouse-event)
  (cond
    [(and (<= mouse-x (round (/ SCENE-WIDTH LENGTH-POOL)))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 0)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 2 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 1)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 3 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 2)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 4 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 3)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 5 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 4)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 6 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 5)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 7 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 6)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (<= mouse-x (round (* 8 (/ SCENE-WIDTH LENGTH-POOL))))
          (<= mouse-y COLOR-BAR-HEIGHT)
          (or (equal? mouse-event "button-down")
              (equal? mouse-event "drag")))
     (make-world (list-ref COLOR-POOL 7)
                 (world-dot-size world)
                 (world-visual-dots world)
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "button-down"))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (append
                  (list
                   (make-dot
                    (world-dot-color world)
                    mouse-x
                    (- mouse-y (+ COLOR-BAR-HEIGHT BORDER))
                    (make-radius
                     (radius-initial-radius (world-dot-size world))
                     (radius-added-radius (world-dot-size world)))))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "button-up")
          (list? (first (world-visual-dots world))))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (cons (append
                        (first (world-visual-dots world))
                        (list (first (rest (world-visual-dots world)))))
                       (rest (rest (world-visual-dots world))))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "drag")
          (list? (first (remove-shadow-dot (world-visual-dots world)))))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (cons
                  (append (list
                           (make-dot
                            (world-dot-color world)
                            mouse-x
                            (- mouse-y (+ COLOR-BAR-HEIGHT BORDER))
                            (make-radius
                             (radius-initial-radius
                              (world-dot-size world))
                             (radius-added-radius
                              (world-dot-size world)))))
                          (first
                           (world-visual-dots world)))
                  (rest (remove-shadow-dot
                         (world-visual-dots world))))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "drag"))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (cons
                  (list (make-dot
                         (world-dot-color world)
                         mouse-x
                         (- mouse-y (+ COLOR-BAR-HEIGHT BORDER))
                         (make-radius
                          (radius-initial-radius
                           (world-dot-size world))
                          (radius-added-radius
                           (world-dot-size world)))))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "enter"))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (append
                  (list
                   (make-shadow-dot
                    (world-dot-color world)
                    mouse-x
                    (- mouse-y (+ COLOR-BAR-HEIGHT BORDER))
                    (make-radius
                     (radius-initial-radius (world-dot-size world))
                     (radius-added-radius (world-dot-size world)))
                    "shadow"))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "move"))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (append
                  (list
                   (make-shadow-dot
                    (world-dot-color world)
                    mouse-x
                    (- mouse-y (+ COLOR-BAR-HEIGHT BORDER))
                    (make-radius
                     (radius-initial-radius (world-dot-size world))
                     (radius-added-radius (world-dot-size world)))
                    "shadow"))
                  (remove-shadow-dot (world-visual-dots world)))
                 (world-undone-dots world))]
    [(and (>= mouse-y (+ COLOR-BAR-HEIGHT BORDER))
          (equal? mouse-event "leave"))
     (make-world (world-dot-color world)
                 (world-dot-size world)
                 (remove-shadow-dot (world-visual-dots world))
                 (world-undone-dots world))]
    [else world]))

(check-expect (world? (mouse-handler w0 1 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 51 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 101 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 151 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 201 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 251 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 301 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 351 1 "button-down")) #true)
(check-expect (world? (mouse-handler w0 351 50 "button-down")) #true)
(check-expect (world? (mouse-handler w0 351 50 "drag")) #true)
(check-expect (world? (mouse-handler w0 351 50 "enter")) #true)

; confetti : World -> World

(define (confetti world)
  (big-bang world
            [to-draw world->image]
            [on-key key-handler]
            [on-mouse mouse-handler]
            [name "Confetti"]))