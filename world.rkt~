#lang racket/gui

(require racket/math)
(provide game-canvas%)
(provide game-frame)
(provide game-canvas)
(require "PlayerClass.rkt")



(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)
    
    (define/override (on-paint)
      (begin
        (display "repaint job\n")))
    
    ;(define angle 0)
    ;(define velocity 4)
    ;(define steering-radius 0.2)
    ;(define direction (cons velocity 0))
    
    (define/public (get-direction) (send *player1* get-direction))
    
    (define/override (on-char ke)
      (case (send ke get-key-code)
        [(left)
         (send *player1* turn-left)]
        [(right)
         (send *player1* turn-right)]
        [(shift)
         (send *player2* turn-left)]
        [(control)
         (send *player2* turn-right)]
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

(define game-bitmap (make-object bitmap% 100 100))
; Dimensionerna sätts till argumenten, här 100 x 100!
; Hämta DC för bitmapen så att vi kan måla precis som på canvasen!
(define bitmap-dc (new bitmap-dc% [bitmap game-bitmap]))
; Ritar ut en bitmap med någon dc, t.ex. på en canvas!
(send bitmap-dc draw-bitmap game-bitmap
      0
      600)

(new button%
     [label "knapp"]
     [parent game-frame])
(define (button-rpoc button event)
  (send button set-label "klick fungerade"))