man:-man(X),print(X),nl,fail.
mother(Y):-parent(X,Y),woman(X),print(X),nl,fail.
mothers(X,Y):-parent(X,Y),woman(X),print(X - Y),nl,fail.
brother(X, Y):-parent(Z,X),parent(Z,Y),X\=Y,man(X).
brothers(X,Y):-parent(Z,X),parent(Z,Y),man(X),print(X - Y),nl,fail.
b_s(X):-parent(Z,X),parent(Z,Y),man(X),woman(Y),print(X - Y),nl,fail.
b_ss(X,Y):-parent(Z,X),parent(Z,Y),man(X),woman(Y),print(X - Y),nl,fail.
father(Y):-parent(X,Y),man(X),print(X),nl,fail.
fathers(X,Y):-parent(X,Y),man(X),print(X - Y),nl,fail.
sister(X):-parent(Z,X),parent(Z,Y),woman(X),print(X - Y),nl,fail.
sisters(X,Y):-parent(Z,X),parent(Z,Y),woman(X),print(X - Y),nl,fail.
grand_pa(X, Y):-parent(X, Parent),parent(Parent, Y),man(X).
grand_pas(Y):-grand_pa(X, Y),print(X),nl,fail.
grand_pa_and_son(X, Y):-grand_pa(X, Y); grand_pa(Y, X),print(X - Y),nl,fail.
uncle(X, Y):-parent(P, Y),brother(X, P).

uncles(X) :-
    uncle(Uncle, X),
    print(Uncle), nl,
    fail.
uncles(_).

