;;;
;;; Threads
;;;

(import (foment base))
(import (srfi 18))

(define (current-seconds) (time->seconds (current-time)))
(define s (current-seconds))

(thread-sleep! 0)

(check-equal #t (<= s (current-seconds)))

(set! s (current-seconds))

(thread-sleep! 2)

(check-equal #t (< s (current-seconds)))

(thread-sleep! (seconds->time (- (current-seconds) 10)))

(define t (current-time))
(set! s (time->seconds t))

(thread-sleep! (seconds->time (+ s 2)))

(check-equal #t (< s (current-seconds)))

(check-error (assertion-violation thread-sleep!) (thread-sleep!))
(check-error (assertion-violation thread-sleep!) (thread-sleep! #f))

(check-equal #t (thread? (current-thread)))
(check-equal #f (thread? 'thread))

(define result (cons #t #t))

(define thrd (make-thread (lambda () result) 'thread-name))

(check-equal thread-name (thread-name thrd))
(check-equal #t (thread? thrd))

(define specific (cons #f #f))

(thread-specific-set! thrd specific)
(check-equal #t (eq? (thread-specific thrd) specific))

(thread-start! thrd)

(check-equal thread-name (thread-name thrd))
(check-equal #t (thread? thrd))
(check-equal #t (eq? (thread-specific thrd) specific))

(thread-yield!)

(check-equal #t (eq? (thread-join! thrd) result))

(check-equal thread-name (thread-name thrd))
(check-equal #t (thread? thrd))
(check-equal #t (eq? (thread-specific thrd) specific))

(define thrd (thread-start! (make-thread (lambda () (raise specific)))))

(check-equal #t
    (eq? specific
        (guard (obj ((uncaught-exception? obj) (uncaught-exception-reason obj)))
            (thread-join! thrd))))

(define thrd (thread-start! (make-thread (lambda () (thread-sleep! 1) result))))

(check-equal #t (eq? result (thread-join! thrd)))

(define thrd (thread-start! (make-thread (lambda () (thread-sleep! 9999)))))

(thread-terminate! thrd)

(check-equal #t
    (guard (obj ((terminated-thread-exception? obj) #t))
        (thread-join! thrd)))

(define thrd (thread-start! (make-thread (lambda () result))))

(thread-sleep! 1)

(thread-terminate! thrd)

(check-equal #t (eq? result (thread-join! thrd)))

(define thrd (thread-start! (make-thread (lambda () (thread-sleep! 9999)))))

(check-equal #t
    (guard (obj ((join-timeout-exception? obj) #t))
        (thread-join! thrd 1)))

(check-equal #t
    (guard (obj ((join-timeout-exception? obj) #t))
        (thread-join! thrd (seconds->time (+ (time->seconds (current-time)) 1)))))

(check-equal timed-out
    (thread-join! thrd 1 'timed-out))

(check-equal timed-out
    (thread-join! thrd (seconds->time (+ (time->seconds (current-time)) 1)) 'timed-out))

(thread-terminate! thrd)

(check-equal #t
    (guard (obj ((terminated-thread-exception? obj) #t))
        (thread-join! thrd)))
