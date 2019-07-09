;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Lab - Week 7|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab7")

;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

(define NUM-FLOORS 20)

;;;;; 1b

#|
  A Direction is one of:
  - 'up
  - 'down
|#

;;;;; 1c

; direction? : Any -> Bool
; (direction? dir) returns #true iff the input is a Direction

(define (direction? dir)
  (or (equal? dir 'up)
      (equal? dir 'down)))

(check-expect (direction? 'up) #true)
(check-expect (direction? 'down) #true)
(check-expect (direction? 'left) #false)

;;;;; 1d

#|
  A ListOfDirection is one of:
  - '()
  - (cons Direction '())
|#

;;;;; 1e

; list-of-direction? : Any -> Bool
; (list-of-direction? dir-list) returns #true iff the input is a
; ListOfDirection

(define (list-of-direction? dir-list)
  (cond
    [(empty? dir-list) #true]
    [else (and (direction? (first dir-list))
               (list-of-direction? (rest dir-list)))]))

(check-expect (list-of-direction? (list 'up 'up 'up 'down)) #true)
(check-expect (list-of-direction? (list 'up 'left 'up 'down)) #false)

;;;;; 1f

#|
  A Floor is an Int in the interval [1..NUM-FLOORS]
|#

;;;;; 1g

; floor? : Any -> Bool
; (floor? dir) returns #true iff the input is a Floor

(define (floor? floor)
  (and (integer? floor)
       (>= floor 1)
       (<= floor NUM-FLOORS)))

(check-expect (floor? 1) #true)
(check-expect (floor? 20) #true)
(check-expect (floor? 10) #true)
(check-expect (floor? 0) #false)
(check-expect (floor? 21) #false)

;;;;; 1h

#|
  A ListOfFloor is one of:
  - '()
  - (cons Floor '())
|#

;;;;; 1i

; list-of-floor? : Any -> Bool
; (list-of-direction? dir-list) returns #true iff the input is a
; ListOfFloor

#|
(define (list-of-floor? floor-list)
  (cond
    [(empty? floor-list) #true]
    [(= (length floor-list) 1) (floor? (first floor-list))]
    [(equal? (first floor-list) (second floor-list)) #false]
    [else (and (floor? (first floor-list))
               (list-of-floor? (rest floor-list)))]))
|#

(define (list-of-floor? floor-list)
  (or (empty? floor-list)
      (and
       (floor? (first floor-list))
       (or (empty? (rest floor-list))
           (not (equal? (first floor-list) (second floor-list))))
       (list-of-floor? (rest floor-list)))))

(check-expect
 (list-of-floor?
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
 #true)
(check-expect (list-of-floor? (list 'up 'left 'up 'down)) #false)
(check-expect (list-of-floor? (list 1 1 2 3 4 4 5)) #false)
(check-expect (list-of-floor? null) #true)

;;;;; 1j

#|
  A NonEmpty-ListOfFloor is one of:
  - (cons Floor '())
  - (cons Floor NonEmpty-ListOfFloor)
|#

;;;;; 1k

; ride-elevator : NonEmpty-ListOfFloor -> ListOfDirection
; (ride-elevator ls) returns a ListOfDirections that the elevator would
; travel to visit each of the floors in order

(define (ride-elevator ls)
  (cond
    [(= (length ls) 1) '()]
    [(<= (first ls) (second ls))
     (cons 'up (ride-elevator (rest ls)))]
    [(>= (first ls) (second ls))
     (cons 'down (ride-elevator (rest ls)))]))

(check-expect (ride-elevator (list 3 1 2)) (list 'down 'up))
(check-expect (ride-elevator (list 3)) (list))
(check-expect (ride-elevator (list 3 7 20 1)) (list 'up 'up 'down))