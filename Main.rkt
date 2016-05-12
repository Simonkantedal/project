#lang racket/gui
(require racket/math)
(require "world.rkt")
(require "GameEngine.rkt")
(provide startwindow)

(define startwindow
  (new frame%
       [label "Startscreen Garde La Courbe"]
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
                      [label " "]
                      [parent panel]
                      [alignment '(left center)]))

(define infoframe (new frame%
                       [label "Help"]
                       [width 500]
                       [height 200]))
(define (wind a b)
(send infoframe show #t))
(new button%
     [label "Help"]
     [parent panel]
     [callback wind])

(new button%
     [label "hej"]
     [parent panel]
     [callback wind)

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
(define one-player (new message% [label "Press to play with one Snake "] [parent subpanel]))
(new button%
     [label "One Snake"]
     [parent subpanel])
(define two-player (new message% [label "Press to play with two Snakes "] [parent subpanel]))

(new button%
     [label "Two Snakes"]
     [parent subpanel])
(define three-player (new message% [label "Press to play with three Snakes "] [parent subpanel]))
(new button%
     [label "Three Snakes"]
     [parent subpanel])

(define scoreboard (new message% [label "Score: "] [parent game-frame]))


       
