#lang racket/gui

;(require "PlayerClass.rkt")
(provide *player1*)

(define *player1*
  (new player%
       [name 'simon]))