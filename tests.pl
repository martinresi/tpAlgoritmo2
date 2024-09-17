% PUNTO 1

:- begin_tests(esCalvo).
test("esCalvo",nondet) :-esCalvo(rojo). 
test("esCalvo", fail) :-esCalvo(azul). 
:- end_tests(esCalvo).

:- begin_tests(esRubio).
test("esRubio",nondet) :-esRubio(azul).
test("esRubio",nondet) :-esRubio(azul).  
:- end_tests(esRubio).

:- begin_tests(tieneLentes).
test("tieneLentes",nondet) :-tieneLentes(azul).
test("tieneLentes",fail) :-tieneLentes(negro).
:- end_tests(tieneLentes).

% PUNTO 2

:- begin_tests(tieneLentesYBocaGrande).
test("tieneLentesYBocaGrande", fail) :-tieneLentesYBocaGrande(samuel).
:- end_tests(tieneLentesYBocaGrande).

:- begin_tests(tieneOjosMarrones).
test("tieneOjosMarrones", fail) :-tieneOjosMarrones(juan).
:- end_tests(tieneOjosMarrones).

:- begin_tests(tieneCaraRedonda).
test("tieneCaraRedonda", nondet) :-tieneCaraRedonda(juan).
test("tieneCaraRedonda", fail) :-tieneCaraRedonda(samuel).
:- end_tests(tieneCaraRedonda).

% PUNTO 3

:- begin_tests(rubiosDeBocaChica).

test("rubiosDeBocaChica", [true(Personas == [pepe, juan])]) :-
    rubiosDeBocaChica(Personas), !.

test("pepe es rubio de boca chica", true) :- 
    rubiosDeBocaChica(Personas),
    member(pepe, Personas), !.

test("Samuel no es rubio de boca chica", fail) :-
    rubiosDeBocaChica(Personas),
    member(samuel, Personas).
:- end_tests(rubiosDeBocaChica).

% PUNTO 4

:- begin_tests(buscandoPistas).
test("cumpleCaracteristicas", fail) :- cumpleCaracteristicas(rojo, samuel).
:- end_tests(buscandoPistas).

:- begin_tests(buscandoPistas).
test("sonCaracteristicas", fail) :- sonCaracteristicas(samuel).
:- end_tests(buscandoPistas).

% PUNTO 5

:- begin_tests(estaGanando).
test("Esta ganando el azul") :- estaGanando(azul).
test("No esta ganando el rojo", fail) :- estaGanando(rojo).
:- end_tests(estaGanando).
