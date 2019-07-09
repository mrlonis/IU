;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "a1")
(define collaboration-statement "I worked alone")

;;;;;;;;;;;;;;; 
;; Problem 1 ;;
;;;;;;;;;;;;;;; 

;zero is 0;
(define zero 0)

;Positive integer with 20 or more digits;
(define big-number 47474747474747474747)

;My username on the C211 Handin account;
(define handin-username "mrlonis")

;My lab day. My particular one is from 10:10 am to 12:05 pm;
(define lab-day "Friday")

;My favorite color is green;
(define favorite-rainbow-color "green")

;;;;;;;;;;;;;;; 
;; Problem 2 ;;
;;;;;;;;;;;;;;;

;Defined a number as 3 times our original big-number definition;
(define bigger-number (* 3 big-number))

;Defined a number that is big-number to the 1000th power;
(define even-bigger-number (expt big-number 1000))

;;;;;;;;;;;;;;; 
;; Problem 3 ;;
;;;;;;;;;;;;;;;

;lab reminder. Used string append to include the originally;
;defined variables of handin-username and lab-day;
;had to cut the code to fit into the character allowance;
(define lab-reminder (string-append "Reminder for " handin-username
                                  ": your C211 lab is on " lab-day "."))

;;;;;;;;;;;;;;; 
;; Problem 4 ;;
;;;;;;;;;;;;;;;

;initial circle definition;
(define c (circle 10 "solid" favorite-rainbow-color))

;row of five circles;
(define 5c (beside c c c c c))

;row of four circles;
(define 4c (beside c c c c))

;row of three circle;
(define 3c (beside c c c))

;row of two circles;
(define 2c (beside c c))

;final cannonball;
(define cannonballs (above c 2c 3c 4c 5c))

