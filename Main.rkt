#lang racket/gui
(require racket/math)
(require "world.rkt")
(require "GameEngine.rkt")
(provide startwindow)

(define startwindow
  (new frame%
       [label "startscreen Garde la courbe"]
       [width 650]
       [height 800]))


(define *our-bitmap* (make-object bitmap% "Bild.png"))

(define (our-draw canvas dc)
  (send dc draw-bitmap *our-bitmap* 0 0))

(define start-screen
  (new canvas%
       [parent startwindow]
       [paint-callback our-draw]))

(send startwindow show #t)


(define panel (new panel%	 
                   [parent startwindow]
                   [style '(border)]
                   [alignment '(right center)]))
(define panel1 (new panel%
                    [parent startwindow]
                    [style '(border)]
                    [alignment '(left center)]))

(new button%
     [label "pause"]
     [parent game-frame])

(define (buttproc butt on)
 (send game-frame show #t)
  (send game-canvas show #t)
  (send startwindow show #f)
  (start)) 
(new button%
     [label "start"]
     [parent startwindow]
     [callback buttproc])

(define one-player (new message% [label "For one Player"] [parent panel]))
(new button%
     [label "One Player"]
     [parent panel])
(new button%
     [label "Two Players"]
     [parent panel1])

(define scoreboard (new message% [label "Score: "] [parent game-frame]))


       
