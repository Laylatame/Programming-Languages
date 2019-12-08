#lang racket


#|
0. Introducción al paradigma funcional

* Nivel alto, muy alto
* Declarativo
* Basado en el cálculo lambda (Alonso Church 1941)
* Alejado del modelo Von Neumann
* Aplicación de funciones vs mutación de estados
* Transparencia referencial
* Funciones de primer orden (high order functions)
* Dynamic binding, lazy evaluation
|#


;1. Una primera aproximación en contrastes con la programación imperativa 

;factorial

(define (factorial n)
  (if (= n 0) 1
      (* n (factorial (- n 1)))))

;fibonacci

(define (fib n)
  (cond [(= n 1) 1] #|Es como si tuvieras un if|#
        [(= n 2) 1] #|Si n es igual a 2, el valor es 1|#
        [else (+ (fib (- n 2)) (fib (- n 1)))]))

;gdc

;sigma

(define (sig li)
  (if (null? li) #|Si la lista está vacia|#
      0
      (+ (car li) (sig (cdr li)))))

;quicksort

(define (qsort li)
  (if (null? li)
      '() #|Representa una lista vacia, igual que null|#
      (append
       (qsort (filter (lambda (x) (< x (car li))) (cdr li)))
      (list (car li))
      (qsort (filter (lambda (x) (> x (car li))) (cdr li))))))

#|
2. ¿Por qué Racket?

"The greatest single programming language ever designed" - Alan Kay on Lisp

"Lisp is a programmable programming language" - John Foderaro

"Lisp is worth learning for the profound enlightenment experience you will have when you finally get it;
that experience will make you a better programmer for the rest of your days,
even if you never actually use Lisp itself a lot." - Eric Raymond

"The only way to learn a new programming language is by writing programs in it." - Kernighan and Ritchie

"Although my own previous enthusiasm has been for syntactically rich languages, like the Algol family,
I now see clearly and concretely the force of Minsky's 1970 Turing Lecture, in which he argued
that Lisp's uniformity of structure and power of self reference gave the programmer capabilities
whose content was well worth the sacrifice of visual form."
- Robert Floyd, Turing Award Lecture, 1979

"Lisp has all the visual appeal of oatmeal with fingernail clippings mixed in." - Larry Wall

Más frases sobre lisp:
http://www.paulgraham.com/quotes.html?viewfullsite=1

1930's Alonso Church
1950's John McCarthy (FORTRAN y ALGOL)
1970's Steele, Sussman (OOP Smalltalk y Simula)
1990's Racket (PLT Scheme)

The Racket Manifesto
https://www2.ccs.neu.edu/racket/pubs/manifesto.pdf

|#


#|
3. Expresiones de Racket

Atomos: símbolos, números, booleans, carácteres, cadenas, keywords
Listas: lista -> ( [atomo | lista]+ )

Una lista es evaluada como función, siendo el primer término su identificador, y el resto de los elementos los argumentos
Ejemplo: (+ 1 2)

EXCEPTO: cuando el primer término se trata de una forma especial. Cada forma especial tiene su semántica particular.
Ejemplo: if, cond, and, or, define, let, let*, letrec

FUNfact... fun? get it? Podemos definir nuestras propias formas especiales usando macros
|#


;4. Átomos

;Números
;-6
;2309482039482039482093482039482093482093482093842039482093843940582039458729348752983457293485
;1.5
;4/5

;Booleans
;#t
;#f

;Strings
;"asdfasdfasdf"

;Carácteres
;#\a
;#\λ

;Símbolos
;'soy-un-simbolo
;Una palabra que se construye con las mismas reglas que un identificador, pero que evalúa a sí mismo y
;es internalizado, a diferencia de un string inmutable


;number?
;integer?
;negative?
;real?
;rational?
;odd?
;even?
; + - * / < > <= >=

;boolean?
;false?
;not

;symbol?
;symbol=?

;equal? igualdad de valor
;eq? igualdad de valor y referencia (representación física) donde se está guardado el valor
;Probar -> (define l1 '(1 2 3)), (define l2 '(1 2 3)), (equal? l1 l2)


;5. Listas

;El operador de ' indica que una lista va a ser internalizada en lugar de operarla
; Si no se pone el ' -> (+ 1 3) = 4
; Si se utiliza el ' se puede guardar -> (define s '(+ 1 3)) -> (eval s) = 4


;(list 'a 'b 'c 'd)
;(list #t #\A 'a 7.6 (list 3 2 1))
;null o '()
;(list)
;(null? (list))

;'(a b c d)
;'()
;'(a b '(c d))

;(cons 'a (cons 'b (cons 'c (cons 'd null))))

;Las listas se almacenan dinámicamente utilizando como nodos
;a las celdas cons, la cual consta de 2 apuntadores, hacia átomos u otras celdas cons

;(list? '(a))
;(pair? '(a))
;(list? (cons 1 (cons 2 3)))
;(pair? (cons 1 (cons 2 3)))

;Una lista propia es aquella que termina en null-lista vacía
;Una lista impromia (o par) es aquella que NO termina en null-lista vacía

;Probar
;(list? (cons 'a 'b))
;(list? (cons 'a (cons 'b null)))
;(pair? (cons 'a 'b))

;(cons 'a '(b c d))
;(cons '(b c d) 'a)
;(car '(a b c d))
;(cdr (list 't 'e 'y))
;(list-ref '(1 2 4) 2) -> da el elemento 2 de la lista

;empty?
;cons
;car ;first -> regresan un termino
;cdr ;rest -> regressan una lista
;append -> a diferencia de cons, unifica una serie de listas, necesita los parametros
;reverse
;list-ref

;caar -> saca el primer elemento del primer elemento, el primer elemento tiene que ser una lista y saca el elemento 0 de esa
;caddr
;cddr


;6. Formas especiales

;Que es forma especial?
;Donde la regla de evaluacion de expresion no aplica por que la semantica alterna???

;(define a (+ 4 5))
;(quote (a c d))
;(if (equal? 'a (quote a)) (display "Es igual") (display "No es igual"))
;(and (= 2 3) (display "no llega"))
;Es el mismo caso con OR. No son operadores, son formas especiales.
;Más adelante veremos cond, let y lambda


;La funcion define no evalua si no que hace un ligado del elemento que se ponga enseguida con la operacion dentro del ()
;(define a (+ (- (* 4 5) 5) 3)) -> a = 18

;(if (= 3 3) (display "true") (display "false"))
;(if (= 3 3) (display "true") (- b c)) -> por que da true?? Investigar

;(and (= 2 3) #t #f asdfasdfasdf)
;Primera cosa que vea la voy a tomar como identificador
;And -> solamente evalua el primer false
;Or -> solamente evalua el primer true

;7. Funciones

;Tres formas de definir funciones. Usaremos la versión 1 "azucarada sintácticamente" para la clase
;(define (fun1 x y) (/ x y))
;(define fun2 (lambda (x y) (/ x y)))
;(define fun3 (lambda (x) (lambda (y) (/ x y))))

;(lambda (x y z) (list x y z))


;(define x (lambda (x) (+ x x))) -> definir funcion con una lambda (funcion anonima)
;Manera alterna de escribir la misma funcion:
;(define (fun1 a b c) (+ a b c))
;(define (x y) (+ y y))
;((lambda (x y) (- x y)) 4 5) = -1


;8. Recursividad plana y profunda

;Plana: soluciones que trabajan con listas que sólo contiene átomos, lista de un solo nivel
;Profunda: soluciones que trabajan con listas ímbricas, anidadas, listas de listas de listas



;9. Ejercicios

;Numéricos

;divisible -> funcion que diga si un elemento es divisible entre otro sin reminder

(define (divisible? n i)
  (= 0 (modulo n i)))


;no-divisible

(define (not-divisible? n i)
  (not (divisible? n i)))

;no-divisible por todos menores a n

(define (not-divisible<=i n i)
  (if (= i 1)
      #t #|Regresa true|#
      (and (not-divisible? n i) (not-divisible<=i n (- i 1)))))

;es-primo

(define (es-primo n)
  (not-divisible<=i n (- n 1)))

;todos-primos -> Genera una lista con todos los primos de 1 a n, donde n es el unico parametro

(define (todos-primos n)
  (cond [(= n 1) '()]
        [(es-primo n) (cons n (todos-primos (- n 1)))] #|Encadenarlo al principio de la lista, un lado apunta al elemento y el otro a la solucion de la recursiva|#
        [(not (es-primo n)) (todos-primos (- n 1))]))




;co-primos
;Maximo comun divisor (mas grande que pueda dividir a los dos de manera entera)

;Listas planas

; count -> contar la cantidad de elementos base en una lista

(define (count li)
  (if (null? li)
      0
      (+ 1 (count (cdr li)))))


; max

(define (max li)
  (cond [(null? li) #f]
        [(= 1 (count li)) (car li)]
        [else (if (> (car li) (max (cdr li)))
                  (car li)
                  (max (cdr li)))]))


; min

(define (min li)
  (cond [(null? li) #f]
        [(= 1 (count li)) (car li)]
        [else (if (< (car li) (max (cdr li)))
                  (car li)
                  (max (cdr li)))]))

; reversa

(define (reversa li)
  (if (empty? li)
      '()
      (append (reversa (cdr li)) (list (car li)))))


; nth -> Acceder el n elemento de una lista

(define (nth li n)
  (cond
    [(empty? li) (display "meh")]
    [(= n 0) (car li)]
    [else (nth (cdr li) (- n 1))]))


; take -> tomar los primeros n elementos de la lista

(define (take n li)
  (cond [(empty? li) '()]
        [(= n 0) '()]
        [else (cons (car li) (take (- n 1) (cdr li)))]))

; drop -> va a tomar los primeros n elementos de la lista

; repeat

; range

; split

; palindrome


;Listas anidadas (ímbricas)

; count-atoms

; count-atom-occurrence

; flatten

; max/minss

; sigma


;Primer orden

; map

; filter

; fold

