% Format:   | land | domestic | predator | fly | swim | size | tail
animal(cat,              1, 1, 1, 0, 0, 1, 1).
animal(dog,              1, 1, 1, 0, 0, 2, 1).
animal(cow,              1, 1, 0, 0, 0, 3, 1).
animal(horse,            1, 1, 0, 0, 0, 3, 1).
animal(chicken,          1, 1, 0, 1, 0, 1, 1).
animal(goat,             1, 1, 0, 0, 0, 2, 1).
animal(pig,              1, 1, 0, 0, 0, 2, 1).
animal(rabbit,           1, 1, 0, 0, 0, 1, 1).
animal(duck,             1, 1, 0, 1, 1, 1, 1).
animal(sheep,            1, 1, 0, 0, 0, 2, 1).
animal(lion,             1, 0, 3, 0, 0, 3, 1).
animal(tiger,            1, 0, 3, 0, 0, 3, 1).
animal(elephant,         1, 0, 0, 0, 0, 4, 0).
animal(zebra,            1, 0, 0, 0, 0, 3, 1).
animal(giraffe,          1, 0, 0, 0, 0, 4, 1).
animal(kangaroo,         1, 0, 0, 0, 0, 2, 1).
animal(panda,            1, 0, 0, 0, 0, 3, 1).
animal(wolf,             1, 0, 2, 0, 0, 2, 1).
animal(fox,              1, 0, 2, 0, 0, 1, 1).
animal(bear,             1, 0, 2, 0, 1, 3, 1).
animal(eagle,            0, 0, 3, 1, 0, 2, 0).
animal(pigeon,           0, 0, 0, 1, 0, 1, 0).
animal(owl,              0, 0, 2, 1, 0, 1, 0).
animal(parrot,           0, 0, 0, 1, 0, 1, 0).
animal(shark,            0, 0, 3, 0, 3, 3, 0).
animal(dolphin,          0, 0, 1, 0, 3, 2, 0).
animal(whale,            0, 0, 1, 0, 3, 4, 0).
animal(penguin,          1, 0, 1, 0, 2, 2, 1).
animal(seal,             1, 0, 1, 0, 3, 2, 1).
animal(crocodile,        1, 0, 2, 0, 3, 3, 1).

question_land(X) :-
    print("Is the animal land‑based? (1‑yes, 0‑no)"), nl, read(X).

question_domestic(X) :-
    print("Is it a domestic animal? (1‑yes, 0‑no)"), nl, read(X).

question_predator(X) :-
    print("How predatory is it? (3‑apex predator, 2‑predatory, 1‑mildly, 0‑not)"), nl, read(X).

question_fly(X) :-
    print("Can it fly? (1‑yes, 0‑no)"), nl, read(X).

question_swim(X) :-
    print("Can it swim/live in water? (3‑marine, 2‑good, 1‑a bit, 0‑no)"), nl, read(X).

question_size(X) :-
    print("What is its size? (4‑very large, 3‑large, 2‑medium, 1‑small)"), nl, read(X).

question_tail(X) :-
    print("Does it have a tail? (1‑yes, 0‑no)"), nl, read(X).

akinator :-
    question_land(Q1),
    question_domestic(Q2),
    question_predator(Q3),
    question_fly(Q4),
    question_swim(Q5),
    question_size(Q6),
    question_tail(Q7),
    animal(Animal, Q1, Q2, Q3, Q4, Q5, Q6, Q7),
    nl, print("You are thinking of: "), print(Animal), print("!"), nl.
