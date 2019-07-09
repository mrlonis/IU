;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture-apr04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define handin "lecture-apr04")
(define team "red8")

;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;

(define scribe1 "Grant Eller")

; fib : Nat -> Nat
; (fib n) returns the n-th Fibonacci number

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (sub1 n)) (fib (- n 2)))))


(check-expect (fib 0) 0)
(check-expect (fib 1) 1)
(check-expect (fib 2) 1)
(check-expect (fib 7) 13)
(check-expect (fib 20) 6765)

(define (ignore x) #true)

#|7+
(ignore (time (fib 20)))
(ignore (time (fib 30)))
|#
#|
When n=40 the CPU time to wait for the function
to run was pretty intolerable, and annoying
|#


;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;

(define scribe2 "Josh Lipe-Melton")

; fib/fast : Nat -> Nat
; (fib/fast n) returns the n-th Fibonacci number

(define (fib/fast n)
  (local [; loop : Nat Nat Nat -> Nat
          ; (loop i p1 p2) returns the i-th Fibonacci number, where
          ; p1 is (fib (- i 1)) and p2 is (fib i)
          (define (loop i p1 p2)
            (cond
              [(= i n) p2]
              [else (loop (+ i 1) p2 (+ p2 p1))]))]
    (if (zero? n)
        0
        (loop 1 0 1))))

(check-expect (fib/fast 0) 0)
(check-expect (fib/fast 1) 1)
(check-expect (fib/fast 2) 1)
(check-expect (fib/fast 7) 13)
(check-expect (fib/fast 20) 6765)

#|
(ignore (time (fib/fast 20)))
(ignore (time (fib/fast 30)))
(ignore (time (fib/fast 40)))
(ignore (time (fib/fast 1000)))
(ignore (time (fib/fast 10000)))
(ignore (time (fib/fast 100000)))
|#


;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;

(define scribe3 "Andrew Andjelic")

(define t1 (triangle 10 "outline" "black"))
(define t2 (above t1 (beside t1 t1)))
(define t3 (above t2 (beside t2 t2)))
(define t4 (above t3 (beside t3 t3)))
(define t5 (above t4 (beside t4 t4)))
(define t6 (above t5 (beside t5 t5)))

; sierpinski : PosInt -> Image
; (sierpinski n) returns a hollow black triangle in the case that n
; is 1, or an image formed from three copies of the predecessor
; sierpinski triangle, with two side-by-side topped by one above

(define (sierpinski n)
  (cond
    [(= n 1) (triangle 10 "outline" "black")]
    [else (local [(define ans (sierpinski (sub1 n)))]
            (above
           (sierpinski (- n 1))
           (beside ans ans)))]))


(check-expect (sierpinski 1) t1)
(check-expect (sierpinski 2) t2)
(check-expect (sierpinski 3) t3)
(check-expect (sierpinski 4) t4)
(check-expect (sierpinski 5) t5)
(check-expect (sierpinski 6) t6)

;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;

(define scribe4 "Andre Quan")

; insert-in-order : Num [ListOf Num] -> [ListOf Num]
; (insert-in-order x sorted-ls) returns the result of insert x into
; the sorted list sorted-ls such that the result is also sorted (in
; increasing order)

(define (insert-in-order x sorted-ls)
  (cond
    [(empty? sorted-ls) (cons x '())]
    [(< x (first sorted-ls)) (cons x sorted-ls)]  
    [else (cons (first sorted-ls)(insert-in-order x
                                                  (rest sorted-ls)))]))

(check-expect (insert-in-order 7 '(2 4 5 10)) '(2 4 5 7 10))
(check-expect (insert-in-order 4 '()) '(4))
(check-expect (insert-in-order 100 (range -123 100 1))
              (range -123 101 1))

;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;

#|

Dank is a slang term for sorted

|#

(define scribe5 "Matthew Lonis")

; insertion-sort : [ListOf Num] -> [ListOf Num]
; (insertion-sort ls) takes a [ListOf Num] and returns it in order

(define (insertion-sort ls)
  (local
    [; loop : [ListOf Num] [ListOf Num] -> [ListOf Num]
     ; (loop ls sorted-ls) takes a non-dank ls and returns a
     ; dank-version (aka sorted). sortd-ls, as one would assume, becomes
     ; increasingly dank throughout the loop of the program. If one was
     ; to snapshot the dankness at any given loop, sorted-ls is would be
     ; the currently sorted list
     (define (loop ls sorted-ls)
       (cond
         [(empty? ls) sorted-ls]
         [else (loop (rest ls)
                     (insert-in-order (first ls) sorted-ls))]))]
    (loop ls '())))

(check-expect (insertion-sort '()) '())
(check-expect (insertion-sort '(3 1 2 8 5)) '(1 2 3 5 8))
(check-expect (insertion-sort (range 1 100 1)) (range 1 100 1))
(check-expect (insertion-sort (range 99 0 -1)) (range 1 100 1))