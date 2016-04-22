#lang racket/gui

(require racket/math)
(provide game-canvas%)
(provide game-frame)
(provide game-canvas)



(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)
    
    (define/override (on-paint)
      (begin
        (display "repaint job\n")))
    
    (define angle 0)
    (define velocity 2)
    (define steering-radius 0.2)
    (define direction (cons velocity 0))
    
    (define/public (get-direction) direction)
    
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
           (writeln angle)
           (let ((x (* velocity (cos angle)))
                 (y (* velocity (sin angle))))
             (set! direction (cons x y))))]
        [(right)
         (begin
           (set! angle (+ angle steering-radius))
           (writeln angle)
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

(define game-frame (new frame% (label "Garde la courbe") (width 600) (height 800)))
(define game-canvas (new game-canvas% (parent game-frame)))