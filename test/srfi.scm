;;;
;;; SRFIs
;;;

;;
;; ---- SRFI 112: Environment Inquiry ----
;;

(import (srfi 112))

(check-equal #t (or (string? (implementation-name)) (eq? (implementation-name) #f)))
(check-error (assertion-violation implementation-name) (implementation-name 1))

(check-equal #t (or (string? (implementation-version)) (eq? (implementation-version) #f)))
(check-error (assertion-violation implementation-version) (implementation-version 1))

(check-equal #t (or (string? (cpu-architecture)) (eq? (cpu-architecture) #f)))
(check-error (assertion-violation cpu-architecture) (cpu-architecture 1))

(check-equal #t (or (string? (machine-name)) (eq? (machine-name) #f)))
(check-error (assertion-violation machine-name) (machine-name 1))

(check-equal #t (or (string? (os-name)) (eq? (os-name) #f)))
(check-error (assertion-violation os-name) (os-name 1))

(check-equal #t (or (string? (os-version)) (eq? (os-version) #f)))
(check-error (assertion-violation os-version) (os-version 1))

;;
;; ---- SRFI 111: Boxes ----
;;

(import (scheme box))

(check-equal 10 (unbox (box 10)))
(check-equal #t (equal? (box 20) (box 20)))
(check-equal #f (eq? (box 30) (box 30)))

(check-error (assertion-violation box) (box))
(check-error (assertion-violation box) (box 1 2))

(check-equal #t (box? (box 10)))
(check-equal #f (box? 10))
(check-equal #f (box? #(10)))
(check-equal #f (box? (cons 1 2)))

(check-error (assertion-violation box?) (box?))
(check-error (assertion-violation box?) (box? 1 2))

(check-equal 10 (unbox (box 10)))

(check-error (assertion-violation unbox) (unbox))
(check-error (assertion-violation unbox) (unbox (box 1) 2))
(check-error (assertion-violation unbox) (unbox (cons 1 2)))

(define b (box 10))
(check-equal 10 (unbox b))
(set-box! b 20)
(check-equal 20 (unbox b))
(check-equal #t (equal? b (box 20)))
(check-equal #f (eq? b (box 20)))

(check-error (assertion-violation set-box!) (set-box! b))
(check-error (assertion-violation set-box!) (set-box! b 2 3))
(check-error (assertion-violation set-box!) (set-box! (cons 1 2) 2))

;;
;; ---- SRFI 60: Integers As Bits ----
;;

(import (srfi 60))

(check-equal "1000" (number->string (bitwise-and #b1100 #b1010) 2))

(check-equal -1 (bitwise-and))
(check-equal 12345 (bitwise-and 12345))
(check-equal 4145 (bitwise-and 12345 54321))
(check-equal 4145 (bitwise-and 54321 12345))
(check-equal 49 (bitwise-and 12345 54321 10101010101))
(check-equal 16 (bitwise-and 12345 12345678901234567890123456789012345678901234567890))
(check-equal 39235487929048208904815248
    (bitwise-and 12345678901234567890123456789012345678901234567890 987654321987654321987654321))

(check-error (assertion-violation bitwise-and) (bitwise-and 1234 56.78))
(check-error (assertion-violation bitwise-and) (bitwise-and 1234 56/78))
(check-error (assertion-violation bitwise-and) (bitwise-and 12.34 5678))
(check-error (assertion-violation bitwise-and) (bitwise-and 12/34 5678))

(check-equal 0 (bitwise-ior))
(check-equal 12345 (bitwise-ior 12345))
(check-equal 62521( bitwise-ior 12345 54321))
(check-equal 62521( bitwise-ior 54321 12345))
(check-equal 1014205 (bitwise-ior 12345 1010101))
(check-equal 1014205 (bitwise-ior 1010101 12345))
(check-equal 123456789123456789123456789123456789123456789123465021
    (bitwise-ior 12345 123456789123456789123456789123456789123456789123456789))
(check-equal 123456789123456789123456789123456789123456789123465021
    (bitwise-ior 123456789123456789123456789123456789123456789123456789 12345))
(check-equal 1234123412341276660008185256654991575253956765272574
    (bitwise-ior 1234123412341234123412341234123412341234123412341234
            5678567856785678567856785678567856785678))

(check-error (assertion-violation bitwise-ior) (bitwise-ior 1234 56.78))
(check-error (assertion-violation bitwise-ior) (bitwise-ior 1234 56/78))
(check-error (assertion-violation bitwise-ior) (bitwise-ior 12.34 5678))
(check-error (assertion-violation bitwise-ior) (bitwise-ior 12/34 5678))

(check-equal 0 (bitwise-xor))
(check-equal 12345 (bitwise-xor 12345))
(check-equal 58376 (bitwise-xor 12345 54321))
(check-equal 58376 (bitwise-xor 54321 12345))
(check-equal 10 (bitwise-xor #b10001 #b11011))
(check-equal 678967896789678967896789678967896789678967896789678967884524
    (bitwise-xor 12345 678967896789678967896789678967896789678967896789678967896789))
(check-equal 7088580165427581030224296127424816853124929578319024555
    (bitwise-xor 1234512345123451234512345123451234512345123451234512345
            6789067890678906789067890678906789067890678906789067890))

(check-error (assertion-violation bitwise-xor) (bitwise-xor 1234 56.78))
(check-error (assertion-violation bitwise-xor) (bitwise-xor 1234 56/78))
(check-error (assertion-violation bitwise-xor) (bitwise-xor 12.34 5678))
(check-error (assertion-violation bitwise-xor) (bitwise-xor 12/34 5678))

(check-equal -12346 (bitwise-not 12345))
(check-equal -6789067890678906789067890678906789067890678906789067890678906789067891
    (bitwise-not 6789067890678906789067890678906789067890678906789067890678906789067890))

(check-error (assertion-violation bitwise-not) (bitwise-not 12.34))
(check-error (assertion-violation bitwise-not) (bitwise-not 12/34))
(check-error (assertion-violation bitwise-not) (bitwise-not))
(check-error (assertion-violation bitwise-not) (bitwise-not 12 34))

(check-equal #f (any-bits-set? #b0100 #b1011))
(check-equal #t (any-bits-set? #b0100 #b0111))

(check-equal 4 (bit-count #b10101010))
(check-equal 0 (bit-count 0))
(check-equal 1 (bit-count -2))

(check-error (assertion-violation bit-count) (bit-count))
(check-error (assertion-violation bit-count) (bit-count 12 34))
(check-error (assertion-violation bit-count) (bit-count 12.34))
(check-error (assertion-violation bit-count) (bit-count 12/34))

(check-equal 8 (integer-length #b10101010))
(check-equal 0 (integer-length 0))
(check-equal 4 (integer-length #b1111))

(check-error (assertion-violation integer-length) (integer-length))
(check-error (assertion-violation integer-length) (integer-length 12 34))
(check-error (assertion-violation integer-length) (integer-length 12.34))
(check-error (assertion-violation integer-length) (integer-length 12/34))

(check-equal -1 (first-set-bit 0))
(check-equal -1 (first-set-bit 0))
(check-equal 0 (first-set-bit -1))
(check-equal 0 (first-set-bit 1))
(check-equal 1 (first-set-bit -2))
(check-equal 1 (first-set-bit 2))
(check-equal 0 (first-set-bit -3))
(check-equal 0 (first-set-bit 3))
(check-equal 2 (first-set-bit -4))
(check-equal 2 (first-set-bit 4))
(check-equal 0 (first-set-bit -5))
(check-equal 0 (first-set-bit 5))
(check-equal 1 (first-set-bit -6))
(check-equal 1 (first-set-bit 6))
(check-equal 0 (first-set-bit -7))
(check-equal 0 (first-set-bit 7))
(check-equal 3 (first-set-bit -8))
(check-equal 3 (first-set-bit 8))
(check-equal 0 (first-set-bit -9))
(check-equal 0 (first-set-bit 9))
(check-equal 1 (first-set-bit -10))
(check-equal 1 (first-set-bit 10))
(check-equal 0 (first-set-bit -11))
(check-equal 0 (first-set-bit 11))
(check-equal 2 (first-set-bit -12))
(check-equal 2 (first-set-bit 12))
(check-equal 0 (first-set-bit -13))
(check-equal 0 (first-set-bit 13))
(check-equal 1 (first-set-bit -14))
(check-equal 1 (first-set-bit 14))
(check-equal 0 (first-set-bit -15))
(check-equal 0 (first-set-bit 15))
(check-equal 4 (first-set-bit -16))
(check-equal 4 (first-set-bit 16))
(check-equal 123 (first-set-bit (arithmetic-shift 1 123)))
(check-equal 123 (first-set-bit (arithmetic-shift -1 123)))

(check-error (assertion-violation first-set-bit) (first-set-bit))
(check-error (assertion-violation first-set-bit) (first-set-bit 12 34))
(check-error (assertion-violation bitwise-and) (first-set-bit 12.34))
(check-error (assertion-violation bitwise-and) (first-set-bit 12/34))

(check-equal #t (logbit? 0 #b1101))
(check-equal #f (logbit? 1 #b1101))
(check-equal #t (logbit? 2 #b1101))
(check-equal #t (logbit? 3 #b1101))
(check-equal #f (logbit? 4 #b1101))

(check-equal "1" (number->string (copy-bit 0 0 #t) 2))
(check-equal "100" (number->string (copy-bit 2 0 #t) 2))
(check-equal "1011" (number->string (copy-bit 2 #b1111 #f) 2))

(check-equal "1010" (number->string (bit-field #b1101101010 0 4) 2))
(check-equal "10110" (number->string (bit-field #b1101101010 4 9) 2))

(check-equal "1101100000" (number->string (copy-bit-field #b1101101010 0 0 4) 2))
(check-equal "1101101111" (number->string (copy-bit-field #b1101101010 -1 0 4) 2))
(check-equal "110100111110000" (number->string (copy-bit-field #b110100100010000 -1 5 9) 2))

(check-equal "1000" (number->string (arithmetic-shift #b1 3) 2))
(check-equal "101" (number->string (arithmetic-shift #b1010 -1) 2))

(check-equal "111010110111100110100010101" (number->string (arithmetic-shift 123456789 0) 2))
(check-equal "11101011011110011010001010100000" (number->string (arithmetic-shift 123456789 5) 2))
(check-equal "-11101011011110011010001010100000"
    (number->string (arithmetic-shift -123456789 5) 2))
(check-equal "1110101101111001101000101010000000000000"
    (number->string (arithmetic-shift 123456789 13) 2))
(check-equal "-1110101101111001101000101100010000000"
    (number->string (arithmetic-shift -987654321 7) 2))
(check-equal "1111000100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    (number->string (arithmetic-shift 123456 101) 2))
(check-equal "-1111000100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    (number->string (arithmetic-shift -123456 101) 2))
(check-equal "1000011100100111111101100011011010011010101011111000001111001010000101010000001001100111010001111010111110001100011111110001100101101100111000111111000010101101001000000000000000000000000"
    (number->string (arithmetic-shift 12345678901234567890123456789012345678901234567890 23) 2))
(check-equal "-10000111001001111111011000110110100110101010111110000011110010100001010100000010011001110100011110101111100011000111111100011001011011001110001111110000101011010010000000000000000000000000000"
    (number->string (arithmetic-shift -12345678901234567890123456789012345678901234567890 27) 2))
(check-equal "1110101101111001101000101" (number->string (arithmetic-shift 123456789 -2) 2))
(check-equal "-1110101101111001101000110" (number->string (arithmetic-shift -123456789 -2) 2))
(check-equal "1110101101" (number->string (arithmetic-shift 123456789 -17) 2))
(check-equal "0" (number->string (arithmetic-shift 123456789 -101) 2))
(check-equal "-1" (number->string (arithmetic-shift -123456789 -101) 2))
(check-equal "1001110101010111101010000010011100100101111000001111001100010000101110011111110000111101001000011011110001100001101111011010010011100100011001100111111110001100101101100111000111111000"
    (number->string (arithmetic-shift 123456789012345678901234567890123456789012345678901234567890 -13) 2))
(check-equal "-1001110101010111101010000010011100100101111000001111001100010000101110011111110000111101001000011011110001100001101111011010010011100100011001100111111110001100101101100111000111111001"
    (number->string (arithmetic-shift -123456789012345678901234567890123456789012345678901234567890 -13) 2))
(check-equal "100111010101011110101000001001110010010111100000111100110001000010111001111111000011110100100001"
    (number->string (arithmetic-shift 123456789012345678901234567890123456789012345678901234567890 -101) 2))
(check-equal "-100111010101011110101000001001110010010111100000111100110001000010111001111111000011110100100010"
    (number->string (arithmetic-shift -123456789012345678901234567890123456789012345678901234567890 -101) 2))
(check-equal "1001110101010111"
    (number->string (arithmetic-shift 123456789012345678901234567890123456789012345678901234567890 -181) 2))
(check-equal "-1001110101011000"
    (number->string (arithmetic-shift -123456789012345678901234567890123456789012345678901234567890 -181) 2))
(check-equal "0"
    (number->string (arithmetic-shift 123456789012345678901234567890123456789012345678901234567890 -201) 2))
(check-equal "-1"
    (number->string (arithmetic-shift -123456789012345678901234567890123456789012345678901234567890 -201) 2))

(check-error (assertion-violation arithmetic-shift) (arithmetic-shift))
(check-error (assertion-violation arithmetic-shift) (arithmetic-shift 12))
(check-error (assertion-violation arithmetic-shift) (arithmetic-shift 12 34.56))
(check-error (assertion-violation arithmetic-shift) (arithmetic-shift 12 34/56))
(check-error (assertion-violation arithmetic-shift) (arithmetic-shift 12.34 56))
(check-error (assertion-violation arithmetic-shift) (arithmetic-shift 12/34 56))

(check-equal "10" (number->string (rotate-bit-field #b0100 3 0 4) 2))
(check-equal "10" (number->string (rotate-bit-field #b0100 -1 0 4) 2))
(check-equal "110100010010000" (number->string (rotate-bit-field #b110100100010000 -1 5 9) 2))
(check-equal "110100000110000" (number->string (rotate-bit-field #b110100100010000 1 5 9) 2))

(check-equal "e5" (number->string (reverse-bit-field #xa7 0 8) 16))

;;
;; ---- SRFI 1: List Library ----
;;

(import (scheme list))

(check-equal (a) (cons 'a '()))
(check-equal ((a) b c d) (cons '(a) '(b c d)))
(check-equal ("a" b c) (cons "a" '(b c)))
(check-equal (a . 3) (cons 'a 3))
(check-equal ((a b) . c) (cons '(a b) 'c))

(check-equal (a 7 c) (list 'a (+ 3 4) 'c))
(check-equal () (list))

(check-equal (a . b) (xcons 'b 'a))

(check-equal (1 2 3 . 4) (cons* 1 2 3 4))
(check-equal 1 (cons* 1))

(check-equal (c c c c) (make-list 4 'c))
(check-equal () (make-list 0))
(check-equal 10 (length (make-list 10)))

(check-equal (0 1 2 3) (list-tabulate 4 values))
(check-equal () (list-tabulate 0 values))

(define cl (circular-list 'a 'b 'c))
(check-equal #t (eq? cl (cdddr cl)))
(check-equal (a b a b a b a b) (take (circular-list 'a 'b) 8))
(check-equal #f (list? (circular-list 1 2 3 4 5)))

(check-equal (0 1 2 3 4 5) (iota 6))
(check-equal (0 -0.1 -0.2 -0.3 -0.4) (iota 5 0 -0.1))

(check-equal #t (proper-list? '(a b c)))
(check-equal #t (proper-list? '()))
(check-equal #f (proper-list? '(a b . c)))
(check-equal #f (proper-list? 'a))
(check-equal #f (proper-list? (circular-list 1 2 3 4 5 6)))

(check-equal #f (circular-list? '(a b c)))
(check-equal #f (circular-list? '()))
(check-equal #f (circular-list? '(a b . c)))
(check-equal #f (circular-list? 'a))
(check-equal #t (circular-list? (circular-list 1 2 3 4 5 6)))
(check-equal #t (circular-list? (cons 0 (circular-list 1 2 3 4 5 6))))

(check-equal #f (dotted-list? '(a b c)))
(check-equal #f (dotted-list? '()))
(check-equal #t (dotted-list? '(a b . c)))
(check-equal #t (dotted-list? 'a))
(check-equal #f (dotted-list? (circular-list 1 2 3 4 5 6)))

(check-equal #t (not-pair? 'a))
(check-equal #t (not-pair? #()))
(check-equal #f (not-pair? (cons 1 2)))
(check-equal #t (not-pair? '()))

(check-equal #f (null-list? (cons 1 2)))
(check-equal #t (null-list? '()))

(check-equal #t (list= eq? '(1 2 3 4) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 3) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 3)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 3 5)))
(check-equal #t (list= eq? '(1 2 3 4) '(1 2 3 4) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 3) '(1 2 3 4) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 3) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 3 4) '(1 2 3)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 3 4) '(1 2 3 5)))
(check-equal #f (list= eq? '(1 2 3 4) '(1 2 4) '(1 2 3 4)))
(check-equal #f (list= eq? '(1 2 6 4) '(1 2 3 4) '(1 2 3 4)))

(check-equal 1 (first '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 2 (second '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 3 (third '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 4 (fourth '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 5 (fifth '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 6 (sixth '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 7 (seventh '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 8 (eighth '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 9 (ninth '(1 2 3 4 5 6 7 8 9 10)))
(check-equal 10 (tenth '(1 2 3 4 5 6 7 8 9 10)))

(check-equal (1 2 3) (take '(1 2 3 4 5 6) 3))
(check-equal () (take '(1 2 3 4 5 6) 0))

(check-equal (4 5 6) (drop '(1 2 3 4 5 6) 3))
(check-equal () (drop '(1 2 3 4 5 6) 6))

(check-equal (d e) (take-right '(a b c d e) 2))
(check-equal (2 3 . d) (take-right '(1 2 3 . d) 2))
(check-equal d (take-right '(1 2 3 . d) 0))

(check-equal (a b c) (drop-right '(a b c d e) 2))
(check-equal (1) (drop-right '(1 2 3 . d) 2))
(check-equal (1 2 3) (drop-right '(1 2 3 . d) 0))

(check-equal (1 3) (take! (circular-list 1 3 5) 8))
(check-equal (1 2 3) (take! '(1 2 3 4 5 6) 3))
(check-equal () (take! '(1 2 3 4 5 6) 0))

(check-equal (a b c) (drop-right! '(a b c d e) 2))
(check-equal (1) (drop-right! '(1 2 3 . d) 2))
(check-equal (1 2 3) (drop-right! '(1 2 3 . d) 0))

(check-equal ((1 2 3) (4 5 6 7 8))
    (let-values (((pre suf) (split-at '(1 2 3 4 5 6 7 8) 3))) (list pre suf)))
(check-equal (() (1 2 3 4 5 6 7 8))
    (let-values (((pre suf) (split-at '(1 2 3 4 5 6 7 8) 0))) (list pre suf)))
(check-equal ((1 2 3 4 5 6 7 8) ())
    (let-values (((pre suf) (split-at '(1 2 3 4 5 6 7 8) 8))) (list pre suf)))

(check-equal ((1 2 3) (4 5 6 7 8))
    (let-values (((pre suf) (split-at! '(1 2 3 4 5 6 7 8) 3))) (list pre suf)))
(check-equal (() (1 2 3 4 5 6 7 8))
    (let-values (((pre suf) (split-at! '(1 2 3 4 5 6 7 8) 0))) (list pre suf)))
(check-equal ((1 2 3 4 5 6 7 8) ())
    (let-values (((pre suf) (split-at! '(1 2 3 4 5 6 7 8) 8))) (list pre suf)))

(check-equal c (last '(a b c)))

(check-equal (c) (last-pair '(a b c)))

(check-equal (x y) (append '(x) '(y)))
(check-equal (a b c d) (append '(a) '(b c d)))
(check-equal (a b c d) (append '(a) '() '(b c d)))
(check-equal (a b c d) (append '() '(a) '() '(b c d) '()))
(check-equal (a (b) (c)) (append '(a (b)) '((c))))
(check-equal (a b c . d) (append '(a b) '(c . d)))
(check-equal a (append '() 'a))
(check-equal (x y) (append '(x y)))
(check-equal () (append))

(check-equal (x y) (append! '(x) '(y)))
(check-equal (a b c d) (append! '(a) '(b c d)))
(check-equal (a b c d) (append! '(a) '() '(b c d)))
(check-equal (a b c d) (append! '() '(a) '() '(b c d) '()))
(check-equal (a (b) (c)) (append! '(a (b)) '((c))))
(check-equal (a b c . d) (append! '(a b) '(c . d)))
(check-equal a (append! '() 'a))
(check-equal (x y) (append! '(x y)))
(check-equal () (append!))

(check-equal (x y) (concatenate '((x) (y))))
(check-equal (a b c d) (concatenate '((a) (b c d))))
(check-equal (a b c d) (concatenate '((a) () (b c d))))
(check-equal (a b c d) (concatenate '(() (a) () (b c d) ())))
(check-equal (a (b) (c)) (concatenate '((a (b)) ((c)))))
(check-equal (a b c . d) (concatenate '((a b) (c . d))))
(check-equal a (concatenate '(() a)))
(check-equal (x y) (concatenate '((x y))))
(check-equal () (concatenate '()))

(check-equal (x y) (concatenate! '((x) (y))))
(check-equal (a b c d) (concatenate! '((a) (b c d))))
(check-equal (a b c d) (concatenate! '((a) () (b c d))))
(check-equal (a b c d) (concatenate! '(() (a) () (b c d) ())))
(check-equal (a (b) (c)) (concatenate! '((a (b)) ((c)))))
(check-equal (a b c . d) (concatenate! '((a b) (c . d))))
(check-equal a (concatenate! '(() a)))
(check-equal (x y) (concatenate! '((x y))))
(check-equal () (concatenate! '()))

(check-equal (c b a) (reverse '(a b c)))
(check-equal ((e (f)) d (b c) a) (reverse '(a (b c) d (e (f)))))

(check-equal (c b a) (reverse! '(a b c)))
(check-equal ((e (f)) d (b c) a) (reverse! '(a (b c) d (e (f)))))

(check-equal (3 2 1 4 5) (append-reverse '(1 2 3) '(4 5)))
(check-equal (3 2 1) (append-reverse '(1 2 3) '()))
(check-equal (4 5) (append-reverse '() '(4 5)))

(check-equal (3 2 1 4 5) (append-reverse! '(1 2 3) '(4 5)))
(check-equal (3 2 1) (append-reverse! '(1 2 3) '()))
(check-equal (4 5) (append-reverse! '() '(4 5)))

(check-equal ((one 1 odd) (two 2 even) (three 3 odd))
    (zip '(one two three) '(1 2 3) '(odd even odd even odd even odd even)))
(check-equal ((1) (2) (3)) (zip '(1 2 3)))
(check-equal ((3 #f) (1 #t) (4 #f) (1 #t)) (zip '(3 1 4 1) (circular-list #f #t)))

(check-equal (1 2 3) (unzip1 '((1 2 3) (2 3 4) (3 4 5))))
(check-equal ((1 2 3) (one two three))
     (let-values (((lst1 lst2) (unzip2 '((1 one) (2 two) (3 three))))) (list lst1 lst2)))
(check-equal (1 2 3 4)
    (unzip1 '((1 one a #\a "a") (2 two b #\b "b") (3 three c #\c "c") (4 four d #\d "d"))))
(check-equal ((1 2 3 4) (one two three four))
    (let-values (((lst1 lst2)
            (unzip2 '((1 one a #\a "a") (2 two b #\b "b") (3 three c #\c "c") (4 four d #\d "d")))))
        (list lst1 lst2)))
(check-equal ((1 2 3 4) (one two three four) (a b c d))
    (let-values (((lst1 lst2 lst3)
            (unzip3 '((1 one a #\a "a") (2 two b #\b "b") (3 three c #\c "c") (4 four d #\d "d")))))
        (list lst1 lst2 lst3)))
(check-equal ((1 2 3 4) (one two three four) (a b c d) (#\a #\b #\c #\d))
    (let-values (((lst1 lst2 lst3 lst4)
            (unzip4 '((1 one a #\a "a") (2 two b #\b "b") (3 three c #\c "c") (4 four d #\d "d")))))
        (list lst1 lst2 lst3 lst4)))
(check-equal ((1 2 3 4) (one two three four) (a b c d) (#\a #\b #\c #\d) ("a" "b" "c" "d"))
    (let-values (((lst1 lst2 lst3 lst4 lst5)
            (unzip5 '((1 one a #\a "a") (2 two b #\b "b") (3 three c #\c "c") (4 four d #\d "d")))))
        (list lst1 lst2 lst3 lst4 lst5)))

(check-equal 3 (count even? '(3 1 4 1 5 9 2 5 6)))
(check-equal 3 (count < '(1 2 4 8) '(2 4 6 8 10 12 14 16)))
(check-equal 2 (count < '(3 1 4 1) (circular-list 1 10)))

(check-equal 10 (fold + 0 '(1 2 3 4)))
(check-equal (5 4 3 2 1) (fold cons '() '(1 2 3 4 5)))
(check-equal 3
    (fold (lambda (x count) (if (symbol? x) (+ count 1) count)) 0
            '(a "a" #\a 1 2 3 (b c) d #(e f g) h)))
(check-equal 10
    (fold (lambda (s max-len) (max max-len (string-length s))) 0
            '("abc" "def" "1234567890" "123456789" "wxyz")))
(check-equal (c 3 b 2 a 1) (fold cons* '() '(a b c) '(1 2 3 4 5)))
(check-equal (10 8 6)
    (fold (lambda (frst snd val) (cons (+ frst snd) val)) '() '(1 2 3 4) '(5 6 7)))

(check-equal (1 3 5 7)
    (fold-right (lambda (n lst) (if (odd? n) (cons n lst) lst)) '() '(1 2 3 4 5 6 7 8)))
(check-equal (a 1 b 2 c 3) (fold-right cons* '() '(a b c) '(1 2 3 4 5)))
(check-equal (6 8 10)
    (fold-right (lambda (frst snd val) (cons (+ frst snd) val)) '() '(1 2 3 4) '(5 6 7)))

(check-equal (5 4 3 2 1)
    (pair-fold (lambda (pair tail) (set-cdr! pair tail) pair) '() '(1 2 3 4 5)))
(check-equal 10
    (pair-fold (lambda (s max-len) (max max-len (string-length (car s)))) 0
            '("abc" "def" "1234567890" "123456789" "wxyz")))
(check-equal (10 8 6)
    (pair-fold (lambda (frst snd val) (cons (+ (car frst) (car snd)) val)) '() '(1 2 3 4) '(5 6 7)))

(check-equal (1 3 5 7)
    (pair-fold-right (lambda (n lst) (if (odd? (car n)) (cons (car n) lst) lst)) '()
            '(1 2 3 4 5 6 7 8)))
(check-equal (6 8 10)
    (pair-fold-right (lambda (frst snd val) (cons (+ (car frst) (car snd)) val)) '()
            '(1 2 3 4) '(5 6 7)))

(check-equal 10 (reduce max 0 '(8 4 3 -5 10 9)))

(check-equal (1 2 3 4 5 6 7 8 9) (reduce-right append '() '((1 2 3) (4 5) (6 7 8) (9))))

(check-equal (1 4 9 16 25 36 49 64 81 100)
    (unfold (lambda (x) (> x 10)) (lambda (x) (* x x)) (lambda (x) (+ x 1)) 1))

(check-equal (1 2 3 4 5) (unfold null-list? car cdr '(1 2 3 4 5)))
(check-equal (1 2 3 4 5) (unfold null-list? car cdr '(1 2) (lambda (x) '(3 4 5))))

(check-equal (1 4 9 16 25 36 49 64 81 100)
    (unfold-right zero? (lambda (x) (* x x)) (lambda (x) (- x 1)) 10))
(check-equal (5 4 3 2 1) (unfold-right null-list? car cdr '(1 2 3 4 5)))
(check-equal (3 2 1 4 5) (unfold-right null-list? car cdr '(1 2 3) '(4 5)))
(check-equal (3 2 1) (unfold-right null-list? car cdr '(1 2 3) '()))
(check-equal (4 5) (unfold-right null-list? car cdr '() '(4 5)))

(check-equal (b e h) (map cadr '((a b) (d e) (g h))))
(check-equal (1 4 27 256 3125) (map (lambda (n) (expt n n)) '(1 2 3 4 5)))
(check-equal (5 7 9) (map + '(1 2 3) '(4 5 6)))
(check-equal #t
    (let ((ret (let ((count 0)) (map (lambda (ignored) (set! count (+ count 1)) count) '(a b)))))
        (or (equal? ret '(1 2)) (equal? ret '(2 1)))))
(check-equal (4 1 5 1) (map + '(3 1 4 1) (circular-list 1 0)))

(check-equal #(0 1 4 9 16)
    (let ((v (make-vector 5))) (for-each (lambda (i) (vector-set! v i (* i i))) '(0 1 2 3 4)) v))
(check-equal #(1 1 3 3 5)
    (let ((v (make-vector 5)))
        (for-each (lambda (a b) (vector-set! v a (+ a b))) '(0 1 2 3 4) (circular-list 1 0)) v))

(check-equal (1 -1 3 -3 8 -8) (append-map (lambda (x) (list x (- x))) '(1 3 8)))
(check-equal (1 0 2 1 3 0 4 1 5 0)
    (append-map (lambda (x y) (list x y)) '(1 2 3 4 5) (circular-list 0 1)))

(check-equal (1 -1 3 -3 8 -8) (append-map! (lambda (x) (list x (- x))) '(1 3 8)))
(check-equal (1 0 2 1 3 0 4 1 5 0)
    (append-map! (lambda (x y) (list x y)) '(1 2 3 4 5) (circular-list 0 1)))

(check-equal (b e h) (map! cadr '((a b) (d e) (g h))))
(check-equal (1 4 27 256 3125) (map! (lambda (n) (expt n n)) '(1 2 3 4 5)))
(check-equal (5 7 9) (map! + '(1 2 3) '(4 5 6)))
(check-equal #t
    (let ((ret (let ((count 0)) (map! (lambda (ignored) (set! count (+ count 1)) count) '(a b)))))
        (or (equal? ret '(1 2)) (equal? ret '(2 1)))))
(check-equal (4 1 5 1) (map! + '(3 1 4 1) (circular-list 1 0)))

(check-equal (b e h) (map-in-order cadr '((a b) (d e) (g h))))
(check-equal (1 4 27 256 3125) (map-in-order (lambda (n) (expt n n)) '(1 2 3 4 5)))
(check-equal (5 7 9) (map-in-order + '(1 2 3) '(4 5 6)))
(check-equal #t
    (let ((ret (let ((count 0))
                   (map-in-order (lambda (ignored) (set! count (+ count 1)) count) '(a b)))))
        (or (equal? ret '(1 2)) (equal? ret '(2 1)))))
(check-equal (4 1 5 1) (map-in-order + '(3 1 4 1) (circular-list 1 0)))

(check-equal #((0 1 2 3) (1 2 3) (2 3) (3))
    (let ((v (make-vector 4)))
        (pair-for-each (lambda (lst) (vector-set! v (car lst) lst)) '(0 1 2 3)) v))
(check-equal #((0 . a) (1 . b) (2 . c) (3 . d))
    (let ((v (make-vector 4)))
        (pair-for-each (lambda (fst snd) (vector-set! v (car fst) (cons (car fst) (car snd))))
                '(0 1 2 3) '(a b c d))
        v))

(check-equal (1 9 49) (filter-map (lambda (x) (and (number? x) (* x x))) '(a 1 b 3 c 7)))
(check-equal (0 2 4 6)
    (filter-map (lambda (n b) (and b n)) '(0 1 2 3 4 5 6) (circular-list #t #f)))

(check-equal (0 8 8 -4) (filter even? '(0 7 8 8 43 -4)))
(check-equal () (filter even? '(1 3 5 7)))
(check-equal () (filter even? '()))

(check-equal ((one four five) (2 3 6))
    (let-values (((nums syms) (partition symbol? '(one 2 3 four five 6))))
        (list nums syms)))

(check-equal (0 8 8 -4) (remove odd? '(0 7 8 8 43 -4)))
(check-equal () (remove odd? '(1 3 5 7)))
(check-equal () (remove odd? '()))
(check-equal (7 43) (remove even? '(0 7 8 8 43 -4)))

(check-equal (0 8 8 -4) (filter! even? '(0 7 8 8 43 -4)))
(check-equal () (filter! even? '(1 3 5 7)))
(check-equal () (filter! even? '()))

(check-equal ((one four five) (2 3 6))
    (let-values (((nums syms) (partition! symbol? '(one 2 3 four five 6))))
        (list nums syms)))

(check-equal (0 8 8 -4) (remove! odd? '(0 7 8 8 43 -4)))
(check-equal () (remove! odd? '(1 3 5 7)))
(check-equal () (remove! odd? '()))
(check-equal (7 43) (remove! even? '(0 7 8 8 43 -4)))

(check-equal 2 (find even? '(1 2 3)))
(check-equal #f (find even? '(1 7 3)))
(check-equal 2 (find even? '(1 2 . x)))
(check-equal 6 (find even? (circular-list 1 6 3)))
(check-equal 4 (find even? '(3 1 4 1 5 9)))

(check-equal (2 3) (find-tail even? '(1 2 3)))
(check-equal #f (find-tail even? '(1 7 3)))
(check-equal (2 . x)  (find-tail even? '(1 2 . x)))
(check-equal (4 1 5 9) (find-tail even? '(3 1 4 1 5 9)))
(check-equal (-8 -5 0 0) (find-tail even? '(3 1 37 -8 -5 0 0)))
(check-equal #f (find-tail even? '(3 1 37 -5)))

(check-equal (2 18) (take-while even? '(2 18 3 10 22 9)))
(check-equal () (take-while odd? '(2 18 4 10 22 20)))
(check-equal (2 18 4 10 22 20) (take-while even? '(2 18 4 10 22 20)))

(check-equal (2 18) (take-while! even? '(2 18 3 10 22 9)))
(check-equal () (take-while! odd? '(2 18 4 10 22 20)))
(check-equal (2 18 4 10 22 20) (take-while! even? '(2 18 4 10 22 20)))

(check-equal (3 10 22 9) (drop-while even? '(2 18 3 10 22 9)))

(check-equal ((2 18) (3 10 22 9))
    (let-values (((pre suf) (span even? '(2 18 3 10 22 9)))) (list pre suf)))
(check-equal ((2 18 4 10 22 20) ())
    (let-values (((pre suf) (span even? '(2 18 4 10 22 20)))) (list pre suf)))
(check-equal (() (2 18 4 10 22 20))
    (let-values (((pre suf) (span odd? '(2 18 4 10 22 20)))) (list pre suf)))

(check-equal ((3 1) (4 1 5 9))
    (let-values (((pre suf) (break even? '(3 1 4 1 5 9)))) (list pre suf)))
(check-equal ((2 18 4 10 22 20) ())
    (let-values (((pre suf) (break odd? '(2 18 4 10 22 20)))) (list pre suf)))
(check-equal (() (2 18 4 10 22 20))
    (let-values (((pre suf) (break even? '(2 18 4 10 22 20)))) (list pre suf)))

(check-equal #t (any even? '(1 2 3)))
(check-equal #f (any even? '(1 7 3)))
(check-equal #t (any even? (circular-list 1 6 3)))
(check-equal #t (any integer? '(a 3 b 2.7)))
(check-equal #f (any integer? '(a 3.1 b 2.7)))
(check-equal #t (any < '(3 1 4 1 5) '(2 7 1 8 2)))
(check-equal #f (any even? '()))
(check-equal #f (any < '(3 7 4 1 5) '(2 7)))

(check-equal #t (every even? '(2 4 6 8)))
(check-equal #f (every even? '(2 4 5 8)))
(check-equal #t (every < '(1 2 3 4 5) '(2 3 4)))
(check-equal #t (every even? '()))

(check-equal 2 (list-index even? '(3 1 4 1 5 9)))
(check-equal 1(list-index < '(3 1 4 1 5 9 2 5 6) '(2 7 1 8 2)))
(check-equal #f (list-index = '(3 1 4 1 5 9 2 5 6) '(2 7 1 8 2)))

(check-equal (a b c) (memq 'a '(a b c)))
(check-equal (b c) (memq 'b '(a b c)))
(check-equal #f (memq 'a '(b c d)))
(check-equal #f (memq (list 'a) '(b (a) c)))
(check-equal ((a) c) (member (list 'a) '(b (a) c)))
(check-equal (101 102) (memq 101 '(100 101 102)))
(check-equal (101 102) (memv 101 '(100 101 102)))

(check-equal (b c d) (delete 'a '(a b c d)))
(check-equal (b c d) (delete 'a '(a b a a c d a)))
(check-equal (b c d) (delete 'a '(b c d)))
(check-equal () (delete 'a '(a a a a)))
(check-equal () (delete 'a '()))
(check-equal (11 12 13) (delete 11 '(8 9 10 11 12 13) >))

(check-equal (a b c z) (delete-duplicates '(a b a c a b c z)))
(check-equal ((a . 3) (b . 7) (c . 1))
    (delete-duplicates '((a . 3) (b . 7) (a . 9) (c . 1))
            (lambda (x y) (eq? (car x) (car y)))))

(check-equal (a 1) (assq 'a '((a 1) (b 2) (c 3))))
(check-equal (b 2) (assq 'b '((a 1) (b 2) (c 3))))
(check-equal #f (assq 'd '((a 1) (b 2) (c 3))))
(check-equal #f (assq (list 'a) '(((a)) ((b)) ((c)))))
(check-equal ((a)) (assoc (list 'a) '(((a)) ((b)) ((c)))))
(check-equal (5 7) (assq 5 '((2 3) (5 7) (11 13))))
(check-equal (5 7) (assv 5 '((2 3) (5 7) (11 13))))

(check-equal ((a . 1)) (alist-cons 'a 1 '()))
(check-equal ((a . 1) (b . 2)) (alist-cons 'a 1 '((b . 2))))

(check-equal ((a . 1) (b . 2) (c . 3)) (alist-copy '((a . 1) (b . 2) (c . 3))))
(check-equal () (alist-copy '()))

(check-equal #t (lset<= eq? '(a) '(a b a) '(a b c c)))
(check-equal #f (lset<= eq? '(a b a) '(a) '(a b c c)))
(check-equal #t (lset<= eq?))
(check-equal #t (lset<= eq? '(a)))

(check-equal #t (lset= eq? '(b e a) '(a e b) '(e e b a)))
(check-equal #t (lset= eq?))
(check-equal #t (lset= eq? '(a)))
(check-equal #f (lset= eq? '(b e a d) '(a e b) '(e e b a)))
(check-equal #f (lset= eq? '(b e a) '(a d e b) '(e e b a)))
(check-equal #f (lset= eq? '(b e a) '(a e b) '(e d e b a)))

(check-equal (u o i a b c d c e) (lset-adjoin eq? '(a b c d c e) 'a 'e 'i 'o 'u))

(check-equal (u o i a b c d e) (lset-union eq? '(a b c d e) '(a e i o u)))
(check-equal (x a a c) (lset-union eq? '(a a c) '(x a x)))
(check-equal () (lset-union eq?))
(check-equal (a b c) (lset-union eq? '(a b c)))

(check-equal (a e) (lset-intersection eq? '(a b c d e) '(a e i o u)))
(check-equal (a x a) (lset-intersection eq? '(a x y a) '(x a x z)))
(check-equal (a b c) (lset-intersection eq? '(a b c)))

(check-equal (b c d) (lset-difference eq? '(a b c d e) '(a e i o u)))
(check-equal (a b c) (lset-difference eq? '(a b c)))

(check-equal (b c d i o u) (lset-xor eq? '(a b c d e) '(a e i o u)))
(check-equal () (lset-xor eq?))
(check-equal (a b c d e) (lset-xor eq? '(a b c d e)))

(check-equal ((b c d) (a e))
    (let-values (((diff inter) (lset-diff+intersection eq? '(a b c d e) '(a e i o u))))
        (list diff inter)))

;;
;; ---- SRFI 128: Comparators ----
;;

(import (foment base))
(import (scheme char))
(import (scheme comparator))

(define default-comparator (make-default-comparator))
(define boolean-comparator
    (make-comparator boolean? eq? (lambda (x y) (and (not x) y)) boolean-hash))
(define char-comparator
    (make-comparator char? char=? char<? char-hash))
(define string-ci-comparator
    (make-comparator string? string-ci=? string-ci<? string-ci-hash))
(define symbol-comparator
    (make-comparator symbol? eq?
            (lambda (obj1 obj2) (string<? (symbol->string obj1) (symbol->string obj2)))
            symbol-hash))
(define fail-comparator
    (make-comparator (lambda (obj) #t) eq? #f #f))
(define number-comparator
    (make-comparator number? = < number-hash))
(define pnb-comparator
    (make-pair-comparator number-comparator boolean-comparator))
(define ln-comparator
    (make-list-comparator number-comparator list? null? car cdr))
(define vn-comparator
    (make-vector-comparator number-comparator vector? vector-length vector-ref))
(define eq-comparator (make-eq-comparator))
(define eqv-comparator (make-eqv-comparator))
(define equal-comparator (make-equal-comparator))

(check-equal #t (comparator? (make-comparator (lambda (obj) #t) eq? #f #f)))
(check-equal #t (comparator? (make-default-comparator)))
(check-equal #f (comparator? (list 'make-comparator (lambda (obj) #t) eq? #f #f)))
(check-equal #t (comparator? boolean-comparator))
(check-equal #t (comparator? symbol-comparator))

(check-equal #t (comparator-ordered? boolean-comparator))
(check-equal #f (comparator-ordered? (make-comparator (lambda (obj) #t) eq? #f #f)))
(check-equal #f (comparator-ordered? fail-comparator))

(check-equal #t (comparator-hashable? boolean-comparator))
(check-equal #f (comparator-hashable? (make-comparator (lambda (obj) #t) eq? #f #f)))
(check-equal #f (comparator-hashable? fail-comparator))

(check-error (assertion-violation no-ordering-predicate)
    ((comparator-ordering-predicate fail-comparator) 1 2))
(check-error (assertion-violation no-hash-function)
    ((comparator-hash-function fail-comparator) 1))

(check-equal #t (comparator-test-type pnb-comparator '(12 . #t)))
(check-equal #f (comparator-test-type pnb-comparator '(#t . 12)))
(check-equal #f (comparator-test-type pnb-comparator '(#t 12)))
(check-equal #f (comparator-test-type pnb-comparator #t))
(check-equal #f (comparator-test-type pnb-comparator 12))
(check-equal #t (=? pnb-comparator '(12 . #t) '(12 . #t)))
(check-equal #f (=? pnb-comparator '(12 . #t) '(11 . #t)))
(check-equal #f (=? pnb-comparator '(12 . #t) '(12 . #f)))
(check-equal #t (<? pnb-comparator '(12 . #t) '(13 . #t)))
(check-equal #t (<? pnb-comparator '(12 . #f) '(12 . #t)))
(check-equal #f (<? pnb-comparator '(12 . #t) '(12 . #t)))
(check-equal #f (<? pnb-comparator '(13 . #t) '(12 . #t)))
(check-equal #f (<? pnb-comparator '(12 . #t) '(12 . #f)))
(check-equal #t
    (= (comparator-hash pnb-comparator '(12 . #t)) (comparator-hash pnb-comparator '(12 . #t))))
(check-equal #f
    (= (comparator-hash pnb-comparator '(13 . #t)) (comparator-hash pnb-comparator '(12 . #t))))
(check-equal #f
    (= (comparator-hash pnb-comparator '(12 . #f)) (comparator-hash pnb-comparator '(12 . #t))))

(check-equal #t (comparator-test-type ln-comparator '(12 34)))
(check-equal #f (comparator-test-type ln-comparator '(12 . 34)))
(check-equal #f (comparator-test-type ln-comparator '(12 34 #t)))
(check-equal #f (comparator-test-type ln-comparator 123))
(check-equal #t (=? ln-comparator '(12 34) '(12 34)))
(check-equal #f (=? ln-comparator '(12 34) '(12 34 56)))
(check-equal #f (=? ln-comparator '(12 34) '(12 35)))
(check-equal #f (=? ln-comparator '(12 34) '(13 34)))
(check-equal #t (<? ln-comparator '(12 34) '(12 35)))
(check-equal #f (<? ln-comparator '(12 34) '(12 34)))
(check-equal #f (<? ln-comparator '(12 34 56) '(12 34)))
(check-equal #t (<? ln-comparator '(12 34) '(12 34 56)))
(check-equal #f (<? ln-comparator '(13 34) '(12 34)))
(check-equal #f (<? ln-comparator '(12 35) '(12 34)))

(check-equal #t (comparator-test-type vn-comparator #(12 34)))
(check-equal #f (comparator-test-type vn-comparator '(12 34)))
(check-equal #f (comparator-test-type vn-comparator #(12 34 #t)))
(check-equal #f (comparator-test-type vn-comparator 123))
(check-equal #t (=? vn-comparator #(12 34) #(12 34)))
(check-equal #f (=? vn-comparator #(12 34) #(12 34 56)))
(check-equal #f (=? vn-comparator #(12 34) #(12 35)))
(check-equal #f (=? vn-comparator #(12 34) #(13 34)))
(check-equal #t (<? vn-comparator #(12 34) #(12 35)))
(check-equal #f (<? vn-comparator #(12 34) #(12 34)))
(check-equal #f (<? vn-comparator #(12 34 56) #(12 34)))
(check-equal #t (<? vn-comparator #(12 34) #(12 34 56)))
(check-equal #f (<? vn-comparator #(13 34) #(12 34)))
(check-equal #f (<? vn-comparator #(12 35) #(12 34)))

(check-equal #t (comparator-test-type eq-comparator #t))
(check-equal #t (comparator-test-type eq-comparator (lambda (obj) obj)))
(check-equal #t (comparator-test-type eq-comparator 123))
(check-equal #t (comparator-test-type eq-comparator '(1 2 3)))
(check-equal #t (comparator-test-type eq-comparator cons))
(check-equal #t (=? eq-comparator 123 123))
(check-equal #f (=? eq-comparator 123 123.456))
(check-equal #f (=? eq-comparator '(1 2 3) '(1 2 3)))
(check-equal #t (let ((lst '(1 2 3))) (=? eq-comparator lst lst)))
(check-equal #f (=? eq-comparator #(1 2 3) #(1 2 3)))
(check-equal #t (let ((vec '#(1 2 3))) (=? eq-comparator vec vec)))
(check-equal #t (eq? default-hash (comparator-hash-function eq-comparator)))

(check-equal #t (comparator-test-type eqv-comparator #t))
(check-equal #t (comparator-test-type eqv-comparator (lambda (obj) obj)))
(check-equal #t (comparator-test-type eqv-comparator 123))
(check-equal #t (comparator-test-type eqv-comparator '(1 2 3)))
(check-equal #t (comparator-test-type eqv-comparator cons))
(check-equal #t (=? eqv-comparator 123 123))
(check-equal #f (=? eqv-comparator 123 123.456))
(check-equal #f (=? eqv-comparator '(1 2 3) '(1 2 3)))
(check-equal #t (let ((lst '(1 2 3))) (=? eqv-comparator lst lst)))
(check-equal #f (=? eqv-comparator #(1 2 3) #(1 2 3)))
(check-equal #t (let ((vec '#(1 2 3))) (=? eqv-comparator vec vec)))
(check-equal #t (eq? default-hash (comparator-hash-function eqv-comparator)))

(check-equal #t (comparator-test-type equal-comparator #t))
(check-equal #t (comparator-test-type equal-comparator (lambda (obj) obj)))
(check-equal #t (comparator-test-type equal-comparator 123))
(check-equal #t (comparator-test-type equal-comparator '(1 2 3)))
(check-equal #t (comparator-test-type equal-comparator cons))
(check-equal #t (=? equal-comparator 123 123))
(check-equal #f (=? equal-comparator 123 123.456))
(check-equal #t (=? equal-comparator '(1 2 3) '(1 2 3)))
(check-equal #t (let ((lst '(1 2 3))) (=? equal-comparator lst lst)))
(check-equal #t (=? equal-comparator #(1 2 3) #(1 2 3)))
(check-equal #t (let ((vec '#(1 2 3))) (=? equal-comparator vec vec)))
(check-equal #t (eq? default-hash (comparator-hash-function equal-comparator)))

(check-equal #t (= (boolean-hash #t) (boolean-hash #t)))
(check-equal #t (= (boolean-hash #f) (boolean-hash #f)))
(check-equal #f (= (boolean-hash #f) (boolean-hash #t)))

(check-equal #t (= (char-hash #\a) (char-hash #\a)))
(check-equal #f (= (char-hash #\a) (char-hash #\A)))
(check-equal #f (= (char-hash #\a) (char-hash #\b)))

(check-equal #t (= (char-ci-hash #\a) (char-ci-hash #\a)))
(check-equal #t (= (char-ci-hash #\a) (char-ci-hash #\A)))
(check-equal #f (= (char-ci-hash #\a) (char-ci-hash #\b)))

(check-equal #t (= (string-hash "abcdef") (string-hash "abcdef")))
(check-equal #f (= (string-hash "abcdef") (string-hash "Abcdef")))
(check-equal #f (= (string-hash "abcdef") (string-hash "bcdefg")))

(check-equal #t (= (string-ci-hash "abcdef") (string-ci-hash "abcdef")))
(check-equal #t (= (string-ci-hash "abcdef") (string-ci-hash "Abcdef")))
(check-equal #f (= (string-ci-hash "abcdef") (string-ci-hash "bcdefg")))

(check-equal #t (= (symbol-hash 'abc) (symbol-hash (string->symbol "abc"))))
(check-equal #f (= (symbol-hash 'abc) (symbol-hash 'abcd)))

(check-equal #t (= (number-hash 123) (number-hash 123)))
(check-equal #f (= (number-hash 123) (number-hash 456)))

(check-equal #t (= (number-hash 123.456) (number-hash 123.456)))
(check-equal #f (= (number-hash 123.456) (number-hash 456.789)))

(check-equal #t (<? default-comparator '() '(1 . 2)))
(check-equal #f (<? default-comparator '(1 . 2) '()))
(check-equal #t (<? default-comparator #f #t))
(check-equal #f (<? default-comparator #t #f))

(check-equal #t (eq? default-hash (comparator-hash-function default-comparator)))

(check-equal #t (comparator-test-type boolean-comparator #t))
(check-equal #f (comparator-test-type boolean-comparator 't))
(check-equal #f (comparator-test-type boolean-comparator '()))
(check-error (assertion-violation comparator-check-type)
    (comparator-check-type boolean-comparator 123))
(check-equal #t (=? boolean-comparator #f #f))
(check-equal #f (=? boolean-comparator #t #f))
(check-equal -1 (comparator-if<=> boolean-comparator #f #t -1 0 1))
(check-equal 0 (comparator-if<=> boolean-comparator #f #f -1 0 1))
(check-equal 1 (comparator-if<=> boolean-comparator #t #f -1 0 1))
(check-equal #t (= (comparator-hash boolean-comparator #f)
    (comparator-hash boolean-comparator #f)))
(check-equal #f (= (comparator-hash boolean-comparator #t)
    (comparator-hash boolean-comparator #f)))

(check-equal #t (comparator-test-type char-comparator #\A))
(check-equal #f (comparator-test-type char-comparator 'a))
(check-equal #t (=? char-comparator #\z #\z))
(check-equal #f (=? char-comparator #\Z #\z))
(check-equal -1 (comparator-if<=> char-comparator #\a #\f -1 0 1))
(check-equal 0 (comparator-if<=> char-comparator #\Q #\Q -1 0 1))
(check-equal 1 (comparator-if<=> char-comparator #\F #\A -1 0 1))
(check-equal #t (= (comparator-hash char-comparator #\w)
    (comparator-hash char-comparator #\w)))
(check-equal #f (= (comparator-hash char-comparator #\w)
    (comparator-hash char-comparator #\x)))

(check-equal #t (comparator-test-type string-ci-comparator "abc"))
(check-equal #f (comparator-test-type string-ci-comparator #\a))
(check-equal #t (=? string-ci-comparator "xyz" "xyz"))
(check-equal #t (=? string-ci-comparator "XYZ" "xyz"))
(check-equal #f (=? string-ci-comparator "xyz" "zyx"))
(check-equal -1 (comparator-if<=> string-ci-comparator "abc" "def" -1 0 1))
(check-equal -1 (comparator-if<=> string-ci-comparator "ABC" "def" -1 0 1))
(check-equal -1 (comparator-if<=> string-ci-comparator "abc" "DEF" -1 0 1))
(check-equal 0 (comparator-if<=> string-ci-comparator "ghi" "ghi" -1 0 1))
(check-equal 0 (comparator-if<=> string-ci-comparator "ghi" "GHI" -1 0 1))
(check-equal 1 (comparator-if<=> string-ci-comparator "mno" "jkl" -1 0 1))
(check-equal 1 (comparator-if<=> string-ci-comparator "MNO" "jkl" -1 0 1))
(check-equal 1 (comparator-if<=> string-ci-comparator "mno" "JKL" -1 0 1))
(check-equal #t (= (comparator-hash string-ci-comparator "xyz")
    (comparator-hash string-ci-comparator "xyz")))
(check-equal #t (= (comparator-hash string-ci-comparator "xyz")
    (comparator-hash string-ci-comparator "XYZ")))
(check-equal #f (= (comparator-hash string-ci-comparator "xyz")
    (comparator-hash string-ci-comparator "zyx")))

(check-equal #t (comparator-test-type symbol-comparator 'abc))
(check-equal #f (comparator-test-type symbol-comparator "abc"))
(check-equal #t (=? symbol-comparator 'xyz 'xyz))
(check-equal #f (=? symbol-comparator 'XYZ 'xyz))
(check-equal -1 (comparator-if<=> symbol-comparator 'abc 'def -1 0 1))
(check-equal 0 (comparator-if<=> symbol-comparator 'ghi 'ghi -1 0 1))
(check-equal 1 (comparator-if<=> symbol-comparator 'mno 'jkl -1 0 1))
(check-equal #t (= (comparator-hash symbol-comparator 'pqr)
    (comparator-hash symbol-comparator 'pqr)))
(check-equal #f (= (comparator-hash symbol-comparator 'stu)
    (comparator-hash symbol-comparator 'vwx)))

(check-equal #t (<? default-comparator #f #t))
(check-equal #f (<? default-comparator #f #f))
(check-equal #f (<? default-comparator #t #t))
(check-equal #f (<? default-comparator #t #f))

;; Tests from the reference implementation of comparators.

  (define (vector-cdr vec)
    (let* ((len (vector-length vec))
           (result (make-vector (- len 1))))
      (let loop ((n 1))
        (cond
          ((= n len) result)
          (else (vector-set! result (- n 1) (vector-ref vec n))
                (loop (+ n 1)))))))

  (check-equal #(2 3 4) (vector-cdr '#(1 2 3 4)))
  (check-equal #() (vector-cdr '#(1)))

;  (define default-comparator (make-default-comparator))
  (define real-comparator (make-comparator real? = < number-hash))
  (define degenerate-comparator (make-comparator (lambda (x) #t) equal? #f #f))
;  (define boolean-comparator
;    (make-comparator boolean? eq? (lambda (x y) (and (not x) y)) boolean-hash))
  (define bool-pair-comparator (make-pair-comparator boolean-comparator boolean-comparator))
  (define num-list-comparator
    (make-list-comparator real-comparator list? null? car cdr))
  (define num-vector-comparator
    (make-vector-comparator real-comparator vector? vector-length vector-ref))
  (define vector-qua-list-comparator
    (make-list-comparator
      real-comparator
      vector?
      (lambda (vec) (= 0 (vector-length vec)))
      (lambda (vec) (vector-ref vec 0))
      vector-cdr))
  (define list-qua-vector-comparator
     (make-vector-comparator default-comparator list? length list-ref))
;  (define eq-comparator (make-eq-comparator))
;  (define eqv-comparator (make-eqv-comparator))
;  (define equal-comparator (make-equal-comparator))
;  (define symbol-comparator
;    (make-comparator
;      symbol?
;      eq?
;      (lambda (a b) (string<? (symbol->string a) (symbol->string b)))
;      symbol-hash))

    (check-equal #t (comparator? real-comparator))
    (check-equal #t (not (comparator? =)))
    (check-equal #t (comparator-ordered? real-comparator))
    (check-equal #t (comparator-hashable? real-comparator))
    (check-equal #t (not (comparator-ordered? degenerate-comparator)))
    (check-equal #t (not (comparator-hashable? degenerate-comparator)))

    (check-equal #t (=? boolean-comparator #t #t))
    (check-equal #t (not (=? boolean-comparator #t #f)))
    (check-equal #t (<? boolean-comparator #f #t))
    (check-equal #t (not (<? boolean-comparator #t #t)))
    (check-equal #t (not (<? boolean-comparator #t #f)))

    (check-equal #t (comparator-test-type bool-pair-comparator '(#t . #f)))
    (check-equal #t (not (comparator-test-type bool-pair-comparator 32)))
    (check-equal #t (not (comparator-test-type bool-pair-comparator '(32 . #f))))
    (check-equal #t (not (comparator-test-type bool-pair-comparator '(#t . 32))))
    (check-equal #t (not (comparator-test-type bool-pair-comparator '(32 . 34))))
    (check-equal #t (=? bool-pair-comparator '(#t . #t) '(#t . #t)))
    (check-equal #t (not (=? bool-pair-comparator '(#t . #t) '(#f . #t))))
    (check-equal #t (not (=? bool-pair-comparator '(#t . #t) '(#t . #f))))
    (check-equal #t (<? bool-pair-comparator '(#f . #t) '(#t . #t)))
    (check-equal #t (<? bool-pair-comparator '(#t . #f) '(#t . #t)))
    (check-equal #t (not (<? bool-pair-comparator '(#t . #t) '(#t . #t))))
    (check-equal #t (not (<? bool-pair-comparator '(#t . #t) '(#f . #t))))
    (check-equal #t (not (<? bool-pair-comparator '(#f . #t) '(#f . #f))))

    (check-equal #t (comparator-test-type num-vector-comparator '#(1 2 3)))
    (check-equal #t (comparator-test-type num-vector-comparator '#()))
    (check-equal #t (not (comparator-test-type num-vector-comparator 1)))
    (check-equal #t (not (comparator-test-type num-vector-comparator '#(a 2 3))))
    (check-equal #t (not (comparator-test-type num-vector-comparator '#(1 b 3))))
    (check-equal #t (not (comparator-test-type num-vector-comparator '#(1 2 c))))
    (check-equal #t (=? num-vector-comparator '#(1 2 3) '#(1 2 3)))
    (check-equal #t (not (=? num-vector-comparator '#(1 2 3) '#(4 5 6))))
    (check-equal #t (not (=? num-vector-comparator '#(1 2 3) '#(1 5 6))))
    (check-equal #t (not (=? num-vector-comparator '#(1 2 3) '#(1 2 6))))
    (check-equal #t (<? num-vector-comparator '#(1 2) '#(1 2 3)))
    (check-equal #t (<? num-vector-comparator '#(1 2 3) '#(2 3 4)))
    (check-equal #t (<? num-vector-comparator '#(1 2 3) '#(1 3 4)))
    (check-equal #t (<? num-vector-comparator '#(1 2 3) '#(1 2 4)))
    (check-equal #t (<? num-vector-comparator '#(3 4) '#(1 2 3)))
    (check-equal #t (not (<? num-vector-comparator '#(1 2 3) '#(1 2 3))))
    (check-equal #t (not (<? num-vector-comparator '#(1 2 3) '#(1 2))))
    (check-equal #t (not (<? num-vector-comparator '#(1 2 3) '#(0 2 3))))
    (check-equal #t (not (<? num-vector-comparator '#(1 2 3) '#(1 1 3))))

    (check-equal #t (not (<? vector-qua-list-comparator '#(3 4) '#(1 2 3))))
    (check-equal #t (<? list-qua-vector-comparator '(3 4) '(1 2 3)))

    (define bool-pair (cons #t #f))
    (define bool-pair-2 (cons #t #f))
    (define reverse-bool-pair (cons #f #t))
    (check-equal #t (=? eq-comparator #t #t))
    (check-equal #t (not (=? eq-comparator #f #t)))
    (check-equal #t (=? eqv-comparator bool-pair bool-pair))
    (check-equal #t (not (=? eqv-comparator bool-pair bool-pair-2)))
    (check-equal #t (=? equal-comparator bool-pair bool-pair-2))
    (check-equal #t (not (=? equal-comparator bool-pair reverse-bool-pair)))

    (check-equal #t (exact-integer? (boolean-hash #f)))
    (check-equal #t (not (negative? (boolean-hash #t))))
    (check-equal #t (exact-integer? (char-hash #\a)))
    (check-equal #t (not (negative? (char-hash #\b))))
    (check-equal #t (exact-integer? (char-ci-hash #\a)))
    (check-equal #t (not (negative? (char-ci-hash #\b))))
    (check-equal #t (= (char-ci-hash #\a) (char-ci-hash #\A)))
    (check-equal #t (exact-integer? (string-hash "f")))
    (check-equal #t (not (negative? (string-hash "g"))))
    (check-equal #t (exact-integer? (string-ci-hash "f")))
    (check-equal #t (not (negative? (string-ci-hash "g"))))
    (check-equal #t (= (string-ci-hash "f") (string-ci-hash "F")))
    (check-equal #t (exact-integer? (symbol-hash 'f)))
    (check-equal #t (not (negative? (symbol-hash 't))))
    (check-equal #t (exact-integer? (number-hash 3)))
    (check-equal #t (not (negative? (number-hash 3))))
    (check-equal #t (exact-integer? (number-hash -3)))
    (check-equal #t (not (negative? (number-hash -3))))
    (check-equal #t (exact-integer? (number-hash 3.0)))
    (check-equal #t (not (negative? (number-hash 3.0))))

    (check-equal #t (<? default-comparator '() '(a)))
    (check-equal #t (not (=? default-comparator '() '(a))))
    (check-equal #t (=? default-comparator #t #t))
    (check-equal #t (not (=? default-comparator #t #f)))
    (check-equal #t (<? default-comparator #f #t))
    (check-equal #t (not (<? default-comparator #t #t)))
    (check-equal #t (=? default-comparator #\a #\a))
    (check-equal #t (<? default-comparator #\a #\b))

    (check-equal #t (comparator-test-type default-comparator '()))
    (check-equal #t (comparator-test-type default-comparator #t))
    (check-equal #t (comparator-test-type default-comparator #\t))
    (check-equal #t (comparator-test-type default-comparator '(a)))
    (check-equal #t (comparator-test-type default-comparator 'a))
    (check-equal #t (comparator-test-type default-comparator (make-bytevector 10)))
    (check-equal #t (comparator-test-type default-comparator 10))
    (check-equal #t (comparator-test-type default-comparator 10.0))
    (check-equal #t (comparator-test-type default-comparator "10.0"))
    (check-equal #t (comparator-test-type default-comparator '#(10)))

    (check-equal #t (=? default-comparator '(#t . #t) '(#t . #t)))
    (check-equal #t (not (=? default-comparator '(#t . #t) '(#f . #t))))
    (check-equal #t (not (=? default-comparator '(#t . #t) '(#t . #f))))
    (check-equal #t (<? default-comparator '(#f . #t) '(#t . #t)))
    (check-equal #t (<? default-comparator '(#t . #f) '(#t . #t)))
    (check-equal #t (not (<? default-comparator '(#t . #t) '(#t . #t))))
    (check-equal #t (not (<? default-comparator '(#t . #t) '(#f . #t))))
    (check-equal #t (not (<? default-comparator '#(#f #t) '#(#f #f))))

    (check-equal #t (=? default-comparator '#(#t #t) '#(#t #t)))
    (check-equal #t (not (=? default-comparator '#(#t #t) '#(#f #t))))
    (check-equal #t (not (=? default-comparator '#(#t #t) '#(#t #f))))
    (check-equal #t (<? default-comparator '#(#f #t) '#(#t #t)))
    (check-equal #t (<? default-comparator '#(#t #f) '#(#t #t)))
    (check-equal #t (not (<? default-comparator '#(#t #t) '#(#t #t))))
    (check-equal #t (not (<? default-comparator '#(#t #t) '#(#f #t))))
    (check-equal #t (not (<? default-comparator '#(#f #t) '#(#f #f))))

    (check-equal #t (= (comparator-hash default-comparator #t) (boolean-hash #t)))
    (check-equal #t (= (comparator-hash default-comparator #\t) (char-hash #\t)))
    (check-equal #t (= (comparator-hash default-comparator "t") (string-hash "t")))
    (check-equal #t (= (comparator-hash default-comparator 't) (symbol-hash 't)))
    (check-equal #t (= (comparator-hash default-comparator 10) (number-hash 10)))
    (check-equal #t (= (comparator-hash default-comparator 10.0) (number-hash 10.0)))

    (comparator-register-default!
      (make-comparator procedure? (lambda (a b) #t) (lambda (a b) #f) (lambda (obj) 200)))
    (check-equal #t (=? default-comparator (lambda () #t) (lambda () #f)))
    (check-equal #t (not (<? default-comparator (lambda () #t) (lambda () #f))))
    (check-equal 200 (comparator-hash default-comparator (lambda () #t)))

    (define ttp (lambda (x) #t))
    (define eqp (lambda (x y) #t))
    (define orp (lambda (x y) #t))
    (define hf (lambda (x) 0))
    (define comp (make-comparator ttp eqp orp hf))
    (check-equal #t (equal? ttp (comparator-type-test-predicate comp)))
    (check-equal #t (equal? eqp (comparator-equality-predicate comp)))
    (check-equal #t (equal? orp (comparator-ordering-predicate comp)))
    (check-equal #t (equal? hf (comparator-hash-function comp)))

    (check-equal #t (comparator-test-type real-comparator 3))
    (check-equal #t (comparator-test-type real-comparator 3.0))
    (check-equal #t (not (comparator-test-type real-comparator "3.0")))
    (check-equal #t (comparator-check-type boolean-comparator #t))
    (check-error (assertion-violation comparator-check-type)
            (comparator-check-type boolean-comparator 't))

    (check-equal #t (=? real-comparator 2 2.0 2))
    (check-equal #t (<? real-comparator 2 3.0 4))
    (check-equal #t (>? real-comparator 4.0 3.0 2))
    (check-equal #t (<=? real-comparator 2.0 2 3.0))
    (check-equal #t (>=? real-comparator 3 3.0 2))
    (check-equal #t (not (=? real-comparator 1 2 3)))
    (check-equal #t (not (<? real-comparator 3 1 2)))
    (check-equal #t (not (>? real-comparator 1 2 3)))
    (check-equal #t (not (<=? real-comparator 4 3 3)))
    (check-equal #t (not (>=? real-comparator 3 4 4.0)))

    (check-equal less (comparator-if<=> real-comparator 1 2 'less 'equal 'greater))
    (check-equal equal (comparator-if<=> real-comparator 1 1 'less 'equal 'greater))
    (check-equal greater (comparator-if<=> real-comparator 2 1 'less 'equal 'greater))
    (check-equal less (comparator-if<=> "1" "2" 'less 'equal 'greater))
    (check-equal equal (comparator-if<=> "1" "1" 'less 'equal 'greater))
    (check-equal greater (comparator-if<=> "2" "1" 'less 'equal 'greater))

    (check-equal #t (exact-integer? (hash-bound)))
    (check-equal #t (exact-integer? (hash-salt)))
    (check-equal #t (< (hash-salt) (hash-bound)))

;;
;; ---- SRFI 125: Hash Tables ----
;;

(import (foment base))
(import (scheme hash-table))
(import (scheme comparator))
(import (scheme list))

(define default (make-default-comparator))

(check-equal #t (hash-table? (make-eq-hash-table)))
(check-equal #f (hash-table? #(1 2 3 4)))
(check-equal #f (hash-table? '(1 2 3 4)))
(check-equal #t (hash-table? (make-hash-table default)))
(check-equal #t (hash-table? (make-hash-table string=? string-hash 2345)))
(check-equal #t (hash-table? (make-hash-table string-ci=?)))
(check-equal #t (hash-table? (make-hash-table string=? string-hash 2345 'weak-keys)))
(check-equal #t (hash-table? (make-hash-table string-ci=? 'thread-safe)))

(check-error (assertion-violation make-hash-table) (make-hash-table char=?))
(check-error (assertion-violation make-hash-table) (make-hash-table 1234))
(check-error (assertion-violation make-hash-table) (make-hash-table string=? 'bad-food))
(check-error (assertion-violation make-hash-table)
        (make-hash-table string=? string-hash 'weak-knees))
(check-error (assertion-violation make-hash-table)
        (make-hash-table string=? string-hash 'weak-keys 'ephemeral-keys))

(check-error (assertion-violation hash-table) (hash-table))
(check-error (assertion-violation make-hash-table) (hash-table char=?))

(check-equal #t (hash-table? (hash-table default)))

(define htbl (hash-table default 'a "a" 'b "b" 'c "c" 'd "d"))
(check-equal "a" (hash-table-ref/default htbl 'a #f))
(check-equal "b" (hash-table-ref/default htbl 'b #f))
(check-equal "c" (hash-table-ref/default htbl 'c #f))
(check-equal "d" (hash-table-ref/default htbl 'd #f))
(check-equal #f (hash-table-ref/default htbl 'e #f))

(check-error (assertion-violation hash-table-set!) (hash-table-set! htbl 'e "e"))
(check-equal #f (hash-table-ref/default htbl 'e #f))

(check-equal #t
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3 'd 4)
        (hash-table default 'a 1 'b 2 'c 3 'd 4)))
(check-equal #f
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3 'd 5)
        (hash-table default 'a 1 'b 2 'c 3 'd 4)))
(check-equal #f
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3)
        (hash-table default 'a 1 'b 2 'c 3 'd 4)))
(check-equal #f
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3 'd 4)
        (hash-table default 'a 1 'b 2 'c 3)))
(check-equal #f
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3 'e 4)
        (hash-table default 'a 1 'b 2 'c 3 'd 4)))

(check-error (assertion-violation hash-table-unfold) (hash-table-unfold))
(check-error (assertion-violation make-hash-table)
    (hash-table-unfold
        (lambda (seed) (> seed 8))
        (lambda (seed) (values (number->string seed) seed))
        (lambda (seed) (+ seed 1))
        1 char=?))

(check-equal #t
    (hash-table=? default
        (hash-table default "1" 1 "2" 2 "3" 3 "4" 4 "5" 5 "6" 6 "7" 7 "8" 8)
        (hash-table-unfold
            (lambda (seed) (> seed 8))
            (lambda (seed) (values (number->string seed) seed))
            (lambda (seed) (+ seed 1))
            1 default)))

(check-equal 8
    (hash-table-size
        (hash-table-unfold
            (lambda (seed) (> seed 8))
            (lambda (seed) (values (number->string seed) seed))
            (lambda (seed) (+ seed 1))
            1 default)))

(check-error (assertion-violation alist->hash-table) (alist->hash-table '()))
(check-error (assertion-violation make-hash-table) (alist->hash-table '() char=?))
(check-error (assertion-violation car) (alist->hash-table '(a) default))

(check-equal #t
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3 'd 4 'e 5)
        (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5)) default)))

(check-equal #t
    (hash-table=? default
        (hash-table default 'a 1 'b 2 'c 3)
        (alist->hash-table '((a . 1) (b . 2) (c . 3) (a . 4) (b . 5)) default)))

(check-error (assertion-violation hash-table-contains?)
    (hash-table-contains? htbl))
(check-error (assertion-violation hash-table-contains?)
    (hash-table-contains? htbl 123 456))
(check-equal #t (hash-table-contains? (hash-table default 'a 1) 'a))
(check-equal #f (hash-table-contains? (hash-table default 'a 1) 'b))

(check-equal #t (hash-table-empty? (hash-table default)))
(check-equal #f (hash-table-empty? (hash-table default 'a 1)))

(check-equal #t (hash-table-mutable? (make-hash-table default)))
(check-equal #f (hash-table-mutable? (hash-table default)))
(check-equal #t
    (hash-table-mutable?
        (hash-table-unfold
            (lambda (seed) (> seed 8))
            (lambda (seed) (values (number->string seed) seed))
            (lambda (seed) (+ seed 1))
            1 default)))
(check-equal #t (hash-table-mutable? (alist->hash-table '() default)))

(define htbl2 (hash-table default 'a 1 'b 2 'c 3 'd 4))

(check-error (assertion-violation hash-table-ref) (hash-table-ref))
(check-error (assertion-violation hash-table-ref) (hash-table-ref htbl2))
(check-error (assertion-violation hash-table-ref) (hash-table-ref htbl2 'e))
(check-equal 1 (hash-table-ref htbl2 'a))
(check-equal 10 (hash-table-ref htbl2 'e (lambda () 10)))
(check-equal 30 (hash-table-ref htbl2 'c (lambda () #f) (lambda (val) (* val 10))))

(check-error (assertion-violation hash-table-ref/default) (hash-table-ref/default htbl2))
(check-error (assertion-violation hash-table-ref/default) (hash-table-ref/default htbl2 'e))
(check-equal 1 (hash-table-ref/default htbl2 'a 10))
(check-equal 10 (hash-table-ref/default htbl2 'e 10))

(define (test-hash-table initial test expected)
    (let ((htbl (alist->hash-table initial default)))
        (test htbl)
        (hash-table=? default htbl (alist->hash-table expected default))))

(check-equal #t
    (test-hash-table
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5))
        (lambda (htbl)
            (hash-table-set! htbl 'a 10)
            (hash-table-set! htbl 'b 20 'c 30)
            (hash-table-set! htbl))
        '((a . 10) (b . 20) (c . 30) (d . 4) (e . 5))))
(check-error (assertion-violation hash-table-set!)
    (hash-table-set! (hash-table default 'a 1) 'a 10))

(check-equal #t
    (test-hash-table
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5))
        (lambda (htbl)
            (hash-table-delete! htbl 'a)
            (hash-table-delete! htbl 'b 'c)
            (hash-table-delete! htbl)
            (hash-table-delete! htbl 'f))
        '((d . 4) (e . 5))))
(check-error (assertion-violation hash-table-delete!)
    (hash-table-delete! (hash-table default 'a 1) 'a))

(check-equal #t
    (test-hash-table
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5))
        (lambda (htbl)
            (hash-table-intern! htbl 'a (lambda () 100))
            (hash-table-intern! htbl 'f (lambda () 6)))
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5) (f . 6))))
(check-error (assertion-violation hash-table-intern!)
    (hash-table-intern! (hash-table default 'a 1) 'b 2))

(check-equal #t
    (test-hash-table
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5))
        (lambda (htbl)
            (hash-table-update! htbl 'a (lambda (val) (* val 100)))
            (hash-table-update! htbl 'f (lambda (val) (- val)) (lambda () 6)))
        '((a . 100) (b . 2) (c . 3) (d . 4) (e . 5) (f . -6))))
(check-error (assertion-violation hash-table-set!)
    (hash-table-update! (hash-table default 'a 1) 'a (lambda (val) (* val 10))))

(check-equal #t
    (test-hash-table
        '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5))
        (lambda (htbl)
            (hash-table-update!/default htbl 'a (lambda (val) (* val 100)) -1)
            (hash-table-update!/default htbl 'f (lambda (val) (- val)) 6))
        '((a . 100) (b . 2) (c . 3) (d . 4) (e . 5) (f . -6))))
(check-error (assertion-violation hash-table-set!)
    (hash-table-update!/default (hash-table default 'a 1) 'a (lambda (val) (* val 10)) 6))

(check-equal #t
    (let* ((alist '((a . 1) (b . 2) (c . 3) (d . 4) (e . 5)))
            (htbl (alist->hash-table alist default)))
        (define (accum lst)
            (if (> (hash-table-size htbl) 0)
                (accum (cons (let-values (((key val) (hash-table-pop! htbl)))
                                 (cons key val)) lst))
                lst))
        (hash-table=? default (alist->hash-table (accum '()) default)
            (alist->hash-table alist default))))

(check-equal (a . 1)
    (let-values (((key val) (hash-table-pop! (alist->hash-table '((a . 1)) default))))
        (cons key val)))
(check-error (assertion-violation hash-table-pop!) (hash-table-pop! (hash-table default 'a 1)))
(check-error (assertion-violation %hash-table-pop!)
    (hash-table-pop! (alist->hash-table '() default)))

(check-equal 0
    (let ((htbl (alist->hash-table '((a . 1) (b . 2)) default)))
        (hash-table-clear! htbl)
        (hash-table-size htbl)))
(check-error (assertion-violation hash-table-clear!) (hash-table-clear! (hash-table default 'a 1)))

(check-equal 0 (hash-table-size (hash-table default)))
(check-equal 3 (hash-table-size (hash-table default 'a 1 'b 2 'c 3)))

(check-equal #t
    (lset= eq? '(a b c d)
        (hash-table-keys (hash-table default 'a 1 'b 2 'c 3 'd 4))))

(check-equal #t
    (lset= eq? '(1 2 3 4)
        (hash-table-values (hash-table default 'a 1 'b 2 'c 3 'd 4))))

(check-equal #t
    (lset= equal? '((a . 1) (b . 2) (c . 3) (d . 4))
        (let-values (((keys values) (hash-table-entries (hash-table default 'a 1 'b 2 'c 3 'd 4))))
            (map cons keys values))))

(check-equal 4
    (hash-table-find
        (lambda (key val) (if (eq? key 'd) val #f))
        (hash-table default 'a 1 'b 2 'c 3 'd 4)
        (lambda () 'not-found)))

(check-equal not-found
    (hash-table-find
        (lambda (key val) (if (eq? key 'e) val #f))
        (hash-table default 'a 1 'b 2 'c 3 'd 4)
        (lambda () 'not-found)))

(check-equal 3
    (hash-table-count (lambda (key val) (odd? val))
        (hash-table default 'a 1 'b 2 'c 3 'd 4 'e 5)))

(check-equal #t
    (hash-table=? default (hash-table default 'a 10 'b 20 'c 30 'd 40)
        (hash-table-map
            (lambda (val) (* val 10))
            default
            (hash-table default 'a 1 'b 2 'c 3 'd 4))))

(check-equal #t
    (lset= equal? '((a . 1) (b . 2) (c . 3) (d . 4))
        (let ((lst '()))
            (hash-table-for-each (lambda (key val) (set! lst (cons (cons key val) lst)))
                    (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default))
            lst)))

(check-error (assertion-violation hash-table-map!)
    (hash-table-map! (lambda (key val) (* val 10)) (hash-table default 'a 1 'b 2)))

(check-equal #t
    (hash-table=? default (alist->hash-table '((a . 1) (b . 4) (c . 9) (d . 16)) default)
        (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
            (hash-table-map! (lambda (key val) (* val val)) htbl)
            htbl)))

(check-equal #t
    (lset= equal? '((a . 1) (b . 2) (c . 3) (d . 4))
        (hash-table-map->list (lambda (key val) (cons key val))
            (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default))))

(check-equal #t
    (lset= equal? '((a . 1) (b . 2) (c . 3) (d . 4))
        (hash-table-fold (lambda (key val lst) (cons (cons key val) lst)) '()
            (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default))))

(check-equal #t
    (hash-table=? default (alist->hash-table '((a . 1) (c . 3)) default)
        (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
            (hash-table-prune! (lambda (key val) (even? val)) htbl)
            htbl)))

(check-equal #t
    (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
        (hash-table=? default htbl (hash-table-copy htbl))))

(check-equal #t
    (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
        (hash-table=? default htbl (hash-table-copy htbl #t))))

(check-equal #t
    (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
        (hash-table=? default htbl (hash-table-copy htbl #f))))

(check-error (assertion-violation hash-table-set!)
    (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
        (hash-table-set! (hash-table-copy htbl) 'a 10)))

(check-error (assertion-violation hash-table-set!)
    (let ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default)))
        (hash-table-set! (hash-table-copy htbl #f) 'a 10)))

(check-equal #f
    (let* ((htbl (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default))
            (copy (hash-table-copy htbl #t)))
        (hash-table-set! copy 'a 10)
        (hash-table=? default htbl copy)))

(check-equal #t
    (lset= equal? '((a . 1) (b . 2) (c . 3) (d . 4))
        (hash-table->alist (alist->hash-table '((a . 1) (b . 2) (c . 3) (d . 4)) default))))

(define (test-hash-set initial1 initial2 proc expected)
    (let ((htbl1 (alist->hash-table initial1 default))
            (htbl2 (alist->hash-table initial2 default)))
        (if (not (eq? htbl1 (proc htbl1 htbl2)))
            #f
            (lset= equal? expected (hash-table->alist htbl1)))))

(check-equal #t
    (test-hash-set
        '((a . 1) (b . 2) (c . 3))
        '((c . 4) (d . 5) (e . 6))
        hash-table-union!
        '((a . 1) (b . 2) (c . 3) (d . 5) (e . 6))))

(check-equal #t
    (test-hash-set
        '((a . 1) (b . 2) (c . 3))
        '((c . 4) (d . 5) (e . 6))
        hash-table-intersection!
        '((c . 3))))

(check-equal #t
    (test-hash-set
        '((a . 1) (b . 2) (c . 3))
        '((c . 4) (d . 5) (e . 6))
        hash-table-difference!
        '((a . 1) (b . 2))))

(check-equal #t
    (test-hash-set
        '((a . 1) (b . 2) (c . 3))
        '((c . 4) (d . 5) (e . 6))
        hash-table-xor!
        '((a . 1) (b . 2) (d . 5) (e . 6))))

(define (test-hash-table-add htbl size max make-key)
    (let ((vec (make-vector size #f)))
        (define (test-add n)
            (if (< n max)
                (let* ((idx (random-integer size))
                        (key (make-key idx)))
                    (if (not (vector-ref vec idx))
                        (begin
                            (vector-set! vec idx #t)
                            (hash-table-set! htbl key idx)))
                    (test-add (+ n 1)))))
        (test-add 0)
        vec))

(define (test-hash-table-ref htbl vec size make-key)
    (define (test-ref idx cnt)
        (if (< idx size)
            (begin
                (if (vector-ref vec idx)
                    (let ((key (make-key idx)))
                        (if (not (= (hash-table-ref/default htbl key 'fail) idx))
                            (begin
                                (display "failed: hash-table-ref/default: ")
                                (display idx)
                                (newline)
                                (test-ref (+ idx 1) cnt))
                            (test-ref (+ idx 1) (+ cnt 1))))
                    (test-ref (+ idx 1) cnt)))
            cnt))
    (test-ref 0 0))

(define (make-string-key idx)
    (number->string idx))

(define htbl (make-hash-table string=? string-hash))
(define vec (test-hash-table-add htbl 1024 512 make-string-key))
(check-equal #t (= (test-hash-table-ref htbl vec 1024 make-string-key) (hash-table-size htbl)))

;;
;; ---- SRFI 133: Vector Library (R7RS-compatible) ----
;;

(import (scheme vector))

(check-equal #(a b c d) (vector-concatenate '(#(a b) #(c d))))

(check-equal #f (vector-empty? '#(a)))
(check-equal #f (vector-empty? '#(())))
(check-equal #f (vector-empty? '#(#())))
(check-equal #t (vector-empty? '#()))

(check-equal #t (vector= eq? '#(a b c d) '#(a b c d)))
(check-equal #f (vector= eq? '#(a b c d) '#(a b d c)))
(check-equal #f (vector= = '#(1 2 3 4 5) '#(1 2 3 4)))
(check-equal #t (vector= = '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #t (vector= eq?))
(check-equal #t (vector= eq? '#(a)))
(check-equal #f (vector= eq? (vector (vector 'a)) (vector (vector 'a))))
(check-equal #t (vector= equal? (vector (vector 'a)) (vector (vector 'a))))
(check-equal #t
    (vector= = '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4 5) '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 2 3) '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4 5) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3)))
(check-equal #f
    (vector= = '#(9 2 3 4) '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 9 3 4) '#(1 2 3 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 2 3 4) '#(1 2 9 4) '#(1 2 3 4)))
(check-equal #f
    (vector= = '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 4) '#(1 2 3 9)))

(check-equal 6
    (vector-fold (lambda (len str) (max (string-length str) len)) 0
            '#("abc" "defghi" "jklmn" "pqrs")))
(check-equal (d c b a) (vector-fold (lambda (tail elt) (cons elt tail)) '() '#(a b c d)))
(check-equal 4
    (vector-fold (lambda (counter n) (if (even? n) (+ counter 1) counter)) 0
            '#(1 2 3 4 5 6 7 8)))

(check-equal (a b c d)
    (vector-fold-right (lambda (tail elt) (cons elt tail)) '() '#(a b c d)))

(check-equal #(1 4 9 16)
    (vector-map (lambda (x) (* x x)) (vector-unfold (lambda (i x) (values x (+ x 1))) 4 1)))
(check-equal #(5 8 9 8 5)
    (vector-map (lambda (x y) (* x y))
            (vector-unfold (lambda (i x) (values x (+ x 1))) 5 1)
            (vector-unfold (lambda (i x) (values x (- x 1))) 5 5)))
(check-equal #t
    (let* ((count 0)
           (ret (vector-map (lambda (ignored-elt) (set! count (+ count 1)) count) '#(a b))))
        (or (equal? ret #(1 2)) (equal? ret #(2 1)))))

(check-equal #(1 4 9 16)
    (vector-map (lambda (x) (* x x)) (vector-unfold (lambda (i x) (values x (+ x 1))) 4 1)))
(check-equal #(5 8 9 8 5)
    (vector-map (lambda (x y) (* x y))
            (vector-unfold (lambda (i x) (values x (+ x 1))) 5 1)
            (vector-unfold (lambda (i x) (values x (- x 1))) 5 5)))
(check-equal #t
    (let* ((count 0)
           (ret (vector-map (lambda (ignored-elt) (set! count (+ count 1)) count) '#(a b))))
        (or (equal? ret #(1 2)) (equal? ret #(2 1)))))

(check-equal #(1 4 9 16)
    (let ((vec (vector-unfold (lambda (i x) (values x (+ x 1))) 4 1)))
        (vector-map! (lambda (x) (* x x)) vec)
        vec))
(check-equal #(5 8 9 8 5)
    (let ((vec1 (vector-unfold (lambda (i x) (values x (+ x 1))) 5 1))
          (vec2 (vector-unfold (lambda (i x) (values x (- x 1))) 5 5)))
        (vector-map! (lambda (x y) (* x y)) vec1 vec2)
        vec1))
(check-equal #t
    (let* ((count 0)
           (ret (vector 'a 'b)))
        (vector-map! (lambda (ignored-elt) (set! count (+ count 1)) count) ret)
        (or (equal? ret #(1 2)) (equal? ret #(2 1)))))

(check-equal 3 (vector-count even? '#(3 1 4 1 5 9 2 5 6)))
(check-equal 2 (vector-count < '#(1 3 6 9) '#(2 4 6 8 10 12)))

(check-equal #(3 4 8 9 14 23 25 30 36) (vector-cumulate + 0 '#(3 1 4 1 5 9 2 5 6)))

(check-equal 2 (vector-index even? '#(3 1 4 1 5 9)))
(check-equal 1 (vector-index < '#(3 1 4 1 5 9 2 5 6) '#(2 7 1 8 2)))
(check-equal #f (vector-index = '#(3 1 4 1 5 9 2 5 6) '#(2 7 1 8 2)))

(check-equal 5 (vector-index-right odd? '#(3 1 4 1 5 9 6)))
(check-equal 3 (vector-index-right < '#(3 1 4 1 5) '#(2 7 1 8 2)))

(check-equal 2 (vector-skip number? '#(1 2 a b 3 4 c d)))
(check-equal 2 (vector-skip = '#(1 2 3 4 5) '#(1 2 -3 4)))

(check-equal 7 (vector-skip-right number? '#(1 2 a b 3 4 c d)))
(check-equal 3 (vector-skip-right = '#(1 2 3 4 5) '#(1 2 -3 -4 5)))

(check-equal (#f 0 1 2 3 4 5 6 7 #f)
    (let ((vec '#(1 2 3 4 5 6 7 8)))
        (map (lambda (val) (vector-binary-search vec val -)) '(0 1 2 3 4 5 6 7 8 9))))
(check-equal (#f 0 1 2 3 4 5 6 #f)
    (let ((vec '#(1 2 3 4 5 6 7)))
        (map (lambda (val) (vector-binary-search vec val -)) '(0 1 2 3 4 5 6 7 8))))

(check-equal #t (vector-any number? '#(1 2 x y z)))
(check-equal #t (vector-any < '#(1 2 3 4 5) '#(2 1 3 4 5)))
(check-equal #f (vector-any number? '#(a b c d e)))
(check-equal #f (vector-any > '#(1 2 3 4 5) '#(1 2 3 4 5)))
(check-equal yes (vector-any (lambda (x) (if (number? x) 'yes #f)) '#(1 2 x y z)))

(check-equal #f (vector-every number? '#(1 2 x y z)))
(check-equal #t (vector-every number? '#(1 2 3 4 5)))
(check-equal #f (vector-every < '#(1 2 3) '#(2 3 3)))
(check-equal #t (vector-every < '#(1 2 3) '#(2 3 4)))
(check-equal nope
    (vector-every (lambda (x) (if (= x 1) 'yeah 'nope)) '#(1 2 3 4 5)))

(check-equal #(2 1 3)
    (let ((v (vector 1 2 3)))
        (vector-swap! v 0 1)
        v))
(check-equal #(1 3 2)
    (let ((v (vector 1 2 3)))
        (vector-swap! v 2 1)
        v))

(check-equal #(4 3 2 1)
    (let ((v (vector 1 2 3 4)))
        (vector-reverse! v)
        v))
(check-equal #(5 4 3 2 1)
    (let ((v (vector 1 2 3 4 5)))
        (vector-reverse! v)
        v))
(check-equal #(1 4 3 2)
    (let ((v (vector 1 2 3 4)))
        (vector-reverse! v 1)
        v))
(check-equal #(1 5 4 3 2)
    (let ((v (vector 1 2 3 4 5)))
        (vector-reverse! v 1)
        v))
(check-equal #(1 3 2 4)
    (let ((v (vector 1 2 3 4)))
        (vector-reverse! v 1 3)
        v))
(check-equal #(1 4 3 2 5)
    (let ((v (vector 1 2 3 4 5)))
        (vector-reverse! v 1 4)
        v))

(check-equal (#(1 2 3 a b c d) 3)
    (call-with-values
        (lambda () (vector-partition number? '#(a 1 b 2 c 3 d)))
        (lambda (vec cnt) (list vec cnt))))
(check-equal (#(1 2 3 4 5) 5)
    (call-with-values
        (lambda () (vector-partition number? '#(1 2 3 4 5)))
        (lambda (vec cnt) (list vec cnt))))
(check-equal (#(a b c d) 0)
    (call-with-values
        (lambda () (vector-partition number? '#(a b c d)))
        (lambda (vec cnt) (list vec cnt))))

(check-equal #(0 -1 -2 -3 -4 -5 -6 -7 -8 -9)
    (vector-unfold (lambda (i x) (values x (- x 1))) 10 0))
(check-equal #(0 1 2 3 4 5) (vector-unfold values 6))
(check-equal #(0 3 4 9 8 15 12 21)
    (vector-unfold (lambda (i x y z) (values (if (even? x) y z) (+ x 1) (+ y 2) (+ z 3))) 8 0 0 0))

(check-equal #(0 0 3 4 9 8 15 12 21 0)
    (let ((vec (make-vector 10 0)))
        (vector-unfold!
            (lambda (i x y z) (values (if (even? x) y z) (+ x 1) (+ y 2) (+ z 3)))
            vec 1 9 0 0 0)
        vec))

(check-equal #((0 . 4) (1 . 3) (2 . 2) (3 . 1) (4 . 0))
    (vector-unfold-right (lambda (i x) (values (cons i x) (+ x 1))) 5 0))
(check-equal #(5 4 3 2 1 0)
    (let ((vec (vector 0 1 2 3 4 5)))
        (vector-unfold-right
            (lambda (i x) (values (vector-ref vec x) (+ x 1)))
            (vector-length vec)
            0)))

(check-equal #(1 2 3 4) (vector-reverse-copy '#(5 4 3 2 1 0) 1 5))
(check-equal #(10 5 4 3 2 60)
    (let ((vec (vector 10 20 30 40 50 60)))
        (vector-reverse-copy! vec 1 #(0 1 2 3 4 5 6 7 8) 2 6)
        vec))

(check-equal #(a b h i) (vector-append-subvectors '#(a b c d e) 0 2 '#(f g h i j) 2 4))
(check-equal #(b c d h i j q r)
    (vector-append-subvectors '#(a b c d e) 1 4 '#(f g h i j) 2 5 #(k l m n o p q r s t) 6 8))

(check-equal (3 2 1) (reverse-vector->list '#(1 2 3)))
(check-equal (3 2) (reverse-vector->list '#(1 2 3) 1))
(check-equal (2 1) (reverse-vector->list '#(1 2 3) 0 2))
(check-equal #(3 2 1) (reverse-list->vector '(1 2 3)))

;;
;; ---- SRFI 14: Character-set Library ----
;;

(import (scheme charset))

(check-equal #t (char-set? (char-set #\A)))
(check-equal #f (char-set? "abcd"))
(check-equal #f (char-set? #\A))

(check-equal #t (char-set=))
(check-equal #t (char-set= (char-set #\A)))
(check-equal #t (char-set= (char-set) (char-set)))
(check-equal #t (char-set= (char-set #\a #\Z) (char-set #\a #\Z)))
(check-equal #t (char-set= (char-set #\a #\z #\A #\Z) (char-set #\A #\z #\a #\Z)))
(check-equal #f (char-set= (char-set #\a #\^ #\Z) (char-set #\a #\Z)))
(check-equal #f (char-set= (char-set #\a #\Z) (char-set #\a #\^ #\Z)))
(check-equal #f (char-set= (char-set #\A #\Z) (char-set #\a #\Z)))
(check-equal #f (char-set= (char-set #\a #\Z) (char-set #\A #\Z)))
(check-equal #f (char-set= (char-set #\a #\z) (char-set #\a #\Z)))
(check-equal #f (char-set= (char-set #\a #\Z) (char-set #\a #\z)))
(check-equal #t (char-set= (char-set #\a #\b #\c #\d) (char-set #\a #\b #\c #\d)))
(check-equal #f (char-set= (char-set #\a #\b #\d) (char-set #\a #\b #\c #\d)))
(check-equal #t
    (char-set= (char-set #\a #\A #\B #\C #\D #\E #\Z) (char-set #\a #\A #\B #\C #\D #\E #\Z)))
(check-equal #t (char-set= (char-set #\a #\b #\c) (char-set #\a #\b #\c) (char-set #\a #\b #\c)))
(check-equal #f (char-set= (char-set #\a #\b #\c) (char-set #\a #\b #\c) (char-set #\a #\b)))

(check-equal #t (char-set<=))
(check-equal #t (char-set<= (char-set #\A)))
(check-equal #t (char-set<= (char-set) (char-set)))
(check-equal #t (char-set<= (char-set #\a #\Z) (char-set #\a #\Z)))
(check-equal #t (char-set<= (char-set #\a #\Z) (char-set #\a #\A #\B #\C #\Z)))
(check-equal #f (char-set<= (char-set #\a #\z #\Z) (char-set #\a #\A #\B #\C #\Z)))
(check-equal #t (char-set<= (char-set) (char-set #\a)))
(check-equal #t (char-set<= (char-set) (char-set #\a) (char-set #\a #\b) (char-set #\a #\b #\c)))
(check-equal #t
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\l #\m #\n #\x #\y #\z)))
(check-equal #t
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\k #\l #\m #\n #\x #\y #\z)))
(check-equal #t
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\k #\l #\m #\n #\o #\x #\y #\z)))

(check-equal #f
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\l #\m #\x #\y #\z)))
(check-equal #f
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\k #\l #\n #\x #\y #\z)))
(check-equal #f
    (char-set<=
        (char-set #\l #\m #\n)
        (char-set #\a #\b #\c #\k #\l #\m #\o #\x #\y #\z)))

(check-equal #t (>= (char-set-hash (char-set)) 0))
(check-equal #t (>= (char-set-hash (char-set #\a #\b #\c)) 0))
(check-equal #t
    (=
        (char-set-hash (char-set))
        (char-set-hash (char-set))))
(check-equal #t
    (=
        (char-set-hash (char-set #\a #\b #\c))
        (char-set-hash (char-set #\a #\b #\c))))
(check-equal #f
    (=
        (char-set-hash (char-set #\a #\b #\c))
        (char-set-hash (char-set #\x #\y #\z))))
(check-equal #f
    (=
        (char-set-hash (char-set #\a #\b #\c) 123)
        (char-set-hash (char-set #\a #\b #\c))))

(check-equal #t (end-of-char-set? (char-set-cursor (char-set))))
(check-equal #f (end-of-char-set? (char-set-cursor (char-set #\A))))
(check-equal #\A
    (let* ((cset (char-set #\A))
            (cursor (char-set-cursor cset)))
        (char-set-ref cset cursor)))
(check-equal (#\A #\B #\C #\Q #\X #\a #\d #\e #\x #\y #\z)
    (let ((cset (char-set #\Q #\d #\C #\a #\z #\X #\x #\y #\e #\B #\A)))
        (define (walk cursor)
            (if (end-of-char-set? cursor)
                '()
                (cons (char-set-ref cset cursor) (walk (char-set-cursor-next cset cursor)))))
        (walk (char-set-cursor cset))))

(check-equal (#\c #\b #\a)
    (char-set-fold cons '() (char-set #\a #\b #\c)))

(check-equal 5
    (char-set-fold (lambda (ch cnt) (+ cnt 1)) 0 (char-set #\1 #\2 #\3 #\4 #\5)))

(check-equal 3
    (char-set-fold
        (lambda (ch cnt) (if (char-numeric? ch) (+ cnt 1) cnt))
        0 (char-set #\a #\2 #\b #\4 #\c #\6 #\d)))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\y #\z)
        (char-set-unfold car null? cdr '(#\a #\b #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\y #\z)
        (char-set-unfold car null? cdr '(#\a #\b) (char-set #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\y #\z)
        (char-set-unfold! car null? cdr '(#\a #\b) (char-set #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C)
        (char-set-map char-upcase (char-set #\a #\b #\c))))

(check-equal (#\A #\B #\C #\D)
    (let ((lst '()))
        (char-set-for-each
            (lambda (ch) (set! lst (cons ch lst)))
            (char-set #\A #\B #\C #\D))
        lst))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C)
        (char-set-map char-upcase (char-set #\a #\b #\c))))

(check-equal #t
    (let ((cset (char-set #\a #\B #\c #\D)))
        (char-set= cset (char-set-copy cset))))

(check-equal #t
    (char-set=
        (list->char-set '(#\1 #\2 #\3 #\a #\b #\c))
        (string->char-set "abc123")))

(check-equal #t
    (char-set=
        (list->char-set '(#\1 #\2 #\3) (char-set #\a #\b #\c))
        (char-set #\1 #\2 #\3 #\a #\b #\c)))

(check-equal #t
    (char-set=
        (string->char-set "123" (char-set #\a #\b #\c))
        (char-set #\1 #\2 #\3 #\a #\b #\c)))

(check-equal #t
    (char-set=
        (list->char-set '(#\1 #\2 #\3 #\a #\b #\c) (char-set #\x #\y #\z))
        (char-set #\x #\y #\z #\1 #\2 #\3 #\a #\b #\c)))

(check-equal #t
    (char-set=
        (string->char-set "xyz123" (char-set #\a #\b #\c))
        (char-set #\x #\y #\z #\1 #\2 #\3 #\a #\b #\c)))

(check-equal #t
    (char-set=
        (char-set #\2 #\4 #\6)
        (char-set-filter char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d))))

(check-equal #t
    (char-set=
        (char-set #\2 #\4 #\6 #\x #\y #\z)
        (char-set-filter char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\2 #\4 #\6 #\x #\y #\z)
        (char-set-filter! char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (->char-set "abc")))

(check-equal #t
    (char-set=
        (char-set #\a)
        (->char-set #\a)))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (->char-set (char-set #\a #\b #\c))))

(check-equal 0 (char-set-size (char-set)))
(check-equal 5 (char-set-size (char-set #\a #\b #\c #\d #\e)))

(check-equal 3
    (char-set-count char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d)))

(check-equal (#\c #\b #\a)
    (char-set->list (char-set #\a #\b #\c)))

(check-equal "cba"
    (char-set->string (char-set #\a #\b #\c)))

(check-equal #t (char-set-contains? (char-set #\a #\b #\c) #\b))
(check-equal #f (char-set-contains? (char-set #\a #\b #\c) #\B))

(check-equal #f
    (char-set-every char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d)))

(check-equal #t
    (char-set-every char-numeric? (char-set #\2 #\4 #\6)))

(check-equal #t
    (char-set-any char-numeric? (char-set #\a #\2 #\b #\4 #\c #\6 #\d)))

(check-equal #\A
    (char-set-any (lambda (ch) (and (char-upper-case? ch) ch)) (char-set #\a #\b #\A)))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-adjoin (char-set #\x #\y #\z) #\a #\b #\c)))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-delete (char-set #\a #\b #\c #\x #\y #\z) #\a #\b #\c)))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-delete (char-set #\x #\y #\z) #\a #\b #\c)))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-union)))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-union (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-union
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-union
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\m #\n #\l #\c #\x #\y #\z)
        (char-set-union
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z)
            (char-set #\m #\n #\l))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (char-set-union
            (char-set #\a #\b #\c)
            char-set:empty)))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\m #\n #\l #\c #\x #\y #\z)
        (char-set-union
            char-set:empty
            (char-set #\a #\b #\c)
            char-set:empty
            (char-set #\x #\y #\z)
            char-set:empty
            (char-set #\m #\n #\l))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-union! (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-union!
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-union!
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\m #\n #\l #\c #\x #\y #\z)
        (char-set-union!
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z)
            (char-set #\m #\n #\l))))

(check-equal #t
    (char-set=
        char-set:full
        (char-set-intersection)))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-intersection
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection
            (char-set #\x #\y #\z)
            (char-set #\a #\b #\c #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection
            char-set:ascii
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection
            char-set:ascii
            (char-set #\A #\B #\C #\X #\Y #\Z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection
            (char-set #\A #\B #\C #\X #\Y #\Z)
            char-set:ascii)))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection
            char-set:ascii
            (char-set #\A #\B #\C)
            (char-set #\X #\Y #\Z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection! (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-intersection!
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection!
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection!
            (char-set #\x #\y #\z)
            (char-set #\a #\b #\c #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-intersection!
            char-set:ascii
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection!
            char-set:ascii
            (char-set #\A #\B #\C #\X #\Y #\Z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection!
            (char-set #\A #\B #\C #\X #\Y #\Z)
            char-set:ascii)))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\X #\Y #\Z)
        (char-set-intersection!
            char-set:ascii
            (char-set #\A #\B #\C)
            (char-set #\X #\Y #\Z))))

(check-equal #t
    (char-set=
        (char-set)
        (char-set-intersection
            (char-set #\a #\b #\c)
            (char-set #\d #\f #\g))))

(check-equal #t
    (char-set=
        (char-set)
        (char-set-intersection
            (char-set #\d #\f #\g)
            (char-set #\a #\b #\c))))

(check-equal #t
    (char-set=
        (char-set #\d #\e #\h #\i)
        (char-set-intersection
            (char-set #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j)
            (char-set #\d #\e #\h #\i))))

(check-equal #t
    (char-set=
        (char-set #\d #\e #\h #\i #\j)
        (char-set-intersection
            (char-set #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j)
            (char-set #\A #\B #\C #\d #\e #\h #\i #\j #\k #\l))))

(check-equal #t
    (char-set=
        (char-set #\d #\e #\h #\i)
        (char-set-intersection
            (char-set #\d #\e #\h #\i)
            (char-set #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j))))

(check-equal #t
    (char-set=
        (char-set #\d #\e #\h #\i #\j)
        (char-set-intersection
            (char-set #\A #\B #\C #\d #\e #\h #\i #\j #\k #\l)
            (char-set #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (char-set-difference
            (char-set #\a #\b #\c))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (char-set-difference
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-difference
            (char-set #\x #\y #\z)
            (char-set #\a #\b #\c))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (char-set-difference
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-difference
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\a #\b #\c))))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-difference
            (char-set #\x #\y #\z)
            (char-set #\a #\b #\c #\x #\y #\z))))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-difference
            (char-set #\a #\b #\c)
            (char-set #\a #\b #\c #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\l #\m #\n)
        (char-set-difference
            (char-set #\a #\b #\c #\l #\m #\n #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\l #\n)
        (char-set-difference
            (char-set #\a #\b #\c #\l #\m #\n #\x #\y #\z)
            (char-set #\m #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\A #\B #\C #\x #\y #\z)
        (char-set-difference
            (char-set #\A #\B #\C #\a #\b #\c #\x #\y #\z)
            (char-set #\a #\b #\c))))

(check-equal #t
    (char-set=
        char-set:empty
        (char-set-xor)))

(check-equal #t
    (char-set=
        (char-set #\x #\y #\z)
        (char-set-xor (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\x #\y #\z)
        (char-set-xor
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c)
        (char-set-xor
            (char-set #\a #\b #\c #\x #\y #\z)
            (char-set #\x #\y #\z))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\m #\n #\l #\c #\x #\y #\z)
        (char-set-xor
            (char-set #\a #\b #\c)
            (char-set #\x #\y #\z)
            (char-set #\m #\n #\l))))

(check-equal #t
    (char-set=
        (char-set #\a #\b #\c #\n #\l #\y #\z)
        (char-set-xor
            (char-set #\a #\b #\c #\m #\x)
            (char-set #\x #\y #\z)
            (char-set #\m #\n #\l))))

(check-equal 128 (char-set-size char-set:ascii))
(check-equal #t (char-set-contains? char-set:ascii #\a))
(check-equal #f (char-set-contains? char-set:ascii (integer->char 128)))

(check-equal 0 (char-set-size char-set:empty))
(check-equal #f (char-set-contains? char-set:empty #\a))

;; From Chibi Scheme

(check-equal #f (char-set? 5))

(check-equal #t (char-set? (char-set #\a #\e #\i #\o #\u)))

(check-equal #t (char-set=))
(check-equal #t (char-set= (char-set)))

(check-equal #t (char-set= (char-set #\a #\e #\i #\o #\u) (string->char-set "ioeauaiii")))

(check-equal #f (char-set= (char-set #\e #\i #\o #\u) (string->char-set "ioeauaiii")))

(check-equal #t (char-set<=))
(check-equal #t (char-set<= (char-set)))

(check-equal #t (char-set<= (char-set #\a #\e #\i #\o #\u) (string->char-set "ioeauaiii")))

(check-equal #t (char-set<= (char-set #\e #\i #\o #\u) (string->char-set "ioeauaiii")))

(check-equal #t (<= 0 (char-set-hash char-set:ascii 100) 99))

(check-equal 4 (char-set-fold (lambda (c i) (+ i 1)) 0 (char-set #\e #\i #\o #\u #\e #\e)))

(check-equal #t
    (char-set=
        (string->char-set "eiaou2468013579999")
        (char-set-unfold car null? cdr
            '(#\a #\e #\i #\o #\u #\u #\u)
            (char-set-intersection char-set:ascii
                (char-set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)))))

(check-equal #t
    (char-set=
        (string->char-set "eiaou246801357999")
        (char-set-unfold! car null? cdr '(#\a #\e #\i #\o #\u) (string->char-set "0123456789"))))

(check-equal #f
    (char-set=
        (string->char-set "eiaou246801357")
        (char-set-unfold! car null? cdr '(#\a #\e #\i #\o #\u) (string->char-set "0123456789"))))

(check-equal #t
    (char-set=
        (string->char-set "97531")
        (let ((cs (string->char-set "0123456789")))
            (char-set-for-each
                (lambda (c) (set! cs (char-set-delete cs c)))
                (string->char-set "02468000"))
            cs)))

(check-equal #f
    (let ((cs (string->char-set "0123456789")))
        (char-set-for-each
            (lambda (c) (set! cs (char-set-delete cs c)))
            (string->char-set "02468"))
        (char-set= cs (string->char-set "7531"))))

(check-equal #t
    (char-set=
        (string->char-set "IOUAEEEE")
        (char-set-map char-upcase (string->char-set "aeiou"))))

(check-equal #f
    (char-set=
        (char-set-map char-upcase (string->char-set "aeiou"))
        (string->char-set "OUAEEEE")))

(check-equal #t
    (char-set=
        (string->char-set "aeiou")
        (char-set-copy (string->char-set "aeiou"))))

(check-equal #t
    (char-set=
        (string->char-set "xy")
        (char-set #\x #\y)))

(check-equal #f (char-set= (char-set #\x #\y #\z) (string->char-set "xy")))

(check-equal #t
    (char-set=
        (string->char-set "xy")
        (list->char-set '(#\x #\y))))

(check-equal #f (char-set= (string->char-set "axy") (list->char-set '(#\x #\y))))

(check-equal #t
    (char-set=
        (string->char-set "xy12345")
        (list->char-set '(#\x #\y) (string->char-set "12345"))))

(check-equal #f
    (char-set=
        (string->char-set "y12345")
        (list->char-set '(#\x #\y) (string->char-set "12345"))))

(check-equal #t
    (char-set=
        (string->char-set "xy12345")
        (list->char-set! '(#\x #\y) (string->char-set "12345"))))

(check-equal #f
    (char-set=
        (string->char-set "y12345")
        (list->char-set! '(#\x #\y) (string->char-set "12345"))))

(define (vowel? ch)
    (member ch '(#\a #\e #\i #\o #\u)))

(check-equal #t
    (char-set=
        (string->char-set "aeiou12345")
        (char-set-filter vowel? char-set:ascii (string->char-set "12345"))))

(check-equal #f
    (char-set=
        (string->char-set "aeou12345")
        (char-set-filter vowel? char-set:ascii (string->char-set "12345"))))

(check-equal #t
    (char-set=
        (string->char-set "aeiou12345")
        (char-set-filter! vowel? char-set:ascii (string->char-set "12345"))))

(check-equal #f
    (char-set=
        (string->char-set "aeou12345")
        (char-set-filter! vowel? char-set:ascii (string->char-set "12345"))))

(check-equal #t
    (char-set=
        (string->char-set "abcdef12345")
        (ucs-range->char-set 97 103 #t (string->char-set "12345"))))
(check-equal #f
    (char-set=
        (string->char-set "abcef12345")
        (ucs-range->char-set 97 103 #t (string->char-set "12345"))))

(check-equal #t
    (char-set=
            (string->char-set "abcdef12345")
            (ucs-range->char-set! 97 103 #t (string->char-set "12345"))))
(check-equal #f
    (char-set=
        (string->char-set "abcef12345")
        (ucs-range->char-set! 97 103 #t (string->char-set "12345"))))

(check-equal #t
    (char-set= (->char-set #\x) (->char-set "x") (->char-set (char-set #\x))))

(check-equal #f
    (char-set= (->char-set #\x) (->char-set "y") (->char-set (char-set #\x))))

(check-equal 10
    (char-set-size (char-set-intersection char-set:ascii (string->char-set "0123456789"))))

(check-equal 5 (char-set-count vowel? char-set:ascii))

(check-equal (#\x) (char-set->list (char-set #\x)))
(check-equal #f (equal? '(#\X) (char-set->list (char-set #\x))))

(check-equal "x" (char-set->string (char-set #\x)))
(check-equal #f (equal? "X" (char-set->string (char-set #\x))))

(check-equal #t (char-set-contains? (->char-set "xyz") #\x))
(check-equal #f (char-set-contains? (->char-set "xyz") #\a))

(check-equal #t (char-set-every char-lower-case? (->char-set "abcd")))
(check-equal #f (char-set-every char-lower-case? (->char-set "abcD")))
(check-equal #t (char-set-any char-lower-case? (->char-set "abcd")))
(check-equal #f (char-set-any char-lower-case? (->char-set "ABCD")))

(check-equal #t
    (char-set=
        (->char-set "ABCD")
        (let ((cs (->char-set "abcd")))
            (let lp ((cur (char-set-cursor cs)) (ans '()))
                (if (end-of-char-set? cur) (list->char-set ans)
                    (lp (char-set-cursor-next cs cur)
                        (cons (char-upcase (char-set-ref cs cur)) ans)))))))

(check-equal #t
    (char-set=
        (->char-set "123xa")
        (char-set-adjoin (->char-set "123") #\x #\a)))
(check-equal #f (char-set= (char-set-adjoin (->char-set "123") #\x #\a) (->char-set "123x")))
(check-equal #t
    (char-set=
        (->char-set "123xa")
        (char-set-adjoin! (->char-set "123") #\x #\a)))
(check-equal #f (char-set= (char-set-adjoin! (->char-set "123") #\x #\a) (->char-set "123x")))

(check-equal #t
    (char-set=
        (->char-set "13")
        (char-set-delete (->char-set "123") #\2 #\a #\2)))
(check-equal #f (char-set= (char-set-delete (->char-set "123") #\2 #\a #\2) (->char-set "13a")))
(check-equal #t
    (char-set=
        (->char-set "13")
        (char-set-delete! (->char-set "123") #\2 #\a #\2)))
(check-equal #f (char-set= (char-set-delete! (->char-set "123") #\2 #\a #\2) (->char-set "13a")))

(define digit (char-set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9))
(define hex-digit
    (char-set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\a #\b #\c #\d #\e #\f
        #\A #\B #\C #\D #\E #\F))

(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEF")
        (char-set-intersection hex-digit (char-set-complement digit))))
(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEF")
        (char-set-intersection! (char-set-complement! (->char-set "0123456789")) hex-digit)))

(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEFghijkl0123456789")
        (char-set-union hex-digit (->char-set "abcdefghijkl"))))
(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEFghijkl0123456789")
        (char-set-union! (->char-set "abcdefghijkl") hex-digit)))

(check-equal #t
    (char-set=
        (->char-set "ghijklmn")
        (char-set-difference (->char-set "abcdefghijklmn") hex-digit)))
(check-equal #t
    (char-set=
        (->char-set "ghijklmn")
        (char-set-difference! (->char-set "abcdefghijklmn") hex-digit)))

(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEF")
        (char-set-xor (->char-set "0123456789") hex-digit)))
(check-equal #t
    (char-set=
        (->char-set "abcdefABCDEF")
        (char-set-xor! (->char-set "0123456789") hex-digit)))

(define letter (string->char-set "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))

(check-equal (#t . #t)
    (call-with-values
        (lambda ()
            (char-set-diff+intersection hex-digit letter))
        (lambda (d i)
            (cons
                (char-set= d (->char-set "0123456789"))
                (char-set= i (->char-set "abcdefABCDEF"))))))

(check-equal (#t . #t)
    (call-with-values
        (lambda ()
            (char-set-diff+intersection! (char-set-copy hex-digit) (char-set-copy letter)))
        (lambda (d i)
            (cons
                (char-set= d (->char-set "0123456789"))
                (char-set= i (->char-set "abcdefABCDEF"))))))

;;
;; ---- SRFI 151: Bitwise Operations
;;

(import (srfi 151))

(check-equal -11 (bitwise-not 10))
(check-equal 36 (bitwise-not -37))
(check-equal -1 (bitwise-eqv))
(check-equal 123 (bitwise-eqv 123))
(check-equal -123 (bitwise-eqv -123))
(check-equal 11 (bitwise-ior 3 10))
(check-equal 10 (bitwise-and 11 26))
(check-equal 9 (bitwise-xor 3 10))
(check-equal -42 (bitwise-eqv 37 12))
(check-equal 4 (bitwise-and 37 12))
(check-equal -11 (bitwise-nand 11 26))
(check-equal -28 (bitwise-nor 11 26))
(check-equal 16 (bitwise-andc1 11 26))
(check-equal 1 (bitwise-andc2 11 26))
(check-equal -2 (bitwise-orc1 11 26))
(check-equal -17 (bitwise-orc2 11 26))

(check-equal 32 (arithmetic-shift 8 2))
(check-equal 4 (arithmetic-shift 4 0))
(check-equal 4 (arithmetic-shift 8 -1))
(check-equal -79 (arithmetic-shift -100000000000000000000000000000000 -100))

(check-equal 0 (bit-count 0))
(check-equal 0 (bit-count -1))
(check-equal 3 (bit-count 7))
(check-equal 3 (bit-count 13))
(check-equal 2 (bit-count -13))
(check-equal 4 (bit-count 30))
(check-equal 4 (bit-count -30))
(check-equal 1 (bit-count (expt 2 100)))
(check-equal 100 (bit-count (- (expt 2 100))))
(check-equal 1 (bit-count (- (+ (expt 2 100) 1))))

(check-equal 0 (integer-length 0))
(check-equal 1 (integer-length 1))
(check-equal 0 (integer-length -1))
(check-equal 3 (integer-length 7))
(check-equal 3 (integer-length -7))
(check-equal 4 (integer-length 8))
(check-equal 3 (integer-length -8))

(check-equal 9 (bitwise-if 3 1 8))
(check-equal 0 (bitwise-if 3 8 1))
(check-equal 3 (bitwise-if 1 1 2))
(check-equal #b00110011 (bitwise-if #b00111100 #b11110000 #b00001111))

(check-equal #f (bit-set? 1 1))
(check-equal #t (bit-set? 0 1))
(check-equal #t (bit-set? 3 10))
(check-equal #t (bit-set? 1000000 -1))
(check-equal #t (bit-set? 2 6))
(check-equal #f (bit-set? 0 6))

(check-equal #b1 (copy-bit 0 0 #t))
(check-equal #b100 (copy-bit 2 0 #t))
(check-equal #b1011 (copy-bit 2 #b1111 #f))

(check-equal #b1 (bit-swap 0 2 4))

(check-equal #t (any-bit-set? 3 6))
(check-equal #f (any-bit-set? 3 12))
(check-equal #t (every-bit-set? 4 6))
(check-equal #f (every-bit-set? 7 6))

(check-equal 0 (first-set-bit 1))
(check-equal 1 (first-set-bit 2))
(check-equal -1 (first-set-bit 0))
(check-equal 3 (first-set-bit 40))
(check-equal 2 (first-set-bit -28))
(check-equal 99 (first-set-bit (expt  2 99)))
(check-equal 99 (first-set-bit (expt -2 99)))

(check-equal #b1010 (bit-field #b1101101010 0 4))
(check-equal #b101101 (bit-field #b1101101010 3 9))
(check-equal #b10110 (bit-field #b1101101010 4 9))
(check-equal #b110110 (bit-field #b1101101010 4 10))
(check-equal 0 (bit-field 6 0 1))
(check-equal 3 (bit-field 6 1 3))
(check-equal 1 (bit-field 6 2 999))
(check-equal 1 (bit-field #x100000000000000000000000000000000 128 129))

(check-equal #t (bit-field-any? #b1001001 1 6))
(check-equal #f (bit-field-any? #b1000001 1 6))

(check-equal #t (bit-field-every? #b1011110 1 5))
(check-equal #f (bit-field-every? #b1011010 1 5))

(check-equal #b100000 (bit-field-clear #b101010 1 4))
(check-equal #b101110 (bit-field-set #b101010 1 4))

(check-equal #b100100 (bit-field-replace #b101010 #b010 1 4))
(check-equal #b111 (bit-field-replace #b110 1 0 1))
(check-equal #b110 (bit-field-replace #b110 1 1 2))

(check-equal #b1001 (bit-field-replace-same #b1111 #b0000 1 3))

(check-equal #b110 (bit-field-rotate #b110 0 0 10))
(check-equal #b110 (bit-field-rotate #b110 0 0 256))
(check-equal 1 (bit-field-rotate #x100000000000000000000000000000000 1 0 129))
(check-equal #b110 (bit-field-rotate #b110 1 1 2))
(check-equal #b1010 (bit-field-rotate #b110 1 2 4))
(check-equal #b1011 (bit-field-rotate #b0111 -1 1 4))

(check-equal 6 (bit-field-reverse 6 1 3))
(check-equal 12 (bit-field-reverse 6 1 4))
(check-equal #x80000000 (bit-field-reverse 1 0 32))
(check-equal #x40000000 (bit-field-reverse 1 0 31))
(check-equal #x20000000 (bit-field-reverse 1 0 30))
(check-equal 5 (bit-field-reverse #x140000000000000000000000000000000 0 129))

(check-equal (#t #f #t #f #t #t #t) (bits->list #b1110101))
(check-equal (#t #t #f #f #f) (bits->list 3 5))
(check-equal (#f #t #t #f) (bits->list 6 4))

(check-equal #(#t #f #t #f #t #t #t) (bits->vector #b1110101))

(check-equal #b1110101 (list->bits '(#t #f #t #f #t #t #t)))
(check-equal #b111010100 (list->bits '(#f #f #t #f #t #f #t #t #t)))
(check-equal 6 (list->bits '(#f #t #t)))
(check-equal 6 (list->bits '(#f #t #t #f)))
(check-equal 12 (list->bits '(#f #f #t #t)))

(check-equal #b1110101 (vector->bits '#(#t #f #t #f #t #t #t)))
(check-equal #b111010100 (vector->bits '#(#f #f #t #f #t #f #t #t #t)))
(check-equal 6 (vector->bits '#(#f #t #t)))
(check-equal 6 (vector->bits '#(#f #t #t #f)))
(check-equal 12 (vector->bits '#(#f #f #t #t)))

(check-equal #b1110101 (bits #t #f #t #f #t #t #t))
(check-equal #b111010100 (bits #f #f #t #f #t #f #t #t #t))

(check-equal (#t #f #t #f #t #t #t) (bitwise-fold cons '() #b1010111))

(define (bitcount n)
    (let ((count 0))
        (bitwise-for-each (lambda (b) (if b (set! count (+ count 1)))) n)
        count))

(check-equal 0 (bitcount 0))
(check-equal 3 (bitcount 7))
(check-equal 3 (bitcount 13))
(check-equal 4 (bitcount 30))
(check-equal 1 (bitcount (expt 2 100)))

(check-equal #b101010101
    (bitwise-unfold
        (lambda (i) (= i 10))
        even?
        (lambda (i) (+ i 1))
        0))

(define g (make-bitwise-generator #b110))

(check-equal #f (g))
(check-equal #t (g))
(check-equal #t (g))
(check-equal #f (g))
(check-equal #f (g))
(check-equal #f (g))

;;
;; ---- SRFI 166: Monadic Formatting ----
;;

(import (srfi 166))

; Parts from Chibi Scheme and https://gitlab.com/nieper/show

(check-equal "" (show #f ""))
(check-equal "\n" (show #f "\n"))
(check-equal "\n\n" (show #f "\n\n"))

(check-equal "hi" (show #f "hi"))
(check-equal "\"hi\"" (show #f (written "hi")))
(check-equal "\"hi \\\"bob\\\"\"" (show #f (written "hi \"bob\"")))
(check-equal "\"hello\\nworld\"" (show #f (written "hello\nworld")))
(check-equal "#(1 2 3)" (show #f (written '#(1 2 3))))
(check-equal "#(1)" (show #f (written '#(1))))
(check-equal "#()" (show #f (written '#())))
(check-equal "(1 2 3)" (show #f (written '(1 2 3))))
(check-equal "(1 2 . 3)" (show #f (written '(1 2 . 3))))
(check-equal "(1)" (show #f (written '(1))))
(check-equal "()" (show #f (written '())))
(check-equal "ABC" (show #f (upcased "abc")))
(check-equal "ABCDEF" (show #f (upcased "abc" "def")))
(check-equal "abcABCDEFghi"
    (show #f (downcased "ABC") (upcased "abc" "def") (downcased "GHI")))

(check-equal "a    b" (show #f "a" (space-to 5) "b"))
(check-equal "ab" (show #f "a" (space-to 0) "b"))

(check-equal "abc     def" (show #f "abc" (tab-to) "def"))
(check-equal "abc  def" (show #f "abc" (tab-to 5) "def"))
(check-equal "abcdef" (show #f "abc" (tab-to 3) "def"))
(check-equal "abc\ndef\n" (show #f "abc" nl "def" nl))
(check-equal "abc\ndef\n" (show #f "abc" fl "def" nl fl))
(check-equal "abc\ndef\n" (show #f "abc" fl "def" fl fl))

(check-equal "ab" (show #f "a" nothing "b"))

(define ls '("abc" "def" "ghi"))
(check-equal "abcdefghi"
    (show #f
        (let lp ((ls ls))
            (if (pair? ls)
                (each (car ls) (lp (cdr ls)))
                nothing))))
(check-equal "abcdefghi"
    (show #f
        (let lp ((ls ls))
            (if (pair? ls)
                (each (car ls) (fn () (lp (cdr ls))))
                nothing))))

(check-equal "" (show #f nothing))
(check-equal "" (show #f nothing nothing ""  nothing))
(check-equal "" (show #f (each nothing "" (with ((radix 16)) nothing))))
(check-equal "abcdefg" (show #f (with ((radix 16)) "abc" "defg")))

(check-equal "port? #t" (show #f "port? " (fn (port) (port? port))))
(check-equal "port? #t ****" (show #f "port? " (fn ((p port)) (port? p)) " ****"))

(check-equal "column: 8" (show #f "column: " (fn (col) col)))
(check-equal "column: 8, 11"
    (show #f "column: " (fn ((col1 col)) (each col1 ", " (fn ((col2 col)) col2)))))

(check-equal "hi, bob!" (show #f (escaped "hi, bob!")))
(check-equal "hi, \\\"bob!\\\"" (show #f (escaped "hi, \"bob!\"")))
(check-equal "hi, \\'bob\\'" (show #f (escaped "hi, 'bob'" #\')))
(check-equal "hi, ''bob''" (show #f (escaped "hi, 'bob'" #\' #\')))
(check-equal "hi, ''bob''" (show #f (escaped "hi, 'bob'" #\' #f)))
(check-equal "line1\\nline2\\nkapow\\a\\n"
    (show #f (escaped "line1\nline2\nkapow\a\n" #\" #\\
            (lambda (c) (case c ((#\newline) #\n) ((#\alarm) #\a) (else #f))))))

(check-equal "bob" (show #f (maybe-escaped "bob" char-whitespace?)))
(check-equal "\"hi, bob!\""
    (show #f (maybe-escaped "hi, bob!" char-whitespace?)))
(check-equal "\"foo\\\"bar\\\"baz\"" (show #f (maybe-escaped "foo\"bar\"baz" char-whitespace?)))
(check-equal "'hi, ''bob'''" (show #f (maybe-escaped "hi, 'bob'" (lambda (c) #f) #\' #f)))
(check-equal "\\" (show #f (maybe-escaped "\\" (lambda (c) #f) #\' #f)))
(check-equal "''''" (show #f (maybe-escaped "'" (lambda (c) #f) #\' #f)))

(check-equal "-1" (show #f -1))
(check-equal "0" (show #f 0))
(check-equal "1" (show #f 1))
(check-equal "10" (show #f 10))
(check-equal "100" (show #f 100))
(check-equal "-1" (show #f (numeric -1)))
(check-equal "0" (show #f (numeric 0)))
(check-equal "1" (show #f (numeric 1)))
(check-equal "10" (show #f (numeric 10)))
(check-equal "100" (show #f (numeric 100)))
(check-equal "57005" (show #f #xDEAD))

;; radix
(check-equal "#xdead" (show #f (with ((radix 16)) #xDEAD)))
(check-equal "#xdead1234" (show #f (with ((radix 16)) #xDEAD) 1234))
(check-equal "de.ad"
    (show #f (with ((radix 16) (precision 2)) (numeric (/ #xDEAD #x100)))))
(check-equal "d.ead"
    (show #f (with ((radix 16) (precision 3)) (numeric (/ #xDEAD #x1000)))))
(check-equal "0.dead"
    (show #f (with ((radix 16) (precision 4)) (numeric (/ #xDEAD #x10000)))))
(check-equal "1g"
    (show #f (with ((radix 17)) (numeric 33))))

(check-equal "(#x11 #x22 #x33)" (show #f (with ((radix 16)) '(#x11 #x22 #x33))))
(check-equal "0" (show #f (numeric 0 2)))
(check-equal "0" (show #f (numeric 0 10)))
(check-equal "0" (show #f (numeric 0 36)))

(check-equal "0.0" (show #f (numeric 0.0 2)))
(check-equal "0.0" (show #f (numeric 0.0 10)))
(check-equal "0.0" (show #f (numeric 0.0 36)))

(check-equal "1" (show #f (numeric 1 2)))
(check-equal "1" (show #f (numeric 1 10)))
(check-equal "1" (show #f (numeric 1 36)))

(check-equal "1.0" (show #f (numeric 1.0 2)))
(check-equal "1.0" (show #f (numeric 1.0 10)))
(check-equal "1.0" (show #f (numeric 1.0 36)))

(check-equal "0" (show #f (numeric 0.0 10 0)))
(check-equal "0" (show #f (numeric 0.0 9 0)))
(check-equal "3/4" (show #f (numeric #e.75)))

(check-equal "0.0000000000000027" (show #f (numeric 1e-23 36)))
(check-equal "100000000000000000000000000000000000000000000000000000000000000000000000000000000.0"
      (show #f (numeric (expt 2.0 80) 2)))

;; numeric, radix=2
(check-equal "10" (show #f (numeric 2 2)))
(check-equal "10.0" (show #f (numeric 2.0 2)))
(check-equal "11/10" (show #f (numeric 3/2 2)))
(check-equal "1001" (show #f (numeric 9 2)))
(check-equal "1001.0" (show #f (numeric 9.0 2)))
(check-equal "1001.01" (show #f (numeric 9.25 2)))

;; numeric, radix=3
(check-equal "11" (show #f (numeric 4 3)))
(check-equal "10.0" (show #f (numeric 3.0 3)))
(check-equal "11/10" (show #f (numeric 4/3 3)))
(check-equal "1001" (show #f (numeric 28 3)))
(check-equal "1001.0" (show #f (numeric 28.0 3)))
(check-equal "1001.01" (show #f (numeric #i253/9 3 2)))

;; radix 36
(check-equal "zzz" (show #f (numeric (- (* 36 36 36) 1) 36)))

;; precision
;(check-equal "3.14159" (show #f 3.14159))
(check-equal "3.14" (show #f (with ((precision 2)) 3.14159)))
(check-equal "3.14" (show #f (with ((precision 2)) 3.14)))
(check-equal "3.00" (show #f (with ((precision 2)) 3.)))
(check-equal "1.10" (show #f (with ((precision 2)) 1.099)))
(check-equal "0.00" (show #f (with ((precision 2)) 1e-17)))
(check-equal "0.0000000010" (show #f (with ((precision 10)) 1e-9)))
(check-equal "0.0000000000" (show #f (with ((precision 10)) 1e-17)))
(check-equal "0.000004" (show #f (with ((precision 6)) 0.000004)))
(check-equal "0.0000040" (show #f (with ((precision 7)) 0.000004)))
(check-equal "0.00000400" (show #f (with ((precision 8)) 0.000004)))
(check-equal "1.00" (show #f (with ((precision 2)) .997554209949891)))
(check-equal "1.00" (show #f (with ((precision 2)) .99755420)))
(check-equal "1.00" (show #f (with ((precision 2)) .99755)))
(check-equal "1.00" (show #f (with ((precision 2)) .997)))
(check-equal "0.99" (show #f (with ((precision 2)) .99)))
(check-equal "-15" (show #f (with ((precision 0)) -14.99995999999362)))

(check-equal "+inf.0" (show #f +inf.0))
(check-equal "-inf.0" (show #f -inf.0))
(check-equal "+nan.0" (show #f +nan.0))
(check-equal "+inf.0" (show #f (numeric +inf.0)))
(check-equal "-inf.0" (show #f (numeric -inf.0)))
(check-equal "+nan.0" (show #f (numeric +nan.0)))

(check-equal "333.333333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 1000/3))))
(check-equal  "33.333333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 100/3))))
(check-equal   "3.333333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 10/3))))
(check-equal   "0.333333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 1/3))))
(check-equal   "0.033333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 1/30))))
(check-equal   "0.003333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 1/300))))
(check-equal   "0.000333333333333333333333333333"
    (show #f (with ((precision 30)) (numeric 1/3000))))
(check-equal   "0.666666666666666666666666666667"
    (show #f (with ((precision 30)) (numeric 2/3))))
(check-equal   "0.090909090909090909090909090909"
    (show #f (with ((precision 30)) (numeric 1/11))))
(check-equal   "1.428571428571428571428571428571"
    (show #f (with ((precision 30)) (numeric 10/7))))
(check-equal "0.123456789012345678901234567890"
    (show #f (with ((precision 30))
               (numeric (/  123456789012345678901234567890
                            1000000000000000000000000000000)))))

(check-equal  " 333.333333333333333333333333333333"
    (show #f (with ((precision 30) (decimal-align 5)) (numeric 1000/3))))
(check-equal  "  33.333333333333333333333333333333"
    (show #f (with ((precision 30) (decimal-align 5)) (numeric 100/3))))
(check-equal  "   3.333333333333333333333333333333"
    (show #f (with ((precision 30) (decimal-align 5)) (numeric 10/3))))
(check-equal  "   0.333333333333333333333333333333"
    (show #f (with ((precision 30) (decimal-align 5)) (numeric 1/3))))

(check-equal "   3.14159"
    (show #f (with ((decimal-align 5) (precision 5)) (numeric 3.14159))))
(check-equal "  31.4159"
    (show #f (with ((decimal-align 5) (precision 4)) (numeric 31.4159))))
(check-equal " 314.159"
    (show #f (with ((decimal-align 5) (precision 3)) (numeric 314.159))))
(check-equal "3141.59"
    (show #f (with ((decimal-align 5) (precision 2)) (numeric 3141.59))))
(check-equal "31415.9"
    (show #f (with ((decimal-align 5) (precision 1)) (numeric 31415.9))))
(check-equal "  -3.14159"
    (show #f (with ((decimal-align 5) (precision 5)) (numeric -3.14159))))
(check-equal " -31.4159"
             (show #f (with ((decimal-align 5) (precision 4)) (numeric -31.4159))))
(check-equal "-314.159"
    (show #f (with ((decimal-align 5) (precision 3)) (numeric -314.159))))
(check-equal "-3141.59"
    (show #f (with ((decimal-align 5) (precision 2)) (numeric -3141.59))))
(check-equal "-31415.9"
    (show #f (with ((decimal-align 5) (precision 1)) (numeric -31415.9))))

(check-equal "11.75" (show #f (with ((precision 2)) (/ 47 4))))
(check-equal "-11.75" (show #f (with ((precision 2)) (/ -47 4))))

;; Precision:
(check-equal "1.1250" (show #f (numeric 9/8 10 4)))
(check-equal "1.125" (show #f (numeric 9/8 10 3)))
(check-equal "1.12" (show #f (numeric 9/8 10 2)))
(check-equal "1.1" (show #f (numeric 9/8 10 1)))
(check-equal "1" (show #f (numeric 9/8 10 0)))

(check-equal "1.1250" (show #f (numeric #i9/8 10 4)))
(check-equal "1.125" (show #f (numeric #i9/8 10 3)))
;(check-equal "1.12" (show #f (numeric #i9/8 10 2)))
(check-equal "1.1" (show #f (numeric #i9/8 10 1)))
(check-equal "1" (show #f (numeric #i9/8 10 0)))

;; precision-show, base-4
(check-equal "1.1230" (show #f (numeric 91/64 4 4)))
(check-equal "1.123" (show #f (numeric 91/64 4 3)))
(check-equal "1.13" (show #f (numeric 91/64 4 2)))
(check-equal "1.2" (show #f (numeric 91/64 4 1)))
(check-equal "1" (show #f (numeric 91/64 4 0)))

(check-equal "1.1230" (show #f (numeric #i91/64 4 4)))
(check-equal "1.123" (show #f (numeric #i91/64 4 3)))
(check-equal "1.13" (show #f (numeric #i91/64 4 2)))
(check-equal "1.2" (show #f (numeric #i91/64 4 1)))
(check-equal "1" (show #f (numeric #i91/64 4 0)))

(check-equal "1.0010" (show #f (numeric 1001/1000 10 4)))
(check-equal "1.001" (show #f (numeric 1001/1000 10 3)))
(check-equal "1.00" (show #f (numeric 1001/1000 10 2)))
(check-equal "1.0" (show #f (numeric 1001/1000 10 1)))
(check-equal "1" (show #f (numeric 1001/1000 10 0)))

(check-equal "1.0190" (show #f (numeric 1019/1000 10 4)))
(check-equal "1.019" (show #f (numeric 1019/1000 10 3)))
(check-equal "1.02" (show #f (numeric 1019/1000 10 2)))
(check-equal "1.0" (show #f (numeric 1019/1000 10 1)))
(check-equal "1" (show #f (numeric 1019/1000 10 0)))

(check-equal "1.9990" (show #f (numeric 1999/1000 10 4)))
(check-equal "1.999" (show #f (numeric 1999/1000 10 3)))
(check-equal "2.00" (show #f (numeric 1999/1000 10 2)))
(check-equal "2.0" (show #f (numeric 1999/1000 10 1)))
(check-equal "2" (show #f (numeric 1999/1000 10 0)))

;; sign
(check-equal "+1" (show #f (numeric 1 10 #f #t)))
(check-equal "+1" (show #f (with ((sign-rule #t)) (numeric 1))))
(check-equal "(1)" (show #f (with ((sign-rule '("(" . ")"))) (numeric -1))))
(check-equal "-1" (show #f (with ((sign-rule '("-" . ""))) (numeric -1))))
(check-equal "−1-" (show #f (with ((sign-rule '("−" . "-"))) (numeric -1))))
(check-equal "-0.0" (show #f (with ((sign-rule #t)) (numeric -0.0))))
(check-equal "+0.0" (show #f (with ((sign-rule #t)) (numeric +0.0))))

(check-equal "+inf.0" (show #f (with ((sign-rule #f)) (numeric +inf.0))))
(check-equal "-inf.0" (show #f (with ((sign-rule #f)) (numeric -inf.0))))
(check-equal "+nan.0" (show #f (with ((sign-rule #f)) (numeric +nan.0))))

(check-equal "+inf.0" (show #f (with ((sign-rule #t)) (numeric +inf.0))))
(check-equal "-inf.0" (show #f (with ((sign-rule #t)) (numeric -inf.0))))
(check-equal "+nan.0" (show #f (with ((sign-rule #t)) (numeric +nan.0))))

(check-equal "+inf.0" (show #f (with ((sign-rule '("(" . ")"))) (numeric +inf.0))))
(check-equal "-inf.0" (show #f (with ((sign-rule '("(" . ")"))) (numeric -inf.0))))
(check-equal "+nan.0" (show #f (with ((sign-rule '("(" . ")"))) (numeric +nan.0))))

;; comma-rule
(check-equal "299792458" (show #f (with ((comma-rule 3)) 299792458)))
(check-equal "299,792,458" (show #f (with ((comma-rule 3)) (numeric 299792458))))
(check-equal "-29,97,92,458"
    (show #f (with ((comma-rule '(3 2))) (numeric -299792458))))
(check-equal "299.792.458"
    (show #f (with ((comma-rule 3) (comma-sep #\.)) (numeric 299792458))))
(check-equal "299.792.458,0"
    (show #f (with ((comma-rule 3) (decimal-sep #\,)) (numeric 299792458.0))))

(check-equal "100,000" (show #f (with ((comma-rule 3)) (numeric 100000))))
(check-equal "100,000.0"
    (show #f (with ((comma-rule 3) (precision 1)) (numeric 100000))))
(check-equal "100,000.00"
    (show #f (with ((comma-rule 3) (precision 2)) (numeric 100000))))
;; comma
(check-equal "1,234,567" (show #f (numeric 1234567 10 #f #f 3)))
(check-equal "567" (show #f (numeric 567 10 #f #f 3)))
(check-equal "1,23,45,67" (show #f (numeric 1234567 10 #f #f 2)))
(check-equal "12,34,567" (show #f (numeric 1234567 10 #f #f '(3 2))))

;; comma-sep
(check-equal "1|234|567" (show #f (numeric 1234567 10 #f #f 3 #\|)))
(check-equal "1&234&567" (show #f (with ((comma-sep #\&)) (numeric 1234567 10 #f #f 3))))
(check-equal "1*234*567" (show #f (with ((comma-sep #\&)) (numeric 1234567 10 #f #f 3 #\*))))
(check-equal "567" (show #f (numeric 567 10 #f #f 3 #\|)))
(check-equal "1,23,45,67" (show #f (numeric 1234567 10 #f #f 2)))

(check-equal "1,234,567" (show #f (numeric/comma 1234567)))
(check-equal "1,234,567" (show #f (numeric/comma 1234567 3)))
(check-equal "123,4567" (show #f (numeric/comma 1234567 4)))

(check-equal "123,456,789" (show #f (numeric/comma 123456789)))
(check-equal "1,23,45,67,89" (show #f (numeric/comma 123456789 2)))
(check-equal "12,34,56,789" (show #f (numeric/comma 123456789 '(3 2))))

;; decimal
(check-equal "1_5" (show #f (with ((decimal-sep #\_)) (numeric 1.5))))
(check-equal "1,5" (show #f (with ((comma-sep #\.)) (numeric 1.5))))
(check-equal "1,5" (show #f (numeric 1.5 10 #f #f #f #\.)))
(check-equal "1%5" (show #f (numeric 1.5 10 #f #f #f #\. #\%)))

(check-equal "1+2i" (show #f (string->number "1+2i")))
(check-equal "1.00+2.00i"
    (show #f (with ((precision 2)) (string->number "1+2i"))))
(check-equal "3.14+2.00i"
    (show #f (with ((precision 2)) (string->number "3.14159+2i"))))

(check-equal "123/4567" (show #f 123/4567))
(check-equal "123/4567" (show #f (numeric 123/4567)))

(check-equal "608" (show #f (numeric/si 608)))
(check-equal "608 B" (show #f (numeric/si 608 1000 " ") "B"))
(check-equal "4k" (show #f (numeric/si 3986)))
(check-equal "3.9Ki" (show #f (numeric/si 3986 1024)))
(check-equal "4kB" (show #f (numeric/si 3986 1000) "B"))
(check-equal "1.2M" (show #f (numeric/si 1.23e6 1000)))
(check-equal "123k" (show #f (numeric/si 1.23e5 1000)))
(check-equal "12.3k" (show #f (numeric/si 1.23e4 1000)))
(check-equal "1.2k" (show #f (numeric/si 1.23e3 1000)))
(check-equal "123" (show #f (numeric/si 1.23e2 1000)))
(check-equal "12.3" (show #f (numeric/si 1.23e1 1000)))
(check-equal "1.2" (show #f (numeric/si 1.23 1000)))
(check-equal "1.2 m" (show #f (numeric/si 1.23 1000 " ") "m"))
(check-equal "123m" (show #f (numeric/si 0.123 1000)))
(check-equal "12.3m" (show #f (numeric/si 1.23e-2 1000)))
(check-equal "1.2m" (show #f (numeric/si 1.23e-3 1000)))
(check-equal "123n" (show #f (numeric/si 1.23e-7 1000)))
(check-equal "12.3n" (show #f (numeric/si 1.23e-8 1000)))
(check-equal "1.2n" (show #f (numeric/si 1.23e-9 1000)))
(check-equal "1.2 nm" (show #f (numeric/si 1.23e-9 1000 " ") "m"))
(check-equal "0" (show #f (numeric/si 0)))
(check-equal "-608" (show #f (numeric/si -608)))
(check-equal "-4k" (show #f (numeric/si -3986)))

(check-equal "1.23" (show #f (numeric/fitted 4 1.2345 10 2)))
(check-equal "1.00" (show #f (numeric/fitted 4 1 10 2)))
(check-equal "#.##" (show #f (numeric/fitted 4 12.345 10 2)))
(check-equal "#" (show #f (numeric/fitted 1 12.345 10 0)))
(check-equal "##" (show #f (with ((precision 0)) (numeric/fitted 2 123.45))))

;; joining
(check-equal "1 2 3" (show #f (joined each '(1 2 3) " ")))
(check-equal "a, b, c" (show #f (joined displayed '(a b c) ", ")))
(check-equal "123-456-7890" (show #f (joined displayed '("123" "456" "7890") "-")))
(check-equal "abc3def7ghijk13lmn"
    (show #f (joined displayed '("abc" "def" "ghijk" "lmn") (fn (col) col))))
(check-equal "" (show #f (joined (lambda (obj) (raise obj)) '() "****")))
(check-equal "abcd" (show #f (joined displayed '(abcd) "****")))
(check-equal "abcdef" (show #f (joined displayed '(ab ef) "cd")))

(check-equal "/usr/local/bin" (show #f (joined/prefix displayed '(usr local bin) "/")))
(check-equal "1\n2\n3\n" (show #f (joined/suffix displayed '(1 2 3) nl)))

(check-equal "" (show #f (joined/prefix displayed '() "*")))
(check-equal "*ab" (show #f (joined/prefix displayed '(ab) "*")))
(check-equal "*ab*cd" (show #f (joined/prefix displayed '(ab cd) "*")))
(check-equal "*ab*cd*ef" (show #f (joined/prefix displayed '(ab cd ef) "*")))

(check-equal "" (show #f (joined/suffix displayed '() "*")))
(check-equal "ab*" (show #f (joined/suffix displayed '(ab) "*")))
(check-equal "ab*cd*" (show #f (joined/suffix displayed '(ab cd) "*")))
(check-equal "ab*cd*ef*" (show #f (joined/suffix displayed '(ab cd ef) "*")))

(check-equal "lions, tigers, and bears"
    (show #f
            (joined/last displayed
                    (lambda (last) (each "and " last))
                    '(lions tigers bears)
                    ", ")))
(check-equal ""
    (show #f (joined/last displayed (lambda (last) (each "#" last "#")) '() "*")))
(check-equal "#ab#"
    (show #f (joined/last displayed (lambda (last) (each "#" last "#")) '(ab) "*")))
(check-equal "ab*#cd#"
    (show #f (joined/last displayed (lambda (last) (each "#" last "#")) '(ab cd) "*")))
(check-equal "ab*cd*#ef#"
    (show #f (joined/last displayed (lambda (last) (each "#" last "#")) '(ab cd ef) "*")))

(check-equal "(1 2 . 3)" (show #f "("
        (joined/dot displayed (lambda (dot) (each ". " dot)) '(1 2 . 3) " ")
        ")"))

(check-equal ""
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '() "*")))
(check-equal "ab"
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '(ab) "*")))
(check-equal "ab*cd"
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '(ab cd) "*")))
(check-equal "ab*cd*ef"
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '(ab cd ef) "*")))
(check-equal "ab*#cd"
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '(ab . cd) "*")))
(check-equal "ab*cd*#ef"
    (show #f (joined/dot displayed (lambda (dot) (each "#" dot)) '(ab cd . ef) "*")))

(check-equal "" (show #f (joined/range displayed 0 0 " ")))
(check-equal "0" (show #f (joined/range displayed 0 1 " ")))
(check-equal "0 1" (show #f (joined/range displayed 0 1.5 " ")))
(check-equal "0 1" (show #f (joined/range displayed 0 2 " ")))
(check-equal "0 1 2" (show #f (joined/range displayed 0 2.000001 " ")))
(check-equal "0 1 2 3 4" (show #f (joined/range displayed 0 5 " ")))

(check-equal ":abc:123"
    (show #f (joined/prefix
              (lambda (x) (trimmed/right 3 x))
              '("abcdef" "123456")
              ":")))

(check-equal "abc\n123\n"
    (show #f (joined/suffix
              (lambda (x) (trimmed/right 3 x))
              '("abcdef" "123456")
              nl)))

(check-equal "lions, tigers, and bears"
    (show #f (joined/last
              each
              (lambda (x) (each "and " x))
              '(lions tigers bears)
              ", ")))

(check-equal "lions, tigers, or bears"
    (show #f (joined/dot
              each
              (lambda (x) (each "or " x))
              '(lions tigers . bears)
              ", ")))

;; padding/trimming
(check-equal "abc  " (show #f (padded/right 5 "abc")))
(check-equal "  abc" (show #f (padded 5 "abc")))
(check-equal "abcdefghi" (show #f (padded 5 "abcdefghi")))
(check-equal " abc " (show #f (padded/both 5 "abc")))
(check-equal " abc  " (show #f (padded/both 6 "abc")))
(check-equal "abcde" (show #f (padded/right 5 "abcde")))
(check-equal "abcdef" (show #f (padded/right 5 "abcdef")))

(check-equal "abc" (show #f (trimmed/right 3 "abcde")))
(check-equal "abc" (show #f (trimmed/right 3 "abcd")))
(check-equal "abc" (show #f (trimmed/right 3 "abc")))
(check-equal "ab" (show #f (trimmed/right 3 "ab")))
(check-equal "a" (show #f (trimmed/right 3 "a")))
(check-equal "abcde" (show #f (trimmed/right 5 "abcdef")))
(check-equal "abcde" (show #f (trimmed 5 "abcde")))
(check-equal "cde" (show #f (trimmed 3 "abcde")))
(check-equal "bcdef" (show #f (trimmed 5 "abcdef")))
(check-equal "bcd" (show #f (trimmed/both 3 "abcde")))
(check-equal "abcd" (show #f (trimmed/both 4 "abcde")))
(check-equal "abcde" (show #f (trimmed/both 5 "abcdef")))
(check-equal "bcde" (show #f (trimmed/both 4 "abcdef")))
(check-equal "bcdef" (show #f (trimmed/both 5 "abcdefgh")))
(check-equal "abc" (show #f (trimmed/lazy 3 "abcde")))
(check-equal "abc" (show #f (trimmed/lazy 3 "abc\nde")))
(check-equal "abc" (show #f (trimmed/lazy 3 "a" "b" "c" "d" "e")))

(check-equal "prefix: abc" (show #f "prefix: " (trimmed/right 3 "abcde")))
(check-equal "prefix: cde" (show #f "prefix: " (trimmed 3 "abcde")))
(check-equal "prefix: bcd" (show #f "prefix: " (trimmed/both 3 "abcde")))
(check-equal "prefix: abc" (show #f "prefix: " (trimmed/lazy 3 "abcde")))
(check-equal "prefix: abc" (show #f "prefix: " (trimmed/lazy 3 "abc\nde")))

(check-equal "abc :suffix" (show #f (trimmed/right 3 "abcde") " :suffix"))
(check-equal "cde :suffix" (show #f (trimmed 3 "abcde") " :suffix"))
(check-equal "bcd :suffix" (show #f (trimmed/both 3 "abcde") " :suffix"))
(check-equal "abc :suffix" (show #f (trimmed/lazy 3 "abcde") " :suffix"))
(check-equal "abc :suffix" (show #f (trimmed/lazy 3 "abc\nde") " :suffix"))

(check-equal "abc" (show #f (trimmed/lazy 10 (trimmed/lazy 3 "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "abc" (show #f (trimmed/lazy 3 (trimmed/lazy 10 "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "0 1 2 3 4" (show #f (trimmed/lazy 9 (joined/range displayed 0 #f " "))))

(check-equal "abcde"
    (show #f (with ((ellipsis "...")) (trimmed/right 5 "abcde"))))
(check-equal "ab..."
    (show #f (with ((ellipsis "...")) (trimmed/right 5 "abcdef"))))
(check-equal "abc..."
    (show #f (with ((ellipsis "...")) (trimmed/right 6 "abcdefg"))))
(check-equal "abcde"
    (show #f (with ((ellipsis "...")) (trimmed 5 "abcde"))))
(check-equal "...ef"
    (show #f (with ((ellipsis "...")) (trimmed 5 "abcdef"))))
(check-equal "...efg"
    (show #f (with ((ellipsis "...")) (trimmed 6 "abcdefg"))))
(check-equal "abcdefg"
    (show #f (with ((ellipsis "...")) (trimmed/both 7 "abcdefg"))))
(check-equal "...d..."
    (show #f (with ((ellipsis "...")) (trimmed/both 7 "abcdefgh"))))
(check-equal "...e..."
    (show #f (with ((ellipsis "...")) (trimmed/both 7 "abcdefghi"))))

(check-equal "abc  " (show #f (fitted/right 5 "abc")))
(check-equal "  abc" (show #f (fitted 5 "abc")))
(check-equal " abc " (show #f (fitted/both 5 "abc")))
(check-equal "abcde" (show #f (fitted/right 5 "abcde")))
(check-equal "abcde" (show #f (fitted 5 "abcde")))
(check-equal "abcde" (show #f (fitted/both 5 "abcde")))
(check-equal "abcde" (show #f (fitted/right 5 "abcdefgh")))
(check-equal "defgh" (show #f (fitted 5 "abcdefgh")))
(check-equal "bcdef" (show #f (fitted/both 5 "abcdefgh")))

(check-equal "prefix: abc   :suffix"
    (show #f "prefix: " (fitted/right 5 "abc") " :suffix"))
(check-equal "prefix:   abc :suffix"
    (show #f "prefix: " (fitted 5 "abc") " :suffix"))
(check-equal "prefix:  abc  :suffix"
    (show #f "prefix: " (fitted/both 5 "abc") " :suffix"))
(check-equal "prefix: abcde :suffix"
    (show #f "prefix: " (fitted/right 5 "abcde") " :suffix"))
(check-equal "prefix: abcde :suffix"
    (show #f "prefix: " (fitted 5 "abcde") " :suffix"))
(check-equal "prefix: abcde :suffix"
    (show #f "prefix: " (fitted/both 5 "abcde") " :suffix"))
(check-equal "prefix: abcde :suffix"
    (show #f "prefix: " (fitted/right 5 "abcdefgh") " :suffix"))
(check-equal "prefix: defgh :suffix"
    (show #f "prefix: " (fitted 5 "abcdefgh") " :suffix"))
(check-equal "prefix: bcdef :suffix"
    (show #f "prefix: " (fitted/both 5 "abcdefgh") " :suffix"))

;; columnar
(define (runner->list runner)
    (define (run tail)
        (let ((val (runner)))
            (if (string? val)
                (begin
                    (set-cdr! tail (list val))
                    (run (cdr tail))))))
    (let ((tail (list #f)))
        (run tail)
        (cdr tail)))

(check-equal ("abc" "12" "345" "67")
    (runner->list (make-runner 67 (each "abc" nl "12\n345" nl (fn (width) width)))))
(check-equal ("abc  " "def  ")
    (runner->list (make-runner 0
            (each (padded/right 5 "abc") nl
                    (padded/right 5 (displayed "def"))))))
(check-equal ("123" "456")
    (runner->list (make-runner 0 (displayed "123\n456\n"))))
(check-equal ("123" "" "456")
    (runner->list (make-runner 0 (displayed "123\n\n456\n"))))

(check-equal (#t "" "abc")
    (let-values (((found first rest) (string-split "\nabc" #\newline))) (list found first rest)))
(check-equal (#t "abc" "def")
    (let-values (((found first rest) (string-split "abc\ndef" #\newline)))
        (list found first rest)))
(check-equal (#t "abc" "")
    (let-values (((found first rest) (string-split "abc\n" #\newline))) (list found first rest)))
(check-equal (#f "abc" "")
    (let-values (((found first rest) (string-split "abc" #\newline))) (list found first rest)))
(check-equal (#f "" "")
    (let-values (((found first rest) (string-split "" #\newline))) (list found first rest)))
(check-equal (#t "" "ab\nc")
    (let-values (((found first rest) (string-split "\nab\nc" #\newline))) (list found first rest)))
(check-equal (#t "abc" "d\nef\n")
    (let-values (((found first rest) (string-split "abc\nd\nef\n" #\newline)))
         (list found first rest)))
(check-equal (#t "abc" "\n")
    (let-values (((found first rest) (string-split "abc\n\n" #\newline))) (list found first rest)))

(check-equal ("abc")
    (runner->list (make-infinite-runner 67 (displayed "abc"))))
(check-equal ("abc")
    (runner->list (make-infinite-runner 67 (displayed "abc\n"))))
(check-equal ("abc" "12" "345")
    (runner->list (make-infinite-runner 67 (each "abc" nl "12\n345"))))
(check-equal ("abc" "12" "345")
    (runner->list (make-infinite-runner 67 (each "abc" nl "12\n345" nl))))
(check-equal ("abc" "12" "345" "67")
    (runner->list (make-infinite-runner 67 (each "abc" nl "12\n345" nl (fn (width) width)))))
(check-equal ("123" "" "456")
    (runner->list (make-infinite-runner 0 (displayed "123\n\n456"))))

(check-equal "   abc |   def    |   ghi\n"
    (show #f
        (columnar 6 'right (displayed "abc") " | " 'center 8 (displayed "def")
                " | " 'right 5 (displayed "ghi"))))
(check-equal "   abc |   def    |   ghi\n  1234 |   5678   |    90\n"
    (show #f
        (columnar 6 'right (displayed "abc\n1234") " | " 'center 8 (displayed "def\n5678")
                " | " 'right 5 (displayed "ghi\n90"))))
(check-equal " abc   |      def | ghi\n 1234  |     5678 | 90\n"
    (show #f
        (columnar 6 'center (displayed "abc\n1234") " | " 'right 8 (displayed "def\n5678")
                " | " 'left 5 (displayed "ghi\n90"))))

(check-equal "   abc |   def\n  1234 |   5678\n"
    (show #f
        (columnar 6 'right (displayed "abc\n1234") " | " 'center 8 (displayed "def\n5678"))))

(check-equal "\n" (show #f (columnar)))
(check-equal "\n" (show #f (columnar "*")))
(check-equal "*\n" (show #f (columnar (each "*"))))

(check-equal "abc     123\ndef     456\n"
    (show #f (with ((width 16)) (columnar (displayed "abc\ndef") (displayed "123\n456")))))

(check-equal "/* abc | 123 */\n/* def | 456 */\n"
    (show #f (with ((width 15))
            (columnar "/* " (displayed "abc\ndef") " | " (displayed "123\n456") " */"))))

(check-equal "abc\ndef\n"
    (show #f (columnar (displayed "abc\ndef\n"))))
(check-equal "abc123\ndef456\n"
    (show #f (with ((width 0)) (columnar (displayed "abc\ndef\n") (displayed "123\n456\n")))))
(check-equal "abc123\ndef456\n"
    (show #f (with ((width 0)) (columnar (displayed "abc\ndef\n") (displayed "123\n456")))))
(check-equal "abc123\ndef456\n"
    (show #f (with ((width 0)) (columnar (displayed "abc\ndef") (displayed "123\n456\n")))))
(check-equal "abc123\ndef456\n"
    (show #f (with ((width 0)) (columnar (displayed "abc\ndef") (displayed "123\n456")))))
(check-equal "abc123\n \ndef456\n"
    (show #f (with ((width 1)) (columnar (displayed "abc\n\ndef") (displayed "123\n\n456")))))
(check-equal "abc123\ndef\n 456\n"
    (show #f (with ((width 1)) (columnar (displayed "abc\ndef") (displayed "123\n\n456")))))
(check-equal "abc123\n 456\ndef\n"
    (show #f (with ((width 1)) (columnar (displayed "abc\n\ndef") (displayed "123\n456")))))
(check-equal "abc123\ndef456\nghi789\n"
    (show #f (with ((width 0))
            (columnar (displayed "abc\ndef\nghi\n") (displayed "123\n456\n789\n")))))
(check-equal "abc123wuv\ndef456xyz\n"
    (show #f (with ((width 0))
            (columnar (displayed "abc\ndef\n") (displayed "123\n456\n")
                    (displayed "wuv\nxyz\n")))))
(check-equal "abc  123\ndef  456\n"
    (show #f (with ((width 0))
            (columnar
                    (each (padded/right 5 "abc") nl (padded/right 5 "def"))
                    (displayed "123\n456\n")))))
(check-equal "ABC  123\nDEF  456\n"
    (show #f (with ((width 0))
            (columnar
                    (each
                            (upcased (padded/right 5 (displayed "abc")))
                            nl
                            (upcased (padded/right 5 (displayed "def"))))
                    (displayed "123\n456\n")))))
(check-equal "ABC  123\nDEF  456\n"
    (show #f (with ((width 0))
            (columnar
                    (each
                            (padded/right 5 (upcased (displayed "abc")))
                            nl
                            (padded/right 5 (upcased (displayed "def"))))
                     (displayed "123\n456\n")))))

(check-equal "   1 first line\n   2 second line\n   3 third line\n"
    (show #f (columnar 4 'right 'infinite (line-numbers) " "
            (displayed "first line\nsecond line\nthird line"))))
(check-equal "   1 first line\n   2 second line\n   3 third line\n"
    (show #f (columnar 4 'right 'infinite (line-numbers) " "
            (displayed "first line\nsecond line\nthird line\n"))))

(check-equal "a   | 123\nbc  | 45\ndef | 6\n"
    (show #f (with ((width 20))
            (tabular (each "a\nbc\ndef\n") " | " (each "123\n45\n6\n")))))

(check-equal "|a  |123|\n|bc |45 |\n|def|6  |\n"
    (show #f (tabular "|" (each "a\nbc\ndef\n") "|" (each "123\n45\n6\n") "|")))

(check-equal "|a       |123|\n|bc      |45 |\n|def     |6  |\n"
    (show #f (tabular "|" 8 (each "a\nbc\ndef\n") "|" (each "123\n45\n6\n") "|")))

(check-equal "|       a|   123    |\n|      bc|    45    |\n|     def|    6     |\n"
    (show #f (tabular "|" 'right 8 (each "a\nbc\ndef\n") "|"
            10 'center (each "123\n45\n6\n") "|")))

(check-equal "| 8 |       a|   123    |\n| 9 |      bc|    45    |\n|10 |     def|    6     |\n"
    (show #f (tabular "|" 3 'infinite 'center (line-numbers 8) "|"
            'right 8 (each "a\nbc\ndef\n") "|" 10 'center (each "123\n45\n6\n") "|")))

(check-equal "1234567890\nabcdefghij\nkl\n"
    (show #f (with ((width 10)) (wrapped/char "12345" "67890abcdefghijkl"))))
(check-equal "abc\ndef    g\nhijklmn \nopq\n"
    (show #f (with ((width 8)) (wrapped/char "abc\ndef    ghijklmn opq"))))
(check-equal "abcdefgh\nijklmnop\nqrstuvwx\nyz\n"
    (show #f (with ((width 8)) (wrapped/char "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "abcdefghijklmnopqrstuvwxyz\n"
    (show #f (with ((width 30)) (wrapped/char "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "abcdefghijklmnopqrstuvwxyz\n"
    (show #f (with ((width 26)) (wrapped/char "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "abcdefghijklmnopqrstuvwxy\nz\n"
    (show #f (with ((width 25)) (wrapped/char "abcdefghijklmnopqrstuvwxyz"))))
(check-equal "\na\n" (show #f (with ((width 4)) (wrapped/char "\na\n"))))
(check-equal "\n\n" (show #f (with ((width 4)) (wrapped/char "\n\n"))))
(check-equal "\n" (show #f (with ((width 4)) (wrapped/char "\n"))))
(check-equal "\n" (show #f (with ((width 4)) (wrapped/char ""))))

(check-equal ("abc" "defghi" "jklmn") (string->words "abc defghi jklmn" char-whitespace?))
(check-equal ("abc" "defghi" "jklmn") (string->words "  abc   defghi   jklmn  " char-whitespace?))
(check-equal ("abc" "defghi" "jklmn")
        (string->words "\nabc \n defghi \njklmn \n " char-whitespace?))

(check-equal "" (show #f (wrapped "    ")))
(check-equal "hello\nworld" (show #f (with ((width 8)) (wrapped "hello world"))))
;(check-equal "ｈｅｌｌｏ\nｗｏｒｌｄ"
;    (show #f (with ((width 16)) (terminal-aware (wrapped "ｈｅｌｌｏ　ｗｏｒｌｄ")))))

(check-equal "The fundamental list iterator.\nApplies KONS to each element of\nLS and the result of the previous\napplication, beginning with KNIL.\nWith KONS as CONS and KNIL as '(),\nequivalent to REVERSE."
    (show #f (with ((width 36))
            (wrapped "The fundamental list iterator.  Applies KONS to each element of LS and the result of the previous application, beginning with KNIL.  With KONS as CONS and KNIL as '(), equivalent to REVERSE."))))
(check-equal "foo" (show #f (wrapped "foo")))

(check-equal "- Item 1: The text here is\n          indented according\n          to the space \"Item\n          1\" takes, and one\n          does not known what\n          goes here.\n"
    (show #f (columnar 9 (each "- Item 1:") " "
            (with ((width 20)) (wrapped "The text here is indented according to the space \"Item 1\" takes, and one does not known what goes here.")))))

(check-equal "- Item 1: The text here is\n          indented according\n          to the space \"Item\n          1\" takes, and one\n          does not known what\n          goes here.\n"
    (show #f (columnar 9 (each "- Item 1:\n") " "
            (with ((width 20)) (wrapped "The text here is indented according to the space \"Item 1\" takes, and one does not known what goes here.")))))

(check-equal "- Item 1: The-text-here-is----\n--------- indented-according--\n--------- to-the-space-\"Item--\n--------- 1\"-takes,-and-one---\n--------- does-not-known-what-\n--------- goes-here.----------\n"
    (show #f (with ((pad-char #\-) (width 30)) (columnar 9 (each "- Item 1:\n") " "
            (with ((width 20)) (wrapped "The text here is indented according to the space \"Item 1\" takes, and one does not known what goes here."))))))

(check-equal "The  quick\nbrown  fox\njumped\nover   the\nlazy dog"
    (show #f (with ((width 10)) (justified "The quick brown fox jumped over the lazy dog"))))

(check-equal "The--quick\nbrown--fox\njumped----\nover---the\nlazy-dog"
    (show #f (with ((width 10) (pad-char #\-))
            (justified "The quick brown fox jumped over the lazy dog"))))

(define output-166 "first line\nsecond line\nthird line")
(call-with-output-file "output-166.txt"
        (lambda (file) (display output-166 file)))
(check-equal "first line\nsecond line\nthird line\n"
    (show #f (from-file "output-166.txt")))
(check-equal "   1 first line\n   2 second line\n   3 third line\n"
    (show #f (columnar 4 'right 'infinite (line-numbers) " " (from-file "output-166.txt"))))

;; shared structures
(check-equal "#0=(1 . #0#)"
    (show #f (written (let ((ones (list 1))) (set-cdr! ones ones) ones))))
(check-equal "(0 . #0=(1 . #0#))"
    (show #f (written (let ((ones (list 1)))
                        (set-cdr! ones ones)
                        (cons 0 ones)))))
(check-equal "(sym . #0=(sym . #0#))"
    (show #f (written (let ((syms (list 'sym)))
                        (set-cdr! syms syms)
                        (cons 'sym syms)))))
(check-equal "(#0=(1 . #0#) #1=(2 . #1#))"
    (show #f (written (let ((ones (list 1))
                            (twos (list 2)))
                        (set-cdr! ones ones)
                        (set-cdr! twos twos)
                        (list ones twos)))))
(check-equal "(#0=(1 . #0#) #0#)"
    (show #f (written (let ((ones (list 1)))
                        (set-cdr! ones ones)
                        (list ones ones)))))
(check-equal "((1) (1))"
    (show #f (written (let ((ones (list 1)))
                        (list ones ones)))))

(check-equal "(#0=(1) #0#)"
    (show #f (written-shared (let ((ones (list 1)))
                               (list ones ones)))))

;; cycles without shared detection
(check-equal "(1 1 1 1 1"
    (show #f (trimmed/lazy
              10
              (written-simply
               (let ((ones (list 1))) (set-cdr! ones ones) ones)))))

(check-equal "(1 1 1 1 1 "
    (show #f (trimmed/lazy
              11
              (written-simply
               (let ((ones (list 1))) (set-cdr! ones ones) ones)))))

#|
;; color
(check-equal "\x1B;[31mred\x1B;[39m" (show #f (as-red "red")))
(check-equal "\x1B;[31mred\x1B;[34mblue\x1B;[31mred\x1B;[39m"
    (show #f (as-red "red" (as-blue "blue") "red")))
;(check-equal "\x1b;[31m1234567\x1b;[39m col: 7"
;    (show #f (terminal-aware (as-red "1234567") (fn (col) (each " col: " col)))))
(check-equal "\x1b;[31m\x1b;[4m\x1b;[1mabc\x1b;[22mdef\x1b;[24mghi\x1b;[39m"
    (show #f (as-red (each (as-underline (as-bold "abc") "def") "ghi"))))
(check-equal "\x1b;[44m\x1b;[33mabc\x1b;[39mdef\x1b;[49m"
    (show #f (on-blue (each (as-yellow "abc") "def"))))
|#

#|
(define-library (srfi 166 test)
  (export run-tests)
  (import (scheme base) (scheme char) (scheme read) (scheme file)
          (only (srfi 1) circular-list)
          (chibi test)
          (srfi 166))
  (begin
    (define-syntax test-pretty
      (syntax-rules ()
        ((test-pretty str)
         (let ((sexp (read (open-input-string str))))
           (test str (show #f (pretty sexp)))))))
    (define (run-tests)
      (test-begin "show")

      ;; pretty printing

      (test-pretty "(foo bar)\n")

      (test-pretty
       "((self . aquanet-paper-1991)
 (type . paper)
 (title . \"Aquanet: a hypertext tool to hold your\"))
")

      (test-pretty
       "(abracadabra xylophone
             bananarama
             yellowstonepark
             cryptoanalysis
             zebramania
             delightful
             wubbleflubbery)\n")

      (test-pretty
       "#(0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
  26 27 28 29 30 31 32 33 34 35 36 37)\n")

      (test-pretty
       "(0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
 26 27 28 29 30 31 32 33 34 35 36 37)\n")

      (test-pretty
       "(#(0 1)   #(2 3)   #(4 5)   #(6 7)   #(8 9)   #(10 11) #(12 13) #(14 15)
 #(16 17) #(18 19))\n")

      (test-pretty
       "#(#(0 1)   #(2 3)   #(4 5)   #(6 7)   #(8 9)   #(10 11) #(12 13) #(14 15)
  #(16 17) #(18 19))\n")

      (test-pretty
       "(define (fold kons knil ls)
  (define (loop ls acc)
    (if (null? ls) acc (loop (cdr ls) (kons (car ls) acc))))
  (loop ls knil))\n")

      (test-pretty
       "(do ((vec (make-vector 5)) (i 0 (+ i 1))) ((= i 5) vec) (vector-set! vec i i))\n")

      (test-pretty
       "(do ((vec (make-vector 5)) (i 0 (+ i 1))) ((= i 5) vec)
  (vector-set! vec i 'supercalifrajalisticexpialidocious))\n")

      (test-pretty
       "(do ((my-vector (make-vector 5)) (index 0 (+ index 1)))
    ((= index 5) my-vector)
  (vector-set! my-vector index index))\n")

      (test-pretty
       "(define (fold kons knil ls)
  (let loop ((ls ls) (acc knil))
    (if (null? ls) acc (loop (cdr ls) (kons (car ls) acc)))))\n")

      (test-pretty
       "(define (file->sexp-list pathname)
  (call-with-input-file pathname
    (lambda (port)
      (let loop ((res '()))
        (let ((line (read port)))
          (if (eof-object? line) (reverse res) (loop (cons line res))))))))\n")

      (test-pretty
       "(design
 (module (name \"\\\\testshiftregister\") (attributes (attribute (name \"\\\\src\"))))
 (wire (name \"\\\\shreg\") (attributes (attribute (name \"\\\\src\")))))\n")

      (test-pretty
       "(design
 (module (name \"\\\\testshiftregister\")
         (attributes
          (attribute (name \"\\\\src\") (value \"testshiftregister.v:10\"))))
 (wire (name \"\\\\shreg\")
       (attributes
        (attribute (name \"\\\\src\") (value \"testshiftregister.v:15\")))))\n")

      (test "(let ((ones '#0=(1 . #0#))) ones)\n"
          (show #f (pretty (let ((ones (list 1)))
                             (set-cdr! ones ones)
                             `(let ((ones ',ones)) ones)))))

      '(test
           "(let ((zeros '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (ones '#0=(1 . #0#)))
  (append zeros ones))\n"
           (show #f (pretty
                     (let ((ones (list 1)))
                       (set-cdr! ones ones)
                       `(let ((zeros '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                              (ones ',ones))
                          (append zeros ones))))))

      ;; pretty-simply
      (let* ((d (let ((d (list 'a 'b #f)))
                  (list-set! d 2 d)
                  (list d)))
             (ca (circular-list 'a)))
        (test "((a b (a b (a b" (show #f (trimmed/lazy 15 (pretty-simply '((a b (a b (a b (a b)))))))))
        (test "((a b\n    (a b\n" (show #f (trimmed/lazy 15 (pretty-simply d))))
        (test "'(a a\n    a\n   " (show #f (trimmed/lazy 15 (pretty-simply `(quote ,ca)))))
        (test "(foo\n (a a\n    " (show #f (trimmed/lazy 15 (pretty-simply `(foo ,ca)))))
        (test "(with-x \n  (a a" (show #f (trimmed/lazy 15 (pretty-simply `(with-x ,ca)))))
        )

      (test
          "(define (fold kons knil ls)
  (let lp ((ls ls) (acc knil))
    (if (null? ls)
        acc
        (lp (cdr ls)
            (kons (car ls) acc)))))
"
          (show #f
                (with ((width 36))
                  (pretty '(define (fold kons knil ls)
                             (let lp ((ls ls) (acc knil))
                               (if (null? ls)
                                   acc
                                   (lp (cdr ls)
                                       (kons (car ls) acc)))))))))

      '(test
           "(define (fold kons knil ls)          ; The fundamental list iterator.
  (let lp ((ls ls) (acc knil))       ; Applies KONS to each element of
    (if (null? ls)                   ; LS and the result of the previous
        acc                          ; application, beginning with KNIL.
        (lp (cdr ls)                 ; With KONS as CONS and KNIL as '(),
            (kons (car ls) acc)))))  ; equivalent to REVERSE.
"
           (show #f
                 (show-columns
                  (list
                   (lambda (x) (padded/right 36 x))
                   (with ((width 36))
                     (pretty '(define (fold kons knil ls)
                                (let lp ((ls ls) (acc knil))
                                  (if (null? ls)
                                      acc
                                      (lp (cdr ls)
                                          (kons (car ls) acc))))))))
                  (list
                   (lambda (x) (each " ; " x))
                   (with ((width 36))
                     (wrapped "The fundamental list iterator.  Applies KONS to each element of LS and the result of the previous application, beginning with KNIL.  With KONS as CONS and KNIL as '(), equivalent to REVERSE."))))))

      (test
           "(define (fold kons knil ls)          ; The fundamental list iterator.
  (let lp ((ls ls) (acc knil))       ; Applies KONS to each element of
    (if (null? ls)                   ; LS and the result of the previous
        acc                          ; application, beginning with KNIL.
        (lp (cdr ls)                 ; With KONS as CONS and KNIL as '(),
            (kons (car ls) acc)))))  ; equivalent to REVERSE.
"
           (show #f (with ((width 76))
                      (columnar
                       (pretty '(define (fold kons knil ls)
                                  (let lp ((ls ls) (acc knil))
                                    (if (null? ls)
                                        acc
                                        (lp (cdr ls)
                                            (kons (car ls) acc))))))
                       " ; "
                       (wrapped "The fundamental list iterator.  Applies KONS to each element of LS and the result of the previous application, beginning with KNIL.  With KONS as CONS and KNIL as '(), equivalent to REVERSE.")))))

      ;; unicode
      (test "〜日本語〜"
          (show #f (with ((pad-char #\〜)) (padded/both 5 "日本語"))))
      (test "日本語"
          (show #f (terminal-aware (with ((pad-char #\〜)) (padded/both 5 "日本語")))))
      (test "本語"
          (show #f (trimmed 2 "日本語")))
      (test "語"
          (show #f (terminal-aware (trimmed 2 "日本語"))))
      (test "日本"
          (show #f (trimmed/right 2 "日本語")))
      (test "日"
          (show #f (terminal-aware (trimmed/right 2 "日本語"))))
      (test "\x1B;[31m日\x1B;[46m\x1B;[49m\x1B;[39m"
          (show #f (terminal-aware
                    (trimmed/right 2 (as-red "日本語" (on-cyan "!!!!"))))))
      (test "日本語"
          (show #f (trimmed/right 3 "日本語")))
      (test "日"
          (show #f (terminal-aware (trimmed/right 3 "日本語"))))
      (test "日本語 col: 6"
          (show #f (terminal-aware "日本語" (fn (col) (each " col: " col)))))
      (test "日本語ΠΜΕ col: 9"
          (show #f (terminal-aware "日本語ΠΜΕ" (fn (col) (each " col: " col)))))
      (test "日本語ΠΜΕ col: 12"
          (show #f (with ((ambiguous-is-wide? #t))
                     (terminal-aware "日本語ΠΜΕ"
                                     (fn (col) (each " col: " col))))))
      (test "ａｂｃ" (substring-terminal-width "ａｂｃ" 0 6))
      (test "ａｂ" (substring-terminal-width "ａｂｃ" 0 4))
      (test "ｂｃ" (substring-terminal-width "ａｂｃ" 2 6))
      (test "ａｂ" (substring-terminal-width "ａｂｃ" 1 4))
      (test "ａｂ" (substring-terminal-width "ａｂｃ" 1 5))
      (test "ｂ" (substring-terminal-width "ａｂｃ" 2 4))
      (test "" (substring-terminal-width "ａｂｃ" 2 3))
      (test "ａ" (substring-terminal-width "ａｂｃ" -1 2))

      (test-end))))
|#

;;
;; ---- SRFI 207: String-notated bytevectors ----
;;

(import (srfi 207))

(check-equal #u8(65 66 67 68) #u8"ABCD")
(check-equal #u8(#x9 #x41 #x72 #x74 #x68 #x75 #x72 #xa) #u8"\tArthur\n")
(check-equal #u8(#x41 #x42 #x3d #x1f #x0d #x43 #x44) #u8"AB\x3d;\x1f;\x0d;CD")

(define (check-read-bytestring s)
    (bytestring-error?
        (guard (o (else o))
            (let ((port (open-input-string s)))
                (read port)))))

(check-equal #t (check-read-bytestring "#u8\"\\x100;\""))
(check-equal #t (check-read-bytestring "#u8\"\\x0ABC\""))
(check-equal #t (check-read-bytestring "#u8\"\\xE000;\""))
(check-equal #t (check-read-bytestring "#u8\"\\x80;\""))

(check-equal #u8(108 111 114 101 109) (bytestring "lo" #\r #x65 #u8(#x6d)))
(check-equal #t (equal? (bytestring) (bytevector)))

(check-equal #u8(0 97 98 99 127 0 255 0 127) (make-bytestring '("\x0;abc\x7f;" 0 255 #\x0 #\x7F)))

(define (check-make-bytestring . args)
    (bytestring-error? (guard (o (else o)) (make-bytestring args))))

(check-equal #t (check-make-bytestring "abc" #x100 "efg"))
(check-equal #t (check-make-bytestring "abc\x3BB;efg"))
(check-equal #t (check-make-bytestring "abc" -1 "efg"))
(check-equal #t (check-make-bytestring "abc" 256 "efg"))
(check-equal #t (check-make-bytestring "abc" #\x80 "efg"))
(check-equal #f (check-make-bytestring "abc" #\x10 "efg"))

(check-equal #t (check-make-bytestring "\x3BB;"))
(check-equal #t (check-make-bytestring #x100))

(check-equal #u8(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
    (make-bytestring '(#u8(0 1 2 3) #\x4 5 6 7 "\x8;\x9;\xa;" #u8(11 12) 13 14 #\xF #\x10)))

(check-equal #u8(113 114 115 116 117 118 119 120 121 122 123 124 125 126 127)
    (bytestring #u8(113 114 115 116) 117 #\x76 #\x77 "xyz{|}~" 127))

(check-equal #u8"lorem"
    (let ((bv (make-bytevector 5)))
        (make-bytestring! bv 0 '(#x6c #x6f #x72 #x65 #x6d))
        bv))

(check-equal #u8"  lorem  "
    (let ((bv (make-bytevector 9 #x20)))
        (make-bytestring! bv 2 '("lo" #\r #x65 #u8(#x6d)))
        bv))

(check-equal #u8"  scheme  "
    (let ((bv (make-bytevector 10 #x20)))
        (make-bytestring! bv 2 '(#\s #\c "he" #u8(#x6d #x65)))
        bv))

(check-equal #u8(#x46 #x6f #x72 #x64) #u8"Ford")
(check-equal "466f7264" (bytevector->hex-string #u8"Ford"))
(check-equal #u8"Zaphod" (hex-string->bytevector "5a6170686f64"))

(check-equal "6c6f72656d" (bytevector->hex-string #u8"lorem"))
(check-equal #u8"lorem" (hex-string->bytevector "6c6f72656d"))
(check-equal #t
    (bytestring-error? (guard (o (else o)) (hex-string->bytevector "c6f72656d"))))
(check-equal #t
    (bytestring-error? (guard (o (else o)) (hex-string->bytevector "6czf72656d"))))

(define homer
    (bytestring "The Man, O Muse, informe, who many a way / \
                 Wound in his wisedome to his wished stay;"))

(define homer64
    "VGhlIE1hbiwgTyBNdXNlLCBpbmZvcm1lLCB3aG8gbWFueSBhIHdheSAvIFdvd\
     W5kIGluIGhpcyB3aXNlZG9tZSB0byBoaXMgd2lzaGVkIHN0YXk7")

(define homer64-w
    "VGhlIE1hb iwgTyBNdXNlL CBpbmZvcm1lL\nCB3aG8gbWF\tueSBhIH\rdheSAvIFdvd\
     W5kIGluI   GhpcyB    3aXNlZ\t\t\nG9tZSB0b    yBoaXMgd\t2lzaGVkIHN0YXk7")

(check-equal #t
    (equal? (hex-string->bytevector (bytevector->hex-string homer)) homer))
(check-equal #u8() (hex-string->bytevector (bytevector->hex-string #u8())))

(check-equal "bG9yZW0=" (bytevector->base64 (bytestring "lorem")))
(check-equal "/+//" (bytevector->base64 #u8(#xff #xef #xff)))
(check-equal "@*@@" (bytevector->base64 #u8(#xff #xef #xff) "*@"))
(check-equal #t (equal? (bytevector->base64 homer) homer64))
(check-equal "AQ==" (bytevector->base64 #u8(1)))
(check-equal "" (bytevector->base64 #u8()))
(check-equal #u8"lorem" (base64->bytevector "bG9yZW0="))
(check-equal #u8(#xff #xef #xff) (base64->bytevector "/+//"))
(check-equal #u8(#xff #xef #xff) (base64->bytevector "@*@@" "*@"))
(check-equal #t (equal? (base64->bytevector homer64) homer))
(check-equal #t (equal? (base64->bytevector homer64-w) homer))
(check-equal #u8(1) (base64->bytevector "AQ=="))
(check-equal #u8() (base64->bytevector ""))
;(check-equal #u8() (base64->bytevector "\n\n\n==\t\r\n"))

(check-equal "AQIDBAUG" (bytevector->base64 #u8(1 2 3 4 5 6)))
(check-equal "QXJ0aHVyIERlbnQ=" (bytevector->base64 #u8"Arthur Dent"))
(check-equal #u8(#xfb #xff #xfe) (base64->bytevector "+/     /+"))

(check-equal #t
    (bytestring-error? (guard (o (else o)) (base64->bytevector "bG9@frob"))))

(check-equal "" (bytevector->base64 #u8""))
(check-equal "Zg==" (bytevector->base64 #u8"f"))
(check-equal "Zm8=" (bytevector->base64 #u8"fo"))
(check-equal "Zm9v" (bytevector->base64 #u8"foo"))
(check-equal "Zm9vYg==" (bytevector->base64 #u8"foob"))
(check-equal "Zm9vYmE=" (bytevector->base64 #u8"fooba"))
(check-equal "Zm9vYmFy" (bytevector->base64 #u8"foobar"))

(check-equal #u8"" (base64->bytevector ""))
(check-equal #u8"f" (base64->bytevector "Zg = ="))
(check-equal #u8"fo" (base64->bytevector "Zm 8="))
(check-equal #u8"foo" (base64->bytevector "  Zm9v"))
(check-equal #u8"foob" (base64->bytevector "Zm9vYg  =="))
(check-equal #u8"fooba" (base64->bytevector "Zm9vYmE=  "))
(check-equal #u8"foobar" (base64->bytevector "Zm  9vYmFy  "))

(check-equal () (bytestring->list #u8()))
(check-equal (#\F #\R 0 #\B) (bytestring->list (bytestring 70 82 0 66)))
(check-equal (7 9 9 10 200) (bytestring->list (bytestring "\a\t\t\n" 200)))
(check-equal #u8"lorem" (make-bytestring (bytestring->list #u8"lorem")))
(check-equal #u8"rem" (make-bytestring (bytestring->list #u8"lorem" 2)))
(check-equal #u8"or" (make-bytestring (bytestring->list #u8"lorem" 1 3)))

(define (generator->list gen)
    (define (generate gen lst)
        (let ((val (gen)))
            (if (eof-object? val)
                (reverse lst)
                (generate gen (cons val lst)))))
    (generate gen '()))
(check-equal (#x6c #x6f #x72 #x65 #x6d)
    (let ((g (make-bytestring-generator "lo" #\r #x65 #u8(#x6d))))
        (generator->list g)))
(check-equal #t
    (bytestring-error? (guard (o (else o)) (make-bytestring-generator "abc\x3BB;efg" #\m #\u))))
(check-equal #t
    (bytestring-error? (guard (o (else o)) (make-bytestring-generator 89 90 300))))
#|
(define test-bstring (bytestring "lorem"))


(define (check-selection)
  (print-header "Running selection tests...")

  (check (bytestring-pad #u8"lorem" (bytevector-length #u8"lorem") #x7a)
   => #u8"lorem")
  (check (utf8->string (bytestring-pad #u8"lorem" 8 #x7a))
   => "zzzlorem")
  (check (equal? (bytestring-pad #u8"lorem" 8 #\z)
                 (bytestring-pad #u8"lorem" 8 (char->integer #\z)))
   => #t)
  (check (bytestring-pad-right #u8"lorem"
                               (bytevector-length #u8"lorem")
                               #x7a)
   => #u8"lorem")
  (check (utf8->string (bytestring-pad-right #u8"lorem" 8 #x7a))
   => "loremzzz")
  (check (equal? (bytestring-pad-right #u8"lorem" 8 #\z)
                 (bytestring-pad-right #u8"lorem" 8 (char->integer #\z)))
   => #t)

  (check (bytestring-trim #u8"lorem" always) => #u8())
  (check (bytestring-trim #u8"lorem" never)  => #u8"lorem")
  (check (bytestring-trim #u8"lorem" (lambda (u8) (< u8 #x70)))
   => #u8(#x72 #x65 #x6d))
  (check (bytestring-trim-right #u8"lorem" always) => #u8())
  (check (bytestring-trim-right #u8"lorem" never)  => #u8"lorem")
  (check (bytestring-trim-right #u8"lorem" (lambda (u8) (< u8 #x70)))
   => #u8(#x6c #x6f #x72))
  (check (bytestring-trim-both #u8"lorem" always) => #u8())
  (check (bytestring-trim-both #u8"lorem" never)  => #u8"lorem")
  (check (bytestring-trim-both #u8"lorem" (lambda (u8) (< u8 #x70)))
   => #u8(#x72)))

(define (check-replacement)
  (print-header "Running bytestring-replace tests...")

  (check (bytestring-replace #u8"lorem" (bytestring "mists") 1 5 1 5)
   => (bytestring "lists"))
  (check (bytestring-replace #u8"lorem" (bytestring "faded") 2 5 1 5)
   => (bytestring "loaded"))
  (check (bytestring-replace (make-bytevector 5)
                             #u8"lorem"
                             0
                             (bytevector-length #u8"lorem"))
   => #u8"lorem")

  (let ((bv1 (bytestring "food")) (bv2 (bytestring "od fo")))
    (check (bytestring-replace bv1 bv2 2 2 0 5) => (bytestring "food food")))
  (let ((bv1 (bytestring "food food")))
    (check (bytestring-replace bv1 (bytevector) 2 7 0 0)
     => (bytestring "food")))
)

(define (check-comparison)
  (define short-bstring (bytestring "lore"))
  (define long-bstring (bytestring "lorem "))
  (define mixed-case-bstring (bytestring "loreM"))
  (print-header "Runnng comparison tests...")

  (check (bytestring<? #u8"lorem" #u8"lorem")        => #f)
  (check (bytestring<? short-bstring #u8"lorem")       => #t)
  (check (bytestring<? mixed-case-bstring #u8"lorem")  => #t)
  (check (bytestring>? #u8"lorem" #u8"lorem")        => #f)
  (check (bytestring>? #u8"lorem" short-bstring)       => #t)
  (check (bytestring>? #u8"lorem" mixed-case-bstring)  => #t)
  (check (bytestring<=? #u8"lorem" #u8"lorem")       => #t)
  (check (bytestring<=? short-bstring #u8"lorem")      => #t)
  (check (bytestring<=? mixed-case-bstring #u8"lorem") => #t)
  (check (bytestring<=? #u8"lorem" mixed-case-bstring) => #f)
  (check (bytestring<=? long-bstring #u8"lorem")       => #f)
  (check (bytestring>=? #u8"lorem" #u8"lorem")       => #t)
  (check (bytestring>=? #u8"lorem" short-bstring)      => #t)
  (check (bytestring>=? #u8"lorem" mixed-case-bstring) => #t)
  (check (bytestring>=? mixed-case-bstring #u8"lorem") => #f)
  (check (bytestring>=? short-bstring #u8"lorem")      => #f)
)

(define (check-searching)
  (define (eq-r? b) (= b #x72))
  (define (lt-r? b) (< b #x72))
  (print-header "Running search tests...")

  (check (bytestring-index #u8"lorem" always)     => 0)
  (check (bytestring-index #u8"lorem" never)      => #f)
  (check (bytestring-index #u8"lorem" always 3)   => 3)
  (check (bytestring-index #u8"lorem" eq-r?) => 2)

  (check (bytestring-index-right #u8"lorem" always)     => 4)
  (check (bytestring-index-right #u8"lorem" never)      => #f)
  (check (bytestring-index-right #u8"lorem" always 3)   => 4)
  (check (bytestring-index-right #u8"lorem" eq-r?) => 2)

  (check (values~>list (bytestring-span #u8"lorem" always))
   => (list #u8"lorem" (bytevector)))
  (check (values~>list (bytestring-span #u8"lorem" never))
   => (list (bytevector) #u8"lorem"))
  (check (values~>list (bytestring-span #u8"lorem" lt-r?))
   => (list (bytestring "lo") (bytestring "rem")))

  (check (values~>list (bytestring-break #u8"lorem" always))
   => (list (bytevector) #u8"lorem"))
  (check (values~>list (bytestring-break #u8"lorem" never))
   => (list #u8"lorem" (bytevector)))
  (check (values~>list (bytestring-break #u8"lorem" eq-r?))
   => (list (bytestring "lo") (bytestring "rem"))))

(define (check-join-and-split)
  (define test-segments '(#u8(1) #u8(2) #u8(3)))
  (print-header "Running joining and splitting tests...")

  (check (bytestring-join test-segments #u8(0))         => #u8(1 0 2 0 3))
  (check (bytestring-join test-segments #u8(0) 'prefix) => #u8(0 1 0 2 0 3))
  (check (bytestring-join test-segments #u8(0) 'suffix) => #u8(1 0 2 0 3 0))
  (check (bytestring-join '() #u8(0))                   => #u8())
  (check (bytestring-join test-segments #\space)        => #u8(1 32 2 32 3))
  (check (bytestring-join test-segments 0)              => #u8(1 0 2 0 3))
  (check (bytestring-join test-segments "AB")
   => #u8(1 65 66 2 65 66 3))
  (check (bytestring-join test-segments #u8(7 8))       => #u8(1 7 8 2 7 8 3))
  (check (catch-bytestring-error
          (bytestring-join test-segments 300))          => 'bytestring-error)
  (check (catch-bytestring-error
          (bytestring-join test-segments "λ"))          => 'bytestring-error)
  (check (catch-bytestring-error
           (bytestring-join '() #u8(0) 'strict-infix))  => 'bytestring-error)
  (check (catch-bytestring-error
           (bytestring-join '() #u8(0) 'foofix))        => 'bytestring-error)

  (check (bytestring-split #u8(1 0 2 0 3) 0 'infix)    => test-segments)
  (check (bytestring-split #u8(0 1 0 2 0 3) 0 'prefix) => test-segments)
  (check (bytestring-split #u8(1 0 2 0 3 0) 0 'suffix) => test-segments)
  (check (bytestring-split #u8(0 0) 0)                 => '(#u8() #u8() #u8()))
  (check (bytestring-split #u8() 0)                    => '())
  (check (catch-bytestring-error
           (bytestring-split #u8() 0 'foofix))         => 'bytestring-error))

(define (check-io)
  (print-header "Running I/O tests...")

  (check (%bytestring/IO "lo" #\r #x65 #u8(#x6d)) => #u8"lorem")
  (check (%bytestring/IO) => #u8())
  (check (catch-bytestring-error (%bytestring/IO #x100)) => 'bytestring-error)
  (check (catch-bytestring-error (%bytestring/IO "λ")) => 'bytestring-error)

  ;;; read-textual-bytestring

  (check (parse-SNB/prefix "#u8\"\"") => #u8())
  (check (parse-SNB/prefix "#u8\"lorem\"") => #u8"lorem")
  (check (parse-SNB/prefix "#u8\"\\xde;\\xad;\\xf0;\\x0d;\"")
   => (bytevector #xde #xad #xf0 #x0d))
  (check (parse-SNB/prefix "#u8\"\\\"\\\\\\a\\b\\t\\n\\r\\\|\"")
   => (bytestring #\" #\\ #\alarm #\backspace #\tab #\newline #\return #\|))
  (check (parse-SNB/prefix "#u8\"lor\\\n\te\\   \r\n\tm\"")
   => #u8"lorem")
  (check (parse-SNB "\"lorem\"") => #u8"lorem")

  ;; Invalid SNB detection.
  (check (catch-bytestring-error (parse-SNB/prefix "#u\"lorem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8lorem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"lorem"))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"lorem"))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"l\\orem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"l\\    orem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"l\\x6frem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"l\\x6z;rem\""))
   => 'bytestring-error)
  (check (catch-bytestring-error (parse-SNB/prefix "#u8\"α equivalence\""))
   => 'bytestring-error)

  ;;; write-textual-bytestring

  (check (%bytestring->SNB #u8()) => "#u8\"\"")
  (check (%bytestring->SNB #u8"lorem") => "#u8\"lorem\"")
  (check (%bytestring->SNB (bytevector #xde #xad #xbe #xef))
   => "#u8\"\\xde;\\xad;\\xbe;\\xef;\"")
  (check (%bytestring->SNB
          (bytestring #\" #\\ #\alarm #\backspace #\tab #\newline #\return #\|))
   => "#u8\"\\\"\\\\\\a\\b\\t\\n\\r\\\|\"")

  (let ((#u8"lorem"s
         '(#u8(124 199 173 212 209 232 249 16 198 32 123 111 130 92 64 155)
           #u8(50 133 193 27 177 105 10 186 61 149 177 105 96 70 223 190)
           #u8(0 117 226 155 110 0 66 216 27 129 187 81 17 210 71 152)
           #u8(123 31 159 25 100 135 246 47 249 137 243 241 45 241 240 221)
           #u8(207 186 70 110 118 231 79 195 153 253 93 101 126 198 70 235)
           #u8(138 176 92 152 208 107 28 236 198 254 111 37 241 116 191 206)
           #u8(221 254 214 90 0 155 132 92 157 246 199 224 224 142 91 114)
           #u8(228 216 233 80 142 15 158 54 5 85 174 101 111 75 126 209)
           #u8(191 16 83 245 45 98 72 212 148 202 135 19 213 150 141 121)
           #u8(41 169 182 96 47 184 16 116 196 251 243 93 81 162 175 140)
           #u8(85 49 218 138 132 11 27 11 182 27 120 71 254 169 132 166)
           #u8(89 216 175 23 97 10 237 112 208 195 112 80 198 154 241 254)
           #u8(187 54 6 57 250 137 129 89 188 19 225 217 168 178 174 129)
           #u8(88 164 89 40 175 194 108 56 12 124 109 96 148 149 119 109)
           #u8(241 66 32 115 203 71 128 154 240 111 194 137 73 44 146 3)
           #u8(177 185 177 233 18 14 178 106 110 109 222 147 111 157 216 208))))
    (check
     (every (lambda (bvec)
              (equal? bvec (parse-SNB/prefix (%bytestring->SNB bvec))))
            #u8"lorem"s)
    => #t))
)
|#
