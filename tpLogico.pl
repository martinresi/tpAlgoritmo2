persona(samuel, lentes(negros)).
persona(samuel, pelo(blanco,lacio)).
persona(samuel, calvo).
persona(samuel, boca(chica)).
persona(samuel, cara(puntuda)).
persona(samuel,ojos(marrones)).
persona(samuel, nariz(chica)).
persona(pepe, lentes(rojos)).
persona(pepe, pelo(rubio,rulos)).
persona(pepe, boca(chica)).
persona(pepe, cara(puntuda)).
persona(pepe, ojos(marrones)).
persona(pepe, nariz(chica)).
persona(juan, boca(chica)).
persona(juan, pelo(rubio, lacio)).
carta(rojo, samuel).
carta(azul, pepe).
carta(rojo, juan).
contrincante(rojo, azul).
contrincante(azul, rojo).
pista(rojo,pelo(rubio,_)).
pista(rojo,boca(chica)).
jugadores(samuel).
jugadores(pepe).
jugadores(juan).

% 1. Queremos preguntarle a nuestro contrincante si
% a. Es calvo
esCalvo(Color):-carta(Color,Persona),persona(Persona,calvo).

% b. Es rubio
esRubio(Color):-carta(Color,Persona),persona(Persona,pelo(rubio,_)).

% c. Tiene lentes
tieneLentes(Color):-carta(Color,Persona),persona(Persona,lentes(_)).

% 2. Sabemos que las personas:

% a. Que tienen nariz chica y boca grande, tienen lentes (el color del lente podemos asumirlo que es marrón).
tieneLentesYBocaGrande(Persona):- persona(Persona, nariz(chica)), persona(Persona, boca(grande)).

% b. Que son morochas o castañas, tienen ojos marrones.
tieneOjosMarrones(Persona):-persona(Persona,pelo(morocha,_)).
tieneOjosMarrones(Persona):-persona(Persona,pelo(castania,_)).
tieneOjosMarrones(Persona):-persona(Persona,ojos(marrones)).

% c. Los que no tienen la cara puntuda, tienen la cara redonda.
tieneCaraRedonda(Persona):-not(persona(Persona, cara(puntuda))).

% Realizar el predicado que nos permita agregar este conocimiento y el punto 1 no deba modificarse.
% 3. Se necesita saber el conjunto de todos los rubios de boca chica.
rubiosDeBocaChica(Personas) :- 
    findall(Persona, (persona(Persona, pelo(rubio, _)), 
                       persona(Persona, boca(chica))), Personas).


% 4. Ahora agregamos a la base las pistas que va obteniendo el jugador.
% Por ejemplo:
% pista(rojo,pelo(rubio,_)).
% pista(rojo,boca(chica)).
% Con dicho predicado, queremos relacionar una persona y un jugador solo si todas las pistas que tiene el jugador
% son características de la persona. En este punto no se puede usar findall.


sonCaracteristicas(Persona):- jugadores(Persona),
    forall(pista(_,Caracteristica), persona(Persona, Caracteristica)).

% Las 2 funciones son iguales, solo que una es mas especifica que la otra. 

cumpleCaracteristicas(Color, Persona):- carta(Color, Persona),
    forall(pista(_,Caracteristica), persona(Persona, Caracteristica)).

% 5. Por último queremos saber si un color está ganándole a su contrincante. Para eso, 
% las personas que cumplen las pistas, deben ser menos que las personas que cumplen las pistas de su contrincante.

cantidadPersonasQueCumplen(Color, Cantidad) :-
    findall(Persona, cumpleCaracteristicas(Color, Persona), Personas),
    length(Personas, Cantidad).

estaGanando(Color) :-
    contrincante(Color, Contrincante),
    cantidadPersonasQueCumplen(Color, CantidadColor),
    cantidadPersonasQueCumplen(Contrincante, CantidadContrincante),
    CantidadColor < CantidadContrincante.


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

test("rubiosDeBocaChica", set(Personas == [pepe])) :-
    rubiosDeBocaChica(Personas).

test("pepe es rubio de boca chica", nondet) :- 
    rubiosDeBocaChica(pepe).

test("Samuel no es rubio de boca chica", fail) :-
    rubiosDeBocaChica(samuel).

:- end_tests(rubiosDeBocaChica).

% PUNTO 4

:- begin_tests(buscandoPistas).
test("cumpleCaracteristicas", fail) :- cumpleCaracteristicas(rojo, samuel).
:- end_tests(buscandoPistas).

:- begin_tests(buscandoPistas).
test("sonCaracteristicas", fail) :- sonCaracteristicas(samuel).
:- end_tests(buscandoPistas).
