;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Spring 2015 - Midterm Part 1 (Written)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;
;; Problem 1 ;;
;;;;;;;;;;;;;;;

;;;;; 1a

; Draw the Box and Pointer diagra corresponding to each of the following
; lists

;;;;; 1i

(define 1i '(a b c d))

(define 1i-list (list 'a 'b 'c 'd))
(define 1i-cons (cons 'a (cons 'b (cons 'c (cons 'd '())))))

(check-expect (equal? 1i 1i-list) #true)
(check-expect (equal? 1i 1i-cons) #true)
(check-expect (equal? 1i-cons 1i-list) #true)

;;;;; 1ii

(define 1ii '((a b) c))

(define 1ii-list (list (list 'a 'b) 'c))
(define 1ii-cons (cons (cons 'a (cons'b '())) (cons 'c '())))

(check-expect (equal? 1ii 1ii-list) #true)
(check-expect (equal? 1ii 1ii-cons) #true)
(check-expect (equal? 1ii-cons 1ii-list) #true)

;;;;; 1iii

(define 1iii '((a (b)) c))

(define 1iii-list (list (list 'a (list 'b)) 'c))
(define 1iii-cons
  (cons
   (cons 'a
         (cons
          (cons 'b '())
          '()))
   (cons 'c '())))


(check-expect (equal? 1iii 1iii-list) #true)
(check-expect (equal? 1iii 1iii-cons) #true)
(check-expect (equal? 1iii-cons 1iii-list) #true)

;;;;; 1b

; consider the following function defenition:

(define (fascinating ls)
  (cond
    [(empty? (rest (rest ls))) (list (rest ls) (first ls))]
    [(equal? 'p (first ls)) (list (first ls) (fascinating (rest ls)))]
    [else (cons (first ls) (fascinating (rest ls)))]))

(check-expect (fascinating '(s p o c k))
              (list 's 'p (list 'o (list 'k) 'c)))

; Write out an abbreviated hand trace of the application
; (fascinating '(s p o c k)). There should be one line for each
; recursive call until you reach the base case, and then one line for
; each completion step as you back out of the recursion. The first one
; is done for you. Abbreviated hand trace notes are in lecture slide
; week 6b

#|
  (fascinating '(s p o c k))
  == (cons 's (fascinating '(p o c k)))
  == (cons 's (list 'p (fascinating '(o c k))))
  == (cons 's (list 'p (cons 'o (fascinating '(c k)))))
  == (cons 's (list 'p (cons 'o (list (list 'k) 'c))))
  == (cons 's (list 'p (list 'o (list 'k) 'c)))
  == (cons 's (list 'p (list 'o (list 'k) 'c)))
  == (list 's 'p (list 'o (list 'k) 'c))
|#

;;;;; 1c

; Consider the following contract and function defenition:

; bin-op : Posn Posn -> Posn

(define (bin-op p q)
  (make-posn (* (posn-x p) (posn-x q))
             (+ (posn-y p) (posn-y q))))

; What is the identity for the bin-op function? Justify Your answer.
; Identities are in lecture slides week 6a

#|
  The Identity for bin-op is either makingp or q have the following
  characteristics return #true:
  - (= (posn-x q) 1)
  - (= (posn-y q) 0)

  Again these can apply to either q or p i just used q as my example
|#

;;;;;;;;;;;;;;;
;; Problem 2 ;;
;;;;;;;;;;;;;;;

; In this problem, you will design a non-recursive function pig-latin
; that takes a word and returns the corresponding word in Pig Latin,
; formed according to the following rule:

#|
  If the first letter is a vowel, then append "yay" to the end of the
  word. Otherwise, move the first letter to the end of the word along
  with "ay".
|#

;;;;; 2a

; Using the following type definition, write a contract for the
; pig-latin function.

#|
A Word is a non-empty String
|#

; pig-latin : Word -> Word

;;;;; 2b

; Write the header for the pig-latin function as it would appear at
; the beginning of your purpose statement. Do not write anything other
; than the header.

; (pig-latin word) ...

;;;;; 2c

; Write a contract and a definition for a predicate vowel? that takes
; a 1String and returns true if it corresponds to one of the five
; vowels in the English language (a, e, i, o, u), and false otherwise.
; Do not write anything other than the contract and definition of this
; predicate.

; vowel? : 1String -> Bool

(define (vowel? 1-string)
  (or (equal? 1-string "a")
      (equal? 1-string "e")
      (equal? 1-string "i")
      (equal? 1-string "o")
      (equal? 1-string "u")))

;;;;; 2d

; Here is one check-expect for the pig-latin function. Write two more:
; one for the application (pig-latin "most") and one for the
; application (pig-latin "illogical").

(check-expect (pig-latin "spock") "pocksay")
(check-expect (pig-latin "most") "ostmay")
(check-expect (pig-latin "illogical") "illogicalyay")

;;;;; 2e

(define (pig-latin word)
  (if (vowel? (string-ith word 0))
      (string-append word "yay")
      (string-append (substring word 1) (string-ith word 0) "ay")))

;;;;;;;;;;;;;;;
;; Problem 3 ;;
;;;;;;;;;;;;;;;

; A CompoundWord is a word formed by putting two Nouns together.

#|
  A Noun is a Symbol
  A CompoundWord is a (make-cword Noun Noun)
|#

;;;;; 3a

; Define a structure named cword for the CompoundWord type. Use first
; and second as the field names.

(define-struct cword [first second])

;;;;; 3b

; Write the contract for each function that is created by the
; definition you made in part (a).

; make-cword : Noun Noun -> CompoundWord
; cword? : Any -> Bool
; cword-first : CompoundWord -> Noun
; cword-second : CompoundWord -> Noun

;;;;; 3c

; Write a data defenition for a ListOfNoun and another data defenition
; for a ListOfCompoundWord

#|
  A ListOfNoun is one of:
  - '()
  - (cons Noun ListOfNoun)

  A ListOfCompoundWord is one of:
  - '()
  - (cons CompoundWord ListOfCompoundWord
|#

;;;;; 3d

; We need a function compounder that takes a Noun, word, and a list of
; Noun, nouns, and returns a list containing all compound words
; starting with something in nouns and ending with word, as shown in
; the examples below.

(check-expect (compounder 'house '()) '())
(check-expect (compounder 'worm '(book earth))
              (list (make-cword 'book 'worm)
                    (make-cword 'earth 'worm)))
(check-expect (compounder 'bean '(jelly lima jumping string))
              (list (make-cword 'jelly 'bean)
                    (make-cword 'lima 'bean)
                    (make-cword 'jumping 'bean)
                    (make-cword 'string 'bean)))

;;;;; 3di

; compounder : Noun ListOfNoun -> ListOfCompoundWord

;;;;; 3dii

(define (compounder word nouns)
  (cond
    [(empty? nouns) '()]
    [else (cons (make-cword (first nouns) word)
                (compounder word (rest nouns)))]))