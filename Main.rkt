#lang racket/gui
(require racket/math)
(require "world.rkt")
(provide start-screen%)

(define start-screen%
  (class canvas%
    (inherit get-width get-height refresh)
    (