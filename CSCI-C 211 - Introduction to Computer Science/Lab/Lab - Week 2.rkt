;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab - Week 2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define handin "lab2")
(define partner "Ben Braun (benbraun)")
(define collaboration-statement
  (string-append "I worked with " partner))

; animate : Function -> Image
; (animate image-generator)

(define (img-gen size)
  (place-image (circle 35 "outline" "blue")
               200 200
               (empty-scene 400 400)))

(define (img-spin size)
  (place-images
   (list (rotate size
                 (pulled-regular-polygon 100 3 1.8 30 "solid" "blue"))
         (rotate size
                 (star-polygon 40 7 3 "outline" "darkred")))
   (list (make-posn 200 200)
         (make-posn 300 300))
   (empty-scene 400 400)))

; median : Num Num -> Num
; (median x1 x2) returns the median number of two given x inputs
(define (median x1 x2)
  (quotient (+ x1 x2) 2))

(check-expect (median 1 3) 2)
(check-expect (median 0 100) 50)
(check-satisfied (median 3 1) number?)

(define (create-UFO-scene height)
  (underlay/xy (rectangle 100 100 "solid" "white") 50 height UFO))
 
(define UFO
  (underlay/align "center"
                  "center"
                  (circle 10 "solid" "green")
                  (rectangle 40 4 "solid" "green")))

