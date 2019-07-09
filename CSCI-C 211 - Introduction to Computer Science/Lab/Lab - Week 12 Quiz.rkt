;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lab - Week 12 Quiz|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; image-max : [NonemptyListOf Image] -> Image
; (image-max ls) returns the image with the biggest area in the list

(define (image-max ls-img)
  (local [; image-area : Image -> PosNum.
          (define (image-area img)
            (* (image-width img)
               (image-height img)))]
    (foldl (lambda (next-image big-image)
             (if (< (image-area next-image)
                    (image-area big-image))
                 big-image
                 next-image))
           empty-image
           ls-img)))

(check-expect (image-max (list (square 40 "solid" "red")
                               (square 20 "solid" "yellow")))
              (square 40 "solid" "red"))
(check-expect (image-max (list (square 40 "solid" "red")))
              (square 40 "solid" "red"))