;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Draw) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Point is a (make-point Number Number)
(define-struct point (x y))

; A Circle is a (make-circl Point Number)
(define-struct circl (center radius))

; A ManyCircl is one of:
;   -- empty

;   -- (cons Circle ManyCircl)

; A World is a ManyCircl 

; (big-bang initial
;           (to-draw ...)
;           (on-tick ...)
;           (on-mouse ...))

(define initial empty)

; render : World -> Image
; (define (render world)
;   (cond ((empty? world) ...)
;         (else (... (first world) ... (render (rest world)) ...))))
(define (render world)
  (cond ((empty? world) (empty-scene 400 400))
        (else (place-image (circle (circl-radius (first world)) "outline" "red")
                           (point-x (circl-center (first world)))
                           (point-y (circl-center (first world)))
                           (render (rest world))))))

(define sample-world (cons (make-circl (make-point 300 300) 30) 
                      (cons (make-circl (make-point 200 100) 80)
                       (cons (make-circl (make-point  50  50) 10) empty))))

; enlarge : circl -> circl
; increases the radius by 1 pixel 
(define (enlarge circl)
  (make-circl (circl-center circl) (add1 (circl-radius circl))))

; update : world -> world
; 
(define (update world)
  (cond ((empty? world) world)
        (else (cons (enlarge (first world))
                    (update (rest world))))))

; meh : world x y event -> world
; 
(define (meh world x y event)
  (cond ((mouse=? "button-down" event) 
         (cons (make-circl (make-point x y) 1)
               world))
        (else world)))

(big-bang sample-world
          (to-draw render)
          (on-tick update)
          (on-mouse meh))