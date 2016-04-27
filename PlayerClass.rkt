#lang racket/gui
(require racket/math)
(require "world.rkt")
(require "GameEngine.rkt")
(provide Player%)

(define Player%
  (class object%
    (init-field right
                left
                snake)
     
    (define angle 0)
    (define velocity 5)
    (define steering-radius 0.2)
    (define direction (cons velocity 0))

    (define/public (get-direction) direction)

    (define/public (get-right-key) right)
    (define/public (get-left-key) left)
    (define/public (get-head) (car snake))
    (define/public (get-body) (cdr snake))

    (define/override (on-char ke)
      (case (send ke get-key-code)
        [(down)
         (begin
           (void)
           )]
        [(up)
         (begin
           (void))]
        [(left)
         (begin
           (set! angle (- angle steering-radius))
           (let ((x (* velocity (cos angle)))
                 (y (* velocity (sin angle))))
             (set! direction (cons x y))))]
        [(right)
         (begin
           (set! angle (+ angle steering-radius))
           (let ((x (* velocity (cos angle)))
                 (y (* velocity (sin angle))))
             (set! direction (cons x y))))]
        [else (void)]))


   (define/override (on-event event)
      (case (send event get-event-type)
        [(right-down) ;enter leave
         (let (
               (event-name (send event get-event-type))
               (event-x (send event get-x))
               (event-y (send event get-y)))
           (display (list "\n" event-name event-x event-y )))]
        [(left-down)
         (let (
               (event-name (send event get-event-type))
               (event-x (send event get-x))
               (event-y (send event get-y)))
           (display (list "\n" event-name event-x event-y )))]
        [else (void)]))
    
    (super-new)))

   