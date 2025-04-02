:-include('logico.pl').


:-begin_tests(punto4).

    test('rose y arbol_rojo cumplen todas las caracteristicas'):-relacionPistaObservador(rose,arbol_rojo).
    test('ivy y arbol_rojo  no cumplen todas las caracteristicas', fail):-relacionPistaObservador(ivy,arbol_rojo).

:-end_tests(punto4).

