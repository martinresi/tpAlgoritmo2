% PUNTO 1

:- begin_tests(esCalvo).
test("esCalvo",nondet) :-esCalvo(rojo). 
test("esCalvo", fail) :-esCalvo(azul). 
:- end_tests(esCalvo).

:- begin_tests(esRubio).
test("esRubio",fail) :-esRubio(negro).
test("esRubio",fail) :-esRubio(negro).  
:- end_tests(esRubio).

:- begin_tests(tieneLentes).
test("tieneLentes",nondet) :-tieneLentes(azul).
test("tieneLentes",fail) :-tieneLentes(negro).
:- end_tests(tieneLentes).

:- begin_tests(verificar_Inversibilidad).
test("equipos_con_personas_con_lentes", set (Equipo = [rojo, azul])):- tieneLentes(Equipo).
:- end_tests(verificar_Inversibilidad).

% PUNTO 2

:- begin_tests(personaConLentes).
test("tieneLentes", fail) :- persona(pepe, lentes(marron)).
:- end_tests(personaConLentes).

:- begin_tests(personaQueNoTieneOjosMarrones).
test("noTieneOjosMarrones") :- persona(juan, ojos(marrones)).
:- end_tests(personaQueNoTieneOjosMarrones).

:- begin_tests(personaConCaraRedonda).
test("tieneCaraRedonda", nondet) :- persona(juan, cara(redonda)).
:- end_tests(personaConCaraRedonda).

:- begin_tests(verificar_Inversibilidad).
test("personas_con_ojos_marrones", set (Persona = [samuel, pepe])):- persona(Persona, ojos(marrones)).
:- end_tests(verificar_Inversibilidad).

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

:- begin_tests(verificar_Inversibilidad).
test("conjunto_de_rubios_con_boca_chica", set (Personas == [pepe, juan])]) :- rubiosDeBocaChica(Personas).
:- end_tests(verificar_Inversibilidad).

% PUNTO 4

:- begin_tests(buscandoPistas).
test("cumpleCaracteristicas", fail) :- cumpleCaracteristicas(rojo, samuel).
:- end_tests(buscandoPistas).

% PUNTO 5

:- begin_tests(estaGanando).
test("Está ganando el rojo") :- 
    estaGanando(rojo).

test("Está perdiendo el azul",fail) :- 
    estaGanando(azul).
:- end_tests(estaGanando).

