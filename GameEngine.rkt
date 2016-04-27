#lang racket/gui

(require racket/math)
(require "world.rkt")


(define check-range
  (lambda (num low high)
    (if
      (and (>= num low) (<= num high))
      #t
      #f)))

(define refresh
  (lambda ()
    (refresher 10 (list '(330 . 300)
                        '(320 . 300)
                        '(300 . 300))
               (cons (* 20 (random 30)) (* 20 (random 40)))
               0
               0)))

(define draw-snake
  (lambda (ls)
    (if (or (void? ls) (null?  (cdr ls)))
        '()
        (let* (
               (location-head (first ls))
               (location-second (first (cdr ls)))
               (x (car location-head))
               (y (cdr location-head))
               (x_next (car location-second))
               (y_next (cdr location-second))
               (generator 10))
          (begin
            (send dc set-pen "yellow" 10 'solid)
            (set! generator (random 10))
            (send dc draw-line x y x_next y_next)
            (when (not (null? (cdr ls)))
              (draw-snake (cdr ls))))))))

(define refresher 
  (lambda (num snake food score time)
    (begin
      (sleep 0.05)
      (send dc set-brush "black" 'solid)
      (send dc set-pen "black" 0 'solid)
      (send dc draw-rectangle 0 0 650 800)
      (send scoreboard set-label (format "Score: ~A  " score))
      (send dc set-brush "blue" 'solid)        
      (draw-snake snake)
      ;(writeln (cdr (send game-canvas get-direction)))
      ;(write (car snake))
      (send dc set-brush "yellow" 'solid) 
      (send dc draw-ellipse (car food) (cdr food)  20 20)
      (let* (
             (head (car snake))
             (x (+ (car (send game-canvas get-direction)) (car head)))
             (y (+ (cdr (send game-canvas get-direction)) (cdr head))))
        (if (or
             (or (> x 650) (> y 800))
             (or (< x 0) (< y 0)))
            (end-game)
            (begin
              (if
               (equal? (remainder time 5) 0)        
               (set! snake (cons (cons x y) snake))
               (set! snake (cons (cons x y) (cdr snake))))
              (if
               (collide? (cdr snake) (first snake))
               (end-game)
               (refresher 0 snake food score (+ time 1)))))))))


(define collide?
  (lambda (body head)
    (if (null? (cdr body))
        #f
        (let* (
               (x0 (car head))
               (y0 (cdr head))
               (x1 (car (car body)))
               (y1 (cdr (car body)))
               (x2 (car (cadr body)))
               (y2 (cdr (cadr body))))
          ; (begin
          ;(writeln head)
          ;(writeln body)
          ;(writeln x1)
          ;(writeln x2)
          (if 
           (and
            (check-range x0 (min x1 x2) (max x1 x2))
            (check-range y0 (min y1 y2) (max y1 y2)))
           (<= (/ (abs (+ (- (* (- y2 y1) x0) (* (- x2 x1) y0) (* y2 x1)) (* x2 y1))) (sqrt (+ (expt (- y2 y1) 2) (expt (- x2 x1) 2)))) 500)      
           (collide? (cdr body) head))))))



(define end-game
  (lambda ()
    (begin
      (send dc set-brush "red" 'solid)
      (send dc draw-rectangle 0 0 650 800)
      (printf "Game over"))))



(define scoreboard (new message% [label "Score: "] [parent game-frame]))
(define dc (send game-canvas get-dc))
(send game-frame show #t)
(thread refresh)