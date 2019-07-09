;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab - Week 3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define handin "lab3")
(define collaboraion-statement "I worked with Levi Beyers")
(define partner "Levi Beyers (lebeyers)")

#|
   noises is a string that defines a noise

   decibels is a string describing the noise as a string describing the
   noise in terms of decibels
|#

; noises-to-decibels : noises -> decibels
; (noises-to-decibels noises) returns a string (decibels) the describes
; noises in terms of decibels

(define (noises-to-decibels noises)
  (cond
    [(equal? noises "Leaves rusting") "10-19 decibels"]
    [(equal? noises "Quiet room") "20-29 decibels"]
    [(equal? noises "Whispering") "30-39 decibels"]
    [(equal? noises "Normal conversation") "40-59 decibels"]
    [(equal? noises "Television") "60-69 decibels"]
    [else "Not a noise"]))

(check-expect (noises-to-decibels "Leaves rusting")
              "10-19 decibels")
(check-expect (noises-to-decibels "Quiet room")
              "20-29 decibels")
(check-expect (noises-to-decibels "Whispering")
              "30-39 decibels")
(check-expect (noises-to-decibels "Normal conversation")
              "40-59 decibels")
(check-expect (noises-to-decibels "Television")
              "60-69 decibels")
(check-expect (noises-to-decibels "Deep Space")
              "Not a noise")

#|
   test-score is in the range [0..100]

   letter-grade is one of
   - "A"
   - "B"
   - "C"
   - "D"
   - "F"
|#

; percent->grade : test-score -> letter-grade
; (percent->grade test-score) returns a letter-grade based on the
; test-score

(define (percent->grade test-score)
  (cond
    [(>= test-score 100) "A+"]
    [(>= test-score 90) "A"]
    [(>= test-score 80) "B"]
    [(>= test-score 70) "C"]
    [(>= test-score 60) "D"]
    [(>= test-score 0) "F"]
    [else "W"]))

(check-expect (percent->grade 101) "A+")
(check-expect (percent->grade 99) "A")
(check-expect (percent->grade 86.7) "B")
(check-expect (percent->grade 74.3) "C")
(check-expect (percent->grade 61.2) "D")
(check-expect (percent->grade 1) "F")
(check-expect (percent->grade -47) "W")

(define (grade-advice grade)
  (cond
    [(equal? grade "A+")
     "Perfect!"]
    [(equal? grade "A")
     "Outstanding!"]
    [(equal? grade "B")
     "Nice job!"]
    [(equal? grade "C")
     "With a little studying, you can definitely master the material."]
    [(equal? grade "D")
     "You still have a chance to improve next exam."]
    [(equal? grade "F")
     "Oops. Better luck next time."]
    [(equal? grade "W")
     "Did you not like my class?"]
    [else "Go to school"]))

(check-expect (grade-advice "A+") "Perfect!")
(check-expect (grade-advice "A") "Outstanding!")
(check-expect (grade-advice "B") "Nice job!")
(check-expect
 (grade-advice "C")
 "With a little studying, you can definitely master the material.")
(check-expect (grade-advice "D")
              "You still have a chance to improve next exam.")
(check-expect (grade-advice "F") "Oops. Better luck next time.")
(check-expect (grade-advice "W") "Did you not like my class?")

(define (letter-grade-advice test-score)
  (string-append "Your grade: " (percent->grade test-score)
                 ". " (grade-advice (percent->grade test-score))))

(check-expect (letter-grade-advice 96)
              "Your grade: A. Outstanding!")
(check-expect (letter-grade-advice 0)
              "Your grade: F. Oops. Better luck next time.")

(define (letter->grade-curved test-score curve)
  (letter-grade-advice (min (+ curve test-score))))

(check-expect (letter->grade-curved 75 20)
              "Your grade: A. Outstanding!")