#lang racket/gui

(require "world.rkt")
(provide player%)
(provide power-up%)

(define power-up%
  (class object%
    [init-field name
                [x (random 650)]
                [y (random 800)]]
    (define/public (get-coordinates)
      (cons x y))
    (define/public (get-x)
      x)
    (define/public (get-y)
      y)
    
    (super-new)))

(define player%
  (class object%
    (init-field name
                snake
                player-id              
                [show #f]
                [alive #t]
                [changed #f])
    (field 
     [x (car (car snake))]
     [y (cdr (car snake))]
     [starting-velocity 2]
     [velocity 3]
     [angle 0]
     [direction (cons velocity 0)]
     [steering-radius 0.2])
    
    (define/public (get-snake) snake) ; gets the whole snake.
    (define/public (get-body) (cdr snake)) ; gets the body of the snake (all coordinate pairs except the first).
    (define/public (get-head) (car snake)) ; gets the head of the snake (the first coordinate pair).
    (define/public (get-x) (car (car snake))) ; gets the x-coordinate of the head.
    (define/public (get-y) (cdr (car snake))) ; gets the y-coordinate of the head.
    (define/public (get-name) name) ; gets the players name.
    (define/public (get-direction) direction) ; gets direction of given snake.
    (define/public (is-alive?) alive) ; parameter that tells if the snake has died or not.
    (define/public (show?) show) ; parameter that decides if the snake is included in the game or not.
    (define/public (get-velocity) velocity) ; gets the snakes velocity.
    (define/public (changed?) changed) ; parameter that shows if the snakes features has changed. i.e if the player is affected by any power-up at the moment.
    
    (define/public (stop)
      (set! velocity 0)
      (set! starting-velocity 0))
    
    ; power-up that changes the speed of the snake.
    (define/public (highspeed)
      (set! velocity (* velocity 3))
      (set! changed #t))
    
    (define/public (low-speed)
      (begin
        (set! velocity 2)
        (set! starting-velocity 2)))
    (define/public (medium-speed)
      (begin
        (set! velocity 4)
        (set! starting-velocity 4)))
    (define/public (high-speed)
      (begin
        (set! velocity 6)
        (set! starting-velocity 6)))
    
    (define/public (include)
      (set! show #t))
    
    (define/public (kill)
      (set! alive #f))
    
    (define/public (normalize)
        (set! velocity starting-velocity)
        (set! steering-radius 0.2))
    
    (define (turn-left)
      (begin
        (set! angle (- angle steering-radius))
        (let ((x (* velocity (cos angle)))
              (y (* velocity (sin angle))))
          (set! direction (cons x y)))))
    
    (define (turn-right)
      (begin
        (set! angle (+ angle steering-radius))
        (let ((x (* velocity (cos angle)))
              (y (* velocity (sin angle))))
          (set! direction (cons x y)))))

    (define (no-turn)
      (begin
        (let ((x (* velocity (cos angle)))
              (y (* velocity (sin angle))))
          (set! direction (cons x y)))))
    
    
    (define (steer)
      (let* ((key-events (send game-canvas get-key-events)))
        (begin
          (cond
            ((equal? (hash-ref key-events (string-append "l" player-id)) #t)
             (turn-left))          
            ((equal? (hash-ref key-events (string-append "r" player-id)) #t)
             (turn-right))
            (else (no-turn))))))
            
      
      (define/public update
        (lambda (time)
          (let* (
                 (head (car snake))
                 (x (+ (car direction) (car head)))
                 (y (+ (cdr direction) (cdr head))))
            (begin
              (steer)
              (if
               (equal? (remainder time 5) 0)        
               (set! snake (cons (cons x y) snake))
               (set! snake (cons (cons x y) (cdr snake))))))))
      
      
      (super-new)))
  
  
  
  
  
  
  
  