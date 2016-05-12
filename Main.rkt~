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


(define panel (new group-box-panel%
                   [label "Meny"]
                   [parent startwindow]
                   [alignment '(right center)]))
(define subpanel (new group-box-panel%
                      [label "Antal Spelare"]
                      [parent panel]
                      [alignment '(left center)]))

(define infoframe (new frame%
                       [label "info"]
                       [width 500]
                       [height 200]))
(define (wind a b)
(send infoframe show #t))
(new button%
     [label "info"]
     [parent panel]
     [callback wind])

(new button%
     [label "hej"]
     [parent panel])

(define (buttproc butt on)
 (send game-frame show #t)
  (send game-canvas show #t)
  (send startwindow show #f)
  (send infoframe show #f)
  (start)
(send game-canvas focus)) 
(new button%
     [label "start"]
     [parent startwindow]
     [callback buttproc])


(define one-playersteering (new message% [label "You control the first snake with right-key and left-key, the second snake with Q and W, and the third snake with V and B          "] [parent infoframe]))
(define one-player (new message% [label "For one Player "] [parent subpanel]))
(new button%
     [label "One Player"]
     [parent subpanel])
(define two-player (new message% [label "For two Players "] [parent subpanel]))

(new button%
     [label "Two Players"]
     [parent subpanel])
(define three-player (new message% [label "For three Players "] [parent subpanel]))
(new button%
     [label "Three Players"]
     [parent subpanel])

(define scoreboard (new message% [label "Score: "] [parent game-frame]))


       
