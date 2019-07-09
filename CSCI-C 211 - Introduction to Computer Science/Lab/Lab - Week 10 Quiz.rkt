;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Lab - Week 10 Quiz|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; C211 Lab 10 Quiz

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 400)
(define SIZE 10)
(define WIDTH 400)

; A Type is one of:
; - 'square
; - 'circle
; - 'triangle

; A Color is one of:
; - 'green
; - 'red
; - 'yellow

; A Decoration is a (make-shape Type Color Posn)

(define-struct decoration [shape color coords])

; The initial world state
(define init-world 
  (list (make-decoration 'triangle 'green (make-posn 60 390)) 
        (make-decoration 'circle 'red (make-posn 186 91))))

; draw-world: WorldState -> Image
; (draw-world world-state) returns an image corresponding to
; world-state

(define (draw-world world-state)
  (cond
    [(empty? world-state) (empty-scene WIDTH HEIGHT)]
    [else (place-image (build-decoration (first world-state))
                       (posn-x (decoration-coords (first world-state)))
                       (posn-y (decoration-coords (first world-state)))
                       (draw-world (rest world-state)))]))

; build-decoration: Decoration -> Image
; (make-decoration dec) returns an image corresponding to dec

(define (build-decoration dec)
  (cond
    [(equal? (decoration-shape dec) 'square) 
     (rectangle SIZE SIZE "solid" (decoration-color dec))]
    [(equal? (decoration-shape dec) 'circle) 
     (circle SIZE "solid" (decoration-color dec))]
    [else (triangle SIZE "solid" (decoration-color dec))]))

; mouse-handler: WorldState Num Num MouseEvent -> WorldState
; (mouse-handler world-state x y me) returns world-state with one
; additional randomly selected decoration added to the front, in the
; case of a button press, or world-state unchanged on any other mouse
; event

(define (mouse-handler world-state x y me)
  (if (equal? me "button-down")
      (cons (make-decoration 
             (which-shape (random 3)) (which-color (random 3)) 
             (make-posn (random HEIGHT) (random WIDTH)))
            world-state)
      world-state))

; which-color: Nat -> Color
; (which color rand-num) returns the color associated with rand-num

(define (which-color rand-num)
  (cond
    [(zero? rand-num) 'green]
    [(= rand-num 1) 'red]
    [else 'yellow]))

; which-shape: Nat -> Type
; (which-shape rand-num) returns the shape associated with rand-num

(define (which-shape rand-num)
  (cond
    [(zero? rand-num) 'square]
    [(= rand-num 1) 'circle]
    [else 'triangle]))

; key-handler: WorldState KeyEvent -> WorldState
; (key-handler world-state ke) returns world-state with each decoration
; moved towards a corner, in the case of an up arrow, or world-state
; unchanged on any other key

(define (key-handler world-state ke)
  (if (equal? ke "up")
      (jump world-state)
      world-state))

; jump: WorldState -> WorldState
; (jump world-state) returns world-state with every item shifted SIZE
; pixels towards the  closest corner

(define (jump world-state)
  (cond
    [(empty? world-state) empty]
    [else 
     (cons (make-decoration (decoration-shape (first world-state)) 
                            (decoration-color (first world-state)) 
                            (shift-coords 
                             (decoration-coords (first world-state))))
           (jump (rest world-state)))]))

; shift-coords: Posn -> Posn
; (shift-coord coords) returns coords with the x and y value shifted by
; SIZE pixels towards the closest corner

(define (shift-coords coords)
  (cond
    [(and (< (posn-x coords) (/ WIDTH 2)) 
          (< (posn-y coords) (/ HEIGHT 2))) 
     (make-posn (- (posn-x coords) SIZE) (- (posn-y coords) SIZE))]
    [(and (> (posn-x coords) (/ WIDTH 2)) 
          (> (posn-y coords) (/ HEIGHT 2))) 
     (make-posn (+ (posn-x coords) SIZE) (+ (posn-y coords) SIZE))]
    [(> (posn-x coords) (/ WIDTH 2)) 
     (make-posn (+ (posn-x coords) SIZE) (- (posn-y coords) SIZE))]
    [else 
     (make-posn (- (posn-x coords) SIZE) (+ (posn-y coords) SIZE))]))
  
; tick-handler: WorldState -> WorldState
; (tick-handler world-state) returns world-state unchanged

(define (tick-handler world-state) world-state)

; create-world : Nat -> Image
; (create-world duration) handles all mouse and key events for the 
; specified time interval duration

(define (create-world duration)
  (big-bang init-world
            [to-draw draw-world]
            [on-tick tick-handler 1 duration]
            [on-mouse mouse-handler]
            [on-key key-handler]))

(create-world 60)