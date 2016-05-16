#lang racket/gui
(require racket/math)
(require "world.rkt")
(require "GameEngine.rkt")
(require "PlayerClass.rkt")
(provide startwindow)

;Startskärmen för huvudmenyn
(define startwindow
  (new frame%
       [label "Startscreen Garde La Courbe"]
       [width 650]
       [height 800]))

;Bitmap med header till menyfönstret
(define *our-bitmap* (make-object bitmap% "Bild.png"))

;Ritar upp bilden 
(define (our-draw canvas dc)
  (send dc draw-bitmap *our-bitmap* 0 0))

;Canvasen på menyfönstret
(define start-screen
  (new canvas%
       [parent startwindow]
       [paint-callback our-draw]))

;visar menyfönstret
(send startwindow show #t)

;Panel i menyfönstret 
(define panel (new group-box-panel%
                   [label "Meny"]
                   [parent startwindow]
                   [alignment '(right center)]))
;Panel i Menyfönstret
(define subpanel (new group-box-panel%
                      [label " "]
                      [parent panel]
                      [alignment '(left center)]))
;Info-ruta till spelet
(define infoframe (new frame%
                       [label "Help"]
                       [width 500]
                       [height 200]))
;Visar info-rutan vi knapptryck på knappen "info"
(define (info a b)
  (send infoframe show #t))
(new button%
     [label "Help"]
     [parent panel]
     [callback info])

;Godtycklig knapp utan funktion
(new button%
     [label "hej"]
     [parent panel]
     [callback info])
;Vad som sker vid knapptryck av "One Snake"
(define (one-player a b)
  (send (car snake-list) include)
  (send one-snake set-label "You have chosen one player, start game!  ")
  (send a set-label "Marked")
  (send playerwindow show #f)
  (send (cadr snake-list) kill)
  (send (caddr snake-list) kill)
  (send twosnake set-label "Two Snakes")
  (send threesnake set-label "Three Snakes")
  (send two-snakes set-label "Press to play with two Snakes                     ")
  (send three-snakes set-label "Press to play with three Snakes                     "))

;Vad som sker vid knapptryck av "Two Snakes"
(define (two-players a b)
  (send (car snake-list) include)
  (send (cadr snake-list) include)
  (send two-snakes set-label "You have chosen two players, start game!  ")
  (send a set-label "Marked")
  (send playerwindow show #f)
  (send (caddr snake-list) kill)
  (send onesnake set-label "One Snake")
  (send threesnake set-label "Three Snakes")
  (send one-snake set-label "Press to play with one Snake                     ")
  (send three-snakes set-label "Press to play with three Snakes                     "))
;Vad som sker vid knapptryck av "Three Snakes"
(define (three-players a b)
  (send (car snake-list) include)
  (send (cadr snake-list) include)
  (send (caddr snake-list) include)
  (send three-snakes set-label "You have chosen three players, start game!  ")
  (send a set-label "Marked")
  (send playerwindow show #f)
  (send onesnake set-label "One Snake")
  (send twosnake set-label "Two Snakes")
  (send one-snake set-label "Press to play with one Snake                     ")
  (send two-snakes set-label "Press to play with two Snakes                     "))

;Ökar hastigheten på ormen
(define (higher a b)
  (when (not (null? snake-list))
    (begin
      (send (car snake-list) higher-speed)
      (higher (cdr snake-list)))))
;Errorfönster när man inte valt antal spelare
(define playerwindow (new frame%
                          [label "Choose number of players"]
                          [width 100]
                          [height 100]))

;Vad som sker vid knapp-tryck av "Start"-knappen
(define (buttproc butt on)
  (if (equal? (send (car snake-list) show?) #t)
  ((send game-frame show #t)
  (send game-canvas show #t)
  (send startwindow show #f)
  (send infoframe show #f)
  (start)
  (send game-canvas focus))
  (send playerwindow show #t)))

;Error meddelandet som kommer upp vid knapptrycket
(define errormsg (new message%
                      [label "You have to choose the number of players to start the game    "] [parent playerwindow]))

;Text som berättar vad man gör vid knapptrycket
(define startbutton (new message% [label "        Press to start game        "] [parent startwindow]))
;knappfunktionen
(define our-utton (new button%
     [label "start"]
     [parent startwindow]
     [callback buttproc]))

;Infotext
(define one-playersteering (new message% [label "You control the first snake with right-key and left-key, the second snake with Q and W, and the third snake with V and B          "] [parent infoframe]))

;infotext om vad som händer när du trycker på knappen
(define one-snake (new message% [label "Press to play with one Snake                           "] [parent subpanel]))
;Knapp för en orm
(define onesnake (new button%
     [label "One Snake"]
     [parent subpanel]
     [callback one-player]))
;infotext om vad som händer när du trycker på knappen
(define two-snakes (new message% [label "Press to play with two Snakes                     "] [parent subpanel]))
;Knapp för två ormar
(define twosnake (new button%
     [label "Two Snakes"]
     [parent subpanel]
     [callback two-players]))
;infotext om vad som händer när du trycker på knappen
(define three-snakes (new message% [label "Press to play with three Snakes                      "] [parent subpanel]))
;Knapp för tre ormar
(define threesnake (new button%
     [label "Three Snakes"]
     [parent subpanel]
     [callback three-players]))

;Knapp för att öka hastigheten
(define speed (new message%  [label "Speed: ~a "] [parent subpanel]))
(new button%
     [label "Higher speed"]
     [parent subpanel]
     [callback higher])

;Score
(define scoreboard (new message% [label "Score: "] [parent game-frame]))



