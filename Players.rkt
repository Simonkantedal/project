#lang racket/gui
(require racket/math)
(require "PlayerClass.rkt")

(define *player1*
  (new Player%
       [right 'right]
       [left 'left]))
