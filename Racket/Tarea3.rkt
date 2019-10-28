#lang racket
#|
Tarea 3
Layla Tame
A0119234
|#

;gcd

(define (gcd a b)
  (cond
    [(= a 0) b]
    [(= b 0) a]
    [else (gcd b (remainder a b))]))

;co-primos

(define (co-primos a b)
  (cond
    [(= (gcd a b) 1) #t]
    [(= (gcd a b) -1) #t]
    [else #f]))

;media, mediana, moda

;sum

(define (sum li)
  (if (empty? li) 0
      (+ (car li) (sum (rest li)))))

(define (sortFun li)
  (sort li <))

; nth -> Acceder el n elemento de una lista

(define (nth li n)
  (cond
    [(empty? li) (display "meh")]
    [(= n 0) (car li)]
    [else (nth (cdr li) (- n 1))]))

(define (median li)
  (cond
    [(= 0 (modulo (length li) 2)) (/ (+ (nth li (/ (length li) 2)) (nth li (- (/ (length li) 2) 1))) 2)]
    [else (nth li (quotient (length li) 2))]))

(define (count item li)
  (cond
    [(null? li) 0]
    [(= item (car li)) (+ 1 (count item (cdr li)))]
    [else (count item (cdr li))]))

(define (numItems li)
  (if (empty? li) '()
      (cons (count (car li) li) (numItems (cdr li)))))

(define (max li)
(cond [(null? li) (error "LoL")]
      [(null? (cdr li)) (car li)]
      [else (if (> (car li) (max (cdr li)))
                (car li)
                (max (cdr li)))]))


(define (index-of li ele)
  (let loop ((li li)
             (idx 0))
    (cond ((empty? li) #f)
          ((equal? (first li) ele) idx)
          (else (loop (rest li) (add1 idx))))))

(define (mode li)
  (nth li (index-of (numItems li) (max (numItems li)))))


(define (medmod li)
  (cond
    [(empty? li) '()]
    [else (list (/ (sum li) (length li)) (median (sortFun li)) (mode li))]))


;rango

(define (rango n m)
   (if (> n m) '()
       (cons n (rango (+ n 1) m))))


;cuenta átomos aux

(define (cuentaAux li)
  (if (empty? li) 0
        (+ 1 (cuentaAux(cdr li)))))


;cuenta átomos

(define (cuenta-atomos li)
  (cond [(empty? li) 0]
        [(list? (car li)) (+ (cuenta-atomos (car li)) (cuenta-atomos (cdr li)))]
        [else (+ 1 (cuenta-atomos (cdr li)))]))
                          

;toma

(define (toma n li)
  (cond [(empty? li) '()]
        [(= n 0) '()]
        [else (cons (car li) (toma (- n 1) (cdr li)))]))

;deja

(define (deja n li)
  (cond [(empty? li) '()]
        [(> n 0) (deja (- n 1) (cdr li))]
        [else li]))


;split

(define (split li p)
  (cond [(empty? li) (list '() '())]
        [(< (length li) p) (display "meh")]
        [else (display "lista ") (list (toma (- p 1) li) (deja p li))]))

