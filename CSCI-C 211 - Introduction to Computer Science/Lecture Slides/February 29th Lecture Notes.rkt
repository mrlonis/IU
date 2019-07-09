;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |February 29th Lecture Notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "lecture-feb29")
(define team "yellow9")

"Happy Leap Year"

;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

;; Check out today's Doodle: http://www.google.com/

; leap : ListOfNat -> ListOfNat
; (leap bunnies) returns a ListOfNat that is the same as the input list
; with 29 between every occurence of 28 and 1

(define (leap bunnies)
  (cond
    [(empty? bunnies) '()]
    [(empty? (rest bunnies)) bunnies]
    [(and (= (first bunnies) 28)
          (= (second bunnies) 1))
     (cons (first bunnies) (cons 29 (leap (rest bunnies))))]
    [else (cons (first bunnies) (leap (rest bunnies)))]))

(check-expect (leap '()) '())
(check-expect (leap '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (leap '(28 1)) '(28 29 1))
(check-expect (leap '(28 1 28 1 28 1 28 1))
              '(28 29 1 28 29 1 28 29 1 28 29 1))
(check-expect (leap '(28)) '(28))
(check-expect (leap '(28 1 28)) '(28 29 1 28))

;;;;;;;;;;;;;;;;;;;
;; Problems 4 - 7
;;;;;;;;;;;;;;;;;;;

(define RADIUS 30)
(define SCENE-WIDTH 1000)
(define SCENE-HEIGHT 2000)

#|
   A Color is one of
   - "blue"
   - "green"

   A Dot is a (make-dot color x y)

   A World is one of
   - '()
   - (cons Dot '())
   - (cons world '())

   A KeyStroke is one of
   - "right"
   - "left"

|#

(define-struct dot [color x y])

;; Example worlds

(define w0 '())
(define w1
  (list (make-dot "blue" 100 200)
        (make-dot "green" 200 100)))
(define w2
  (list (make-dot "green" 174 78)
        (make-dot "blue" 99 248)
        (make-dot "green" 183 175)
        (make-dot "green" 358 86)
        (make-dot "blue" 117 92)
        (make-dot "green" 28 105)
        (make-dot "green" 172 246)
        (make-dot "blue" 168 289)
        (make-dot "blue" 204 19)
        (make-dot "blue" 387 161)
        (make-dot "green" 294 219)))

; dot->image : Dot -> Image

(define (dot->image dot)
  (circle RADIUS "solid" (dot-color dot)))

; world->image : World -> Image

(define (world->image world)
  (cond
    [(empty? world)
     (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" "black")]
    [else (place-image (dot->image (first world))
                       (dot-x (first world))
                       (dot-y (first world))        
                       (world->image (rest world)))]))

; key-handler : World KeyStroke -> World
(define (key-handler world key)
  (cond
    [(equal? key "right")
     (cons (make-dot (pick-one-at-random "blue" "green")
                     (random SCENE-WIDTH)
                     (random SCENE-HEIGHT))
           world)]
    [(and (equal? key "left") (not (empty? world)))
     (rest world)]
    [else world]))

; mouse-handler :

(define (mouse-handler world x y action)
  (cond
    [(equal? action "button-down")
     (cons (make-dot (pick-one-at-random "gold" "silver") x y) world)]
    [else world]))
 
; sprinkle : World -> World
(define (sprinkle world)
  (big-bang world
            [to-draw world->image]
            [on-key key-handler]
            [on-mouse mouse-handler]
            [name "Sprinkle"]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Something borrowed...

; pick-one-at-random : Any Any -> Any
; (pick-one-at-random this that) returns either this or that, selected
; at random and with equal probability

(define (pick-one-at-random this that)
  (if (zero? (random 2))
      this
      that))