% классная работа

max(X,Y,X):-X>Y,!.
max(_,Y,Y).
max(X,Y,U,Z):-max(X,Y,V),max(V,U,Z).

maxT(X,Y,U,X):-X>Y,X>U,!.
maxT(_,Y,U,Y):-Y>U,!.
maxT(_,_,U,U).

sumcifir(0,C,C):-!.
sumcifir(N,Cs,S):-C is N mod 10, N1 is N div 10, Cs1 is Cs + C, sumcifir(N1,Cs1,S).
sumcifir(N, S):-sumcifir(N, 0 ,S).

sumcifirup(0,0):-!.
sumcifirup(N,Sum):-Cifr is N mod 10, N1 is N div 10, sumcifirup(N1, Sum1),Sum is Sum1 + Cifr.

writelist([]):-!.
writelist([H|T]):-write(H),nl,writelist(T).

pr3_0:-read(N),r_list(A,N),writelist(A).
r_list(A,N):-r_list(A,N,0,[]).
r_list(A,N,N,A):-!.
r_list(A,N,K,B):-read(X),append(B,[X],B1),K1 is K+1,r_list(A,N,K1,B1).

sumlist([],0):-!.
sumlist([H|T],S):-sumlist(T, S1), S is S1 + H.

my_up([],Y,Y).
my_up([H|T],Y,[H|T1]):-my_up(T,Y,T1).

% домашняя работа

% задание 1

sum_list_down(List, Sum) :- sum_list_down(List, 0, Sum).
sum_list_down([], Acc, Acc).
sum_list_down([H|T], Acc, Sum) :-
    Acc1 is Acc + H,
    sum_list_down(T, Acc1, Sum).

sum_list_up([], 0).
sum_list_up([H|T], Sum) :-
    sum_list_up(T, Sum1),
    Sum is H + Sum1.

remove_by_digit_sum([], _, []).
remove_by_digit_sum([H|T], Target, Result) :-
    sumcifir(H, S),
    S =:= Target,
    remove_by_digit_sum(T, Target, Result).
remove_by_digit_sum([H|T], Target, [H|Rest]) :-
    sumcifir(H, S),
    S =\= Target,
    remove_by_digit_sum(T, Target, Rest).

run_sum_down :-
    write('Введите количество элементов: '), nl,
    read(N),
    r_list(List, N),
    sum_list_down(List, Sum),
    write('Сумма (рекурсия вниз): '), write(Sum), nl.

run_sum_up :-
    write('Введите количество элементов: '), nl,
    read(N),
    r_list(List, N),
    sum_list_up(List, Sum),
    write('Сумма (рекурсия вверх): '), write(Sum), nl.

run_remove_by_digit_sum :-
    write('Введите количество элементов: '), nl,
    read(N),
    r_list(List, N),
    write('Введите сумму цифр для удаления: '), nl,
    read(Target),
    remove_by_digit_sum(List, Target, Result),
    write('Результат: '), writelist(Result).

% задание 2

% (+Number, -Product)
% произведение цифр (рекурсия вниз)
prod_digits_down(N, P) :- prod_digits_down(N, 1, P).
prod_digits_down(0, Acc, Acc) :- !.
prod_digits_down(N, Acc, P) :-
    C is N mod 10,
    N1 is N // 10,
    Acc1 is Acc * C,
    prod_digits_down(N1, Acc1, P).

% (+Number, -Product)
% произведение цифр
prod_digits_up(0, 1) :- !.
prod_digits_up(N, P) :-
    C is N mod 10,
    N1 is N // 10,
    prod_digits_up(N1, P1),
    P is P1 * C.

% (+Number, -Count)
% количество нечётных цифр > 3 (рекурсия вниз)
count_odd_gt3_down(N, C) :- count_odd_gt3_down(N, 0, C).
count_odd_gt3_down(0, Acc, Acc) :- !.
count_odd_gt3_down(N, Acc, C) :-
    D is N mod 10,
    N1 is N // 10,
    (D mod 2 =:= 1, D > 3 -> Acc1 is Acc + 1 ; Acc1 is Acc),
    count_odd_gt3_down(N1, Acc1, C).

% (+Number, -Count)
% количество нечётных цифр > 3
count_odd_gt3_up(0, 0) :- !.
count_odd_gt3_up(N, C) :-
    D is N mod 10,
    N1 is N // 10,
    count_odd_gt3_up(N1, C1),
    (D mod 2 =:= 1, D > 3 -> C is C1 + 1 ; C is C1).

% (+A, +B, -GCD)
% наибольший общий делитель чисел A и B
gcd(A, 0, A) :- A =\= 0, !.
gcd(A, B, G) :-
    R is A mod B,
    gcd(B, R, G).

% задание 3

% (+List, -Count)
count_after_last_max(List, Count) :-
    max_list(List, Max),
    reverse(List, Rev),
    append(_, [Max|AfterMax], Rev),
    length(AfterMax, Count).

% (+List, -Result)
move_before_min_to_end(List, Result) :-
    min_list(List, Min),
    append(BeforeMin, [Min|After], List),
    append(After, BeforeMin, Result).

% (+List, +A, +B, -Max)
max_in_interval(List, A, B, Max) :-
    include(in_interval(A, B), List, Filtered),
    max_list(Filtered, Max).
in_interval(A, B, X) :- X >= A, X =< B.