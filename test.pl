:-include('logico.pl').

:-begin_tests(punto1).

    test('si una planta es arbusto'):- es_arbusto(rose).
    test('NO es arbusto', fail):- es_arbusto(lily).

    test('florece en primavera'):- florece_en_primavera(orchid).
    test('NO florece en primavera', fail):- florece_en_primavera(bamboo).

    test('tiene color rojo'):- tiene_color(rose, rojo). 
    test('NO tiene color rojo'):- tiene_color(ivy,verdes). 

:-end_tests(punto1).


:-begin_tests(punto4).

    test('rose y arbol_rojo cumplen todas las caracteristicas'):-relacionPistaObservador(rose,arbol_rojo).
    test('ivy y arbol_rojo  no cumplen todas las caracteristicas', fail):-relacionPistaObservador(ivy,arbol_rojo).

:-end_tests(punto4).

