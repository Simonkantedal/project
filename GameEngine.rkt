#lang racket/gui

(require racket/math)

(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)

    (define/override (on-paint)
      (begin
        (display "repaint job\n")))

    (define angle 0)
    (define velocity 2)
    (define direction (cons 1 0))

    (define/override (on-event event)
      (case (send event get-event-type)
        [(right-down) ;enter leave
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

(define refresh-tick 
  (lambda ()
    (refresh-tickk 10 (list '(300 . 300) 
                            '(295 . 300)
                            '(290 . 300) ;; starting snake
                            '(285 . 300) ;; coordinates...
                            '(280 . 300) 
                            '(275 . 300)
                            '(270 . 300))
                  (cons (* 20 (random 30)) (* 20 (random 40)))
                  0)))

(define draw-snake
  (lambda (ls)
    (if (or (null?  (cdr ls)) (void? ls))
        '()

        (let* ((location (car ls))
               (x (car location))
               (y (if (list? (cdr location))
                      (car (cdr location))
                      (cdr location))))
          (begin
            (send dc draw-rectangle x y  6 6)
            (draw-snake (cdr ls)))))))

(define refresh-tickk 
  (lambda (num snake food score)
      (begin
        (sleep 0.1)
        (send dc set-brush "black" 'solid)
        (send dc set-pen "black" 0 'solid)
        (send dc draw-rectangle 0 0 650 800)
        (send dc set-brush "blue" 'solid)        
        (draw-snake snake)
        (send dc set-brush "yellow" 'solid) 
        (send dc draw-rectangle (car food) (cdr food)  20 20)
        (refresh-tickk 0 snake
                             (cons 20 20)
                             (+ 1 score)))))

(define update-snake
  (lambda (snake direction food)
    (let* ((head (car snake))
           (x (cond ((> (car head) 600) 0)
                    ((< (car head) 20) 600)
                    (else (car head))))
           (pre-y (if (list? (cdr head))
                  (cadr head)
                  (cdr head)))
           (y (cond ((> pre-y 730) 0)
                    ((< pre-y 0) 730)
                    (else pre-y))))
      (if (not food )

          (cond 
            ((null? snake) '())
            ((equal? direction "l")
             (cons (cons (- x 20) y) 
                   (without-end snake)))
            ((equal? direction "r")
             (cons (cons (+ x 20) y) 
                   (without-end snake)))
            ((equal? direction "u")
             (cons (cons x (- y 20)) 
                   (without-end snake)))
            ((equal? direction "d")
             (cons (cons  x (+ y 20) )
                   (without-end snake))))

          (cond 
            ((null? snake) '())
            ((equal? direction "l")
             (cons (cons (- x 20) y) 
                   snake))
            ((equal? direction "r")
             (cons (cons (+ x 20) y) 
                   snake))
            ((equal? direction "u")
             (cons (cons x (- y 20)) 
                   snake))
            ((equal? direction "d")
             (cons (cons  x (+ y 20) )
                   snake)))))))

(define without-end
  (lambda (lst)
    (reverse (cdr (reverse lst)))))

(define game-frame (new frame% (label "Garde la courbe") (width 640) (height 800)))
(define game-canvas (new game-canvas% (parent game-frame)))

(define dc (send game-canvas get-dc))
(send game-frame show #t)

(thread refresh-tick)