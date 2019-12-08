#lang racket

(require rackunit)


#|

Problema 1. Transpuesta

Layla Tame A01192934

Escribe una función para calcular la transpuesta de una matriz.

Los renglones de A son las columnas de At

|#

(define (nth li n)
  (cond
    [(empty? li) '()]
    [(= n 0) (car li)]
    [else (nth (cdr li) (- n 1))]))

(define (transpAux li n)
  (cond [(empty? li) '()]
        [else (cons (nth (car li) n) (transpAux (cdr li) n))]))

(define (transAux2 li n)
  (cond [(empty? li) '()]
        [(= n (length (car li))) '()]
        [else (cons (transpAux li n) (transAux2 li (+ n 1)))]))

(define (transpuesta li)
  (transAux2 li 0))


;(check-equal? (transpuesta '((1 2 3) (4 5 6) (7 8 9))) '((1 4 7) (2 5 8) (3 6 9)) "Caso 0 Incorrecto")
;(check-equal? (transpuesta '((1 2 3 4 5) (6 7 8 9 10))) '((1 6) (2 7) (3 8) (4 9) (5 10)) "Caso 1 Incorrecto")
;(check-equal? (transpuesta '()) '() "Caso 2 Incorrecto")
;(check-equal? (transpuesta '((#t #f #t))) '((#t) (#f) (#t)) "Caso 3 Incorrecto")


#|

Problema 3. Elimina NO Repetidos

Dada una lista con elementos repetidos y no repetidos, hacer 'match' con una lista
que sólo contenga elementos que se repiten al menos 1 vez. 

|#

(define (isMember elem li)
  (cond [(empty? li) #f]
        [(= elem (car li)) #t]
        [else (isMember elem (cdr li))]))


(define (auxElimina l1 l2)
  (cond [(empty? l1) '()]
        [(isMember (car l1) (remove (car l1) l2)) (cons (car l1) (auxElimina (cdr l1) l2))]
        [else (auxElimina (cdr l1) l2)]))


(define (elimina_no_repetidos li)
  (auxElimina li li))


;tc0 :- (elimina_no_repetidos '(1 2 3 4 5)) -> ()
;tc1 :- (elimina_no_repetidos '(1 1 2 3 3 4 5 5 6 7 7 8)) -> (1,1,3,3,5,5,7,7)
;tc2 :- (elimina_no_repetidos '()) -> ()
;tc3 :- (elimina_no_repetidos '(1 1 2 2 3 3)) -> (1,1,2,2,3,3)
;tc4 :- (elimina_no_repetidos '(1 1 1 1 1 1 1 1 1 1)) -> (1,1,1,1,1,1,1,1,1,1)





