#lang racket/gui

(require racket/math)
(provide game-canvas%)
(provide game-frame)
(provide game-canvas)
(provide dc)



(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)
    (field
     [key-events (make-hash)])
    
    (define/override (on-paint)
      (begin
        (display "repaint job\n")))
    
    (define/public (get-key-events) key-events)
    
    (define/public init
      (lambda ()
        (begin
          (hash-set! key-events "l1" #f)
          (hash-set! key-events "r1" #f)
          (hash-set! key-events "l2" #f)
          (hash-set! key-events "r2" #f)
          )))
    
    (define/public end-game
      (lambda ()
        (begin
          (send dc set-brush "red" 'solid)
          (send dc draw-rectangle 0 0 650 800)
          (printf "Game over")
          )))
    
    
    (define/override (on-char ke)
      (begin
        (writeln (send ke get-key-code))
        (case (send ke get-key-code)
          [(left)
           (hash-set! key-events "l1" #t)]
          [(right)
           (hash-set! key-events "r1" #t)]
          [(#\q)
           (hash-set! key-events "l2" #t)]
          [(#\w)
           (hash-set! key-events "r2" #t)]
          [else (void)])
        (case (send ke get-key-release-code)
          [(left)
           (hash-set! key-events "l1" #f)]
          [(right)
           (hash-set! key-events "r1" #f)]
          [(#\q)
           (hash-set! key-events "l2" #f)]
          [(#\w)
           (hash-set! key-events "r2" #f)]
          [else (void)])))
    
    (define/override (on-event event)
      (case (send event get-event-type)
        [(right-down)
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
(send game-canvas init)
(define dc (send game-canvas get-dc))

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