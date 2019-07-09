;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |C 211 Lab Notes - Week 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)

; Function: Input -> Output
; Natural: 1, 2, 3, ...
; Integer: ..., -2, -1, 0, 1, 2, ...
; Number: 2.5, 1/3, 0

(require 2htdp/image)
; stringy: Number Numebr -> String
; ...
(define (stringy n1 n2)
  "string")
(check-satisfied (stringy 0 1) string?)
(stringy 0 1)

; star-maker: String Number -> Image
; ...
(define (star-maker a-string a-number)
  (star 100 "solid" "yellow"))
(check-satisfied (star-maker "brian" 3) image?)
(star-maker "brian" 3)

; Design Recipe:
; Contract
; Purpose
; Definition
; Tests

; median : Number Number -> Number
; (median number0 number1) takes the median of the given two numbers number0 and number1.
(define (median number0 number1)
  (/ (+ number0 number1) 2))
(check-expect (median 2 4) 3)
(check-expect (median -2 1400) 699)
(check-within (median 11 16) 13 1)

; black-star: Number -> Image
; (black-star size) draws the star of the given size.
(define (black-star size)
  (star size "solid" "black"))
(black-star 10)
(check-satisfied (black-star 10) image?)

; animate: Function -> Image
; (animate a-function) calls a-function over and over with increasing values for the argument to a-function, e.g. (a-function 1), (a-function 2), etc.

; star-scene: Number -> Image
; (star-scene size) draws a star of the given size on a blank canvas.
(define (star-scene size)
  (place-image (black-star size) 250 250
               (empty-scene 500 500)))
(star-scene 20)
(check-satisfied (star-scene 20) image?)

; rotate-star: Number -> Image
; (rotate-star angle) draws a star rotated by the given angle.
(define (rotate-star angle)
  (place-image (rotate angle (black-star 40)) 250 250 (empty-scene 500 500)))
(rotate-star 45)
(check-satisfied (rotate-star 45) image?)