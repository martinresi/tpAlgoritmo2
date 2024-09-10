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
carta(rojo, samuel).
carta(azul, pepe).
contrincante(rojo, azul).
contrincante(azul, rojo).

% 1. Queremos preguntarle a nuestro contrincante si
% a. Es calvo
esCalvo(Color):-carta(Color,Persona),persona(Persona,calvo).

% b. Es rubio
esRubio(Color):-carta(Color,Persona),persona(Persona,pelo(rubio,_)).

% c. Tiene lentes
tieneLentes(Color):-carta(Color,Persona),persona(Persona,lentes(_)).

% 2. Sabemos que las personas:
% a. Que tienen nariz chica y boca grande, tienen lentes (el color del lente podemos asumirlo que es marrón).
tieneLentes(marrones):- persona(Persona, nariz(chica)), persona(Persona, boca(grande)).

% b. Que son morochas o castañas, tienen ojos marrones.
persona(Persona,ojos(marrones)):-persona(Persona,pelo(morocha,_)).
persona(Persona,ojos(marrones)):-persona(Persona,pelo(castania,_)).

% c. Los que no tienen la cara puntuda, tienen la cara redonda.
persona(Persona,cara(redonda)):-not(persona(Persona, cara(puntuda))).

% Realizar el predicado que nos permita agregar este conocimiento y el punto 1 no deba modificarse.


% 3. Se necesita saber el conjunto de todos los rubios de boca chica.


% 4. Ahora agregamos a la base las pistas que va obteniendo el jugador.
% Por ejemplo:
% pista(rojo,pelo(rubio,_)).
% pista(rojo,boca(chica)).
% Con dicho predicado, queremos relacionar una persona y un jugador solo si todas las pistas que tiene el jugador,
% son características de la persona. En este punto no se puede usar findall.

%---- Predicados creados para jugar con las funciones y que no salgan varias respuestas iguales
pista(rojo, pelo(rubio,_)).
pista(rojo, boca(chica)).

jugadores(samuel).
jugadores(pepe).
jugadores(juan).

persona(juan, boca(chica)).
persona(juan, pelo(rubio, lacio)).
carta(rojo, juan).

/*
sonCaracteristicas(Persona):- jugadores(Persona),
    forall(pista(_,Caracteristica), persona(Persona, Caracteristica)).

 Ejemplo: sonCaracteristicas(Quien).
			Quien = pepe
			Quien = juan
*/	

cumpleCaracteristicas(Color, Persona):- carta(Color, Persona),
    forall(pista(_,Caracteristica), persona(Persona, Caracteristica)).


/* Ejemplo: cumpleCaracteristicas(azul, Quien).
			Quien = pepe
			----------------------------------
            cumpleCaracteristicas(rojo, Quien).
			Quien = juan
*/



% 5. Por último queremos saber si un color está ganándole a su contrincante. Para eso, 
% las personas que cumplen las pistas, deben ser menos que las personas que cumplen las pistas de su contrincante.
