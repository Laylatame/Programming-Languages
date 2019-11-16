goberno(vfq, 2000, 2006).
goberno(ezp, 1994, 2000).
goberno(csg, 1988, 1994).
goberno(mmh, 1982, 1988).
goberno(jlp, 1976, 1982).
goberno(lea, 1970, 1976).

presidente(Persona, Anio) :- goberno(Persona, Inicio, Fin), Anio >= Inicio, Anio =< Fin.

diferencia_mandato(P1, P2, D) :- goberno(P1, _, F1), goberno(P2, I2, _), D is I2 - F1.

escribe_presidentes :- goberno(P, _, _), write(P), nl, fail.