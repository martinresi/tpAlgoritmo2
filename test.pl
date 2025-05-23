:-include('logico.pl').

:-begin_tests(punto1).

    test('si una planta es arbusto'):- es_arbusto(rose).
    test('NO es arbusto', fail):- es_arbusto(lily).

    test('florece en primavera'):- florece_en_primavera(orchid).
    test('NO florece en primavera', fail):- florece_en_primavera(bamboo).

    test('tiene color rojo'):- tiene_color(rose, rojo). 
    test('NO tiene color rojo'):- tiene_color(ivy,verdes). 

:-end_tests(punto1).

:-begin_tests(punto2).
    
test('ninguna planta actual necesita riego especial', fail) :-
    planta(_, sistemaRiegoEspecial(riegoEspecial)).

test('solo las plantas rojas y amarillas atraen mas insectos beneficos', set(Planta == [rose, tulip, sunflower])) :-
    planta(Planta, atraeInsectos(beneficos)).

test('bamboo no atrae mas insectos beneficos', fail) :-
    planta(bamboo, atraeInsectos(beneficos)).
    
test('las plantas que no son de tipo flor son consideradas altas', set(Planta == [bamboo, fern, ivy, rose, cactus])) :-
    planta(Planta, plantaAlta(esAlta)).

test('lily no es considerada alta', fail) :-
    planta(lily, plantaAlta(esAlta)).

:-end_tests(punto2).

:- begin_tests(punto3).

    test('lily, orchid, y tulip son plantas de tipo flor y cortas', set(Plantas == [[lily, tulip, orchid]] )  ):- flor_corta(Plantas).
    test('rose es tipo arbusto y altura media', fail):- flor_corta(Plantas), member(rose, Plantas).
    test('bamboo es tipo pasto y alta', fail):- flor_corta(Plantas), member(bamboo, Plantas).

:- end_tests(punto3).

:-begin_tests(punto4).

    test('rose y arbol_rojo cumplen todas las caracteristicas'):- relacionPistaObservador(rose,arbol_rojo).
    test('ivy y arbol_rojo  no cumplen todas las caracteristicas', fail):- relacionPistaObservador(ivy,arbol_rojo).

:-end_tests(punto4).

:- begin_tests(punto5).

    test('rose tiene mas vistas que bamboo', nondet) :-
        atrae_mas_visitas(rose).

    test('tulip no atrae más visitas que sunflower', fail) :-
        atrae_mas_visitas(tulip).

    test('inversibilidad de atrae_mas_visitas',nondet) :-
        atrae_mas_visitas(rose).
        
:- end_tests(punto5).
