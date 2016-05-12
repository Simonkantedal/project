#lang racket/gui

(require "world.rkt")
(provide player%)

(define player%
  (class object%
    (init-field name
                snake
                player-id)
    (field 
     [x (car (car snake))]
     [y (cdr (car snake))]
     [velocity 2]
     [angle 0]
     [direction (cons velocity 0)]
     [steering-radius 0.2]
     [alive #t])
    
    (define/public (get-snake) snake)
    (define/public (get-body) (cdr snake))
    (define/public (get-head) (car snake))
    (define/public (get-x) (car (car snake)))
    (define/public (get-y) (cdr (car snake)))
    (define/public (get-name) name)
    (define/public (get-direction) direction)
    (define/public (is-alive?) alive)

    (define/public (kill)
      (set! alive #f))
    
    (define/public (normalize time)
      (when (equal? (remainder time 100) 0)
        (set! velocity 5)))
    
    (define (turn-left)
      (begin
        (set! angle (- angle steering-radius))
        (let ((x (* velocity (cos angle)))
              (y (* velocity (sin angle))))
          (set! direction (cons x y)))))
    
    (define (turn-right)
      (begin
        (set! angle (+ angle steering-radius))
        (let ((x (* velocity (cos angle)))
              (y (* velocity (sin angle))))
          (set! direction (cons x y)))))
    
    
    (define (steer)
      (let* ((key-events (send game-canvas get-key-events)))
        (begin
          (when
              (equal? (hash-ref key-events (string-append "l" player-id)) #t)
            (turn-left))
          (when
              (equal? (hash-ref key-events (string-append "r" player-id)) #t)
            (turn-right))
          )))
    
    (define/public update
      (lambda (time)
        (let* (
               (head (car snake))
               (x (+ (car direction) (car head)))
               (y (+ (cdr direction) (cdr head))))
              (begin
                (steer)
                (if
                 (equal? (remainder time 5) 0)        
                 (set! snake (cons (cons x y) snake))
                 (set! snake (cons (cons x y) (cdr snake))))))))
    
    
    (super-new)))







