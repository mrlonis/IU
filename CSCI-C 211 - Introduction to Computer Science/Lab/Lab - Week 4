;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab - Week 4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab4")
(define collaboration-statement "I worked with Nova Richa (novricha")
(define partner "Nova Richa (novricha")

#|
   Restaurant
   - Address : (No. Stree-Name City State ZipCode)
   - Name : 'Symbol or "String"
   - Dish : 'Symbol or "String"
|#

; An Address is a (make-address Nat String String Nat)

(define-struct address [number street-name unit-num city state zipcode])

; address? : Any -> Bool
; address-number : Address -> Nat
; address-street-name : Address -> String

; A Restaurant is a (make-restaurant Address String String)

(define-struct restaurant [address name dish])

; process-address : Address -> ...

(define (process-address an-address)
  (... (address-number an-address) ...
       (address-street-name an-address) ...
       (address-unit-num an-address) ...
       (address-city an-address) ...
       (address-state an-address) ...
       (address-zipcode an-address) ...))

; address->string : Address -> String

(define (address->string address1)
  [cond
    [(equal? (address-unit-num address1) "")
     (string-append (number->string (address-number address1))
                    " "
                    (address-street-name address1)
                    ", "
                    (address-city address1)
                    ", "
                    (address-state address1)
                    " "
                    (number->string (address-zipcode address1)))]
    [(>= (string-length (address-unit-num address1)) 1)
     (string-append (number->string (address-number address1))
                    " "
                    (address-street-name address1)
                    " "
                    (address-unit-num address1)
                    ", "
                    (address-city address1)
                    ", "
                    (address-state address1)
                    " "
                    (number->string (address-zipcode address1)))]])

(define home
  (make-address 800 "North Smith Road" "Apt. 4T" "Bloomington"
                "Indiana" 47408))
(define parents-home
  (make-address 10922 "Woodward Drive" "" "Fishers" "Indiana" 46037))

(check-expect
 (address->string home)
 "800 North Smith Road Apt. 4T, Bloomington, Indiana 47408")
(check-expect
 (address->string parents-home)
 "10922 Woodward Drive, Fishers, Indiana 46037")

; same-city? : Address Address -> Bool

(define (same-city? address2 address3)
  (equal? (address-city address2)
          (address-city address3)))

(check-expect (same-city? home parents-home) #false)

; process-restaurant : Restaurant -> ...

(define (process-restaurant my-rest)
  (... (process-address (restaurant-address my-rest)) ...
       (restaurant-name my-rest) ...
       (restaurant-dish my-rest) ...))

; in-bloominton? : Restaurant -> Bool

(define (in-bloomington? rest1)
  (cond
    [(equal? (address-city (restaurant-address rest1)) "Bloomington")
     #true]
    [else #false]))

(define pizza-hut (make-restaurant
                   (make-address 800
                                 "North Pete Ellis Drive"
                                 ""
                                 "Bloomington"
                                 "Indiana"
                                 47408)
                   "Pizza Hut"
                   "Pizza"))
(define greeks-pizzeria (make-restaurant
                         (make-address 8800
                                       "East 116th Street"
                                       ""
                                       "Fishers"
                                       "Indiana"
                                       46038)
                         "Greek's Pizzeria"
                         "Dank Pizza"))
(define taco-bell (make-restaurant
                   (make-address 3001
                                 "East 3rd Street"
                                 ""
                                 "Bloomington"
                                 "Indiana"
                                 47408)
                   "Taco Bell"
                   "Tacos"))

(check-expect (in-bloomington? pizza-hut) #true)
(check-expect (in-bloomington? greeks-pizzeria) #false)
(check-expect (in-bloomington? taco-bell) #true)

; where-to-eat : String -> String

(define (where-to-eat food)
  (cond
    [(equal? (restaurant-dish pizza-hut) food) "Pizza Hut"]
    [(equal? (restaurant-dish greeks-pizzeria) food) "Greek's Pizzeria"]
    [(equal? (restaurant-dish taco-bell) food) "Taco Bell"]
    [else (error "Unknown Restaurant")]))

#|
 Design a function state-of-matter which takes as an input temperature
 and returns the state
|#



;; state-of-matter : Nat -> String
;; (state-of-matter t)
(define (state-of-matter t)
  (cond
    [(> 32 t) "Ice"]
    [(> 212 t) "Liquid"]
    [(> 21140 t) "Gas"]
    [else "Plasma"]))

;(state-of-matter 400000) ; "Plasma"
