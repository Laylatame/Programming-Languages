#lang racket

;anidada
;Prubea
;(anidada 3 'hola)
;(anidada 5 3)

(define (anidada n x)
  (cond [(= n 0) '()]
        [(= n 1) (list x)]
        [else (list (anidada (- n 1) x))]))



;max-anidado
;Prueba
;(max-anidado '(('a ('b ('c ('d))))))
;(max-anidado '(('a ('b ('c 'd)))))

(define (max-anidado li)
  (cond [(empty? li) 0]
        [(list? (car li)) (max (+ 1 (max-anidado (car li))) (max-anidado (cdr li)))]
        [else (max-anidado (cdr li))]))



;filtra-anidada
;Prueba
;(filtra-anidada '(1 2 3 4 5 6 7 8) (lambda (x) (< x 5)))
;(filtra-anidada '(1 2 3 4 5 6 7 8) (lambda (x) (> x 5)))


(define (filtra-anidada li p)
  (cond [(empty? li) '()]
        [(list? (car li)) (cons (filtra-anidada (car li) p) (filtra-anidada (cdr li) p))]
        [else (cond [(p (car li)) (cons (car li) (filtra-anidada (cdr li) p))]
                    [else (filtra-anidada (cdr li) p)])]))


;mapa-anidada
;Prueba
;(mapa-anidada add1 '(1 2 3 4))
;(mapa-anidada even? '(1 2 3 4))


(define (mapa-anidada fun li)
  (cond [(empty? li) '()]
        [(list? (car li)) (cons (mapa-anidada fun (car li)) (mapa-anidada fun (cdr li)))]
        [else (cons (fun (car li)) (mapa-anidada fun (cdr li)))]))


;suma-diagonal
;Prueba
;(suma-diagonal '((1 2 3) (4 5 6) (7 8 9)))
;(suma-diagonal '((1 2 3 13) (4 5 6 14) (7 8 9 15) (10 11 12 16)))

(define (suma-diagonal li)
  (cond [(empty? li) 0]
        [else (+ (caar li) (suma-diagonal (map cdr (cdr li))))]))


;selection-sort
;Prueba
;(selection-sort '(7 3 2 9))
;(selection-sort '(9 8 7 6 5 4 3 2 1))

(define (count li)
  (if (null? li)
      0
      (+ 1 (count (cdr li)))))

(define (min li)
  (cond [(null? li) #f]
        [(= 1 (count li)) (car li)]
        [else (if (< (car li) (min (cdr li)))
                  (car li)
                  (min (cdr li)))]))

(define (selection-sort li)
  (cond [(empty? li) '()]
        [else (cons (min li) (selection-sort (remove (min li) li)))]))


;pliega
;Prueba
;(pliega  + 2 '(5 6 7 8))
;(pliega * 2 '(1 2 3 4 5))


(define (pliega fun n li)
  (cond [(empty? li) 0]
        [(empty? (cdr li)) (fun n (car li))]
        [else (fun n (car li)) (pliega fun (fun n (car li)) (cdr li))]))


;zipea
;Prueba
;(zipea '(1 2 3) '(a b c))
;(zipea '(4 a 5 b) '(c 6 d 7))

(define (zipea li1 li2)
  (cond [(empty? li1) '()]
        [else (cons (list (car li1) (car li2)) (zipea (cdr li1) (cdr li2)))]))


