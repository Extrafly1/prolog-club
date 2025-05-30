% Предикат для извлечения элемента с минимальным F из списка
get_min([fgv(F, G, V, P) | T], F, G, V, P, T) :- !.
get_min([H | T], F, G, V, P, [H | Rest]) :-
    get_min(T, F1, G1, V1, P1, Rest1),
    (H = fgv(FH, GH, VH, PH), FH < F1
    -> F = FH, G = GH, V = VH, P = PH, Rest = [fgv(F1, G1, V1, P1) | Rest1]
    ;  F = F1, G = G1, V = V1, P = P1, Rest = [H | Rest1]
    ).

% Предикат для вставки элемента в отсортированный список по F-значению
insert_sorted([], E, [E]).
insert_sorted([H | T], E, [E, H | T]) :-
    E = fgv(F1, _, _, _),
    H = fgv(F2, _, _, _),
    F1 =< F2, !.
insert_sorted([H | T], E, [H | R]) :-
    insert_sorted(T, E, R).

% Предикат обработки соседей текущей вершины
process_neighbors([], _, _, _, Open, Open, _).
process_neighbors([Neighbor-CostEdge | Ns], Node, G0, Goal, Open0, Open, Closed) :-
    G1 is G0 + CostEdge,
    (member(closed_node(Neighbor, _, _), Closed)
    -> process_neighbors(Ns, Node, G0, Goal, Open0, Open, Closed)
    ;  h(Neighbor, Goal, H),
       F is G1 + H,
       (select(fgv(_, OldG, Neighbor, _), Open0, Open1)
       -> (G1 < OldG 
           -> insert_sorted(Open1, fgv(F, G1, Neighbor, Node), Open2)
           ;  Open2 = Open0
          )
       ;  insert_sorted(Open0, fgv(F, G1, Neighbor, Node), Open2)
       ),
       process_neighbors(Ns, Node, G0, Goal, Open2, Open, Closed)
    ).

% Временная заглушка эвристической функции
h(_, _, 0).

% Запускающий предикат алгоритма A*
a_star(Start, Goal, Path, Cost) :-
    h(Start, Goal, H),
    F is 0 + H,
    Open = [fgv(F, 0, Start, nil)],
    Closed = [],
    a_star(Open, Closed, Goal, Path, Cost).

% Базовый случай: путь найден
a_star(Open, Closed, Goal, Path, Cost) :-
    get_min(Open, _, G, Goal, Parent, _),
    build_path(Closed, Parent, [Goal], Path),
    Cost = G.

% Рекурсивный поиск пути
a_star(Open, Closed, Goal, Path, Cost) :-
    get_min(Open, _F, G, Node, Parent, RestOpen),
    (member(closed_node(Node, _, _), Closed) 
    -> a_star(RestOpen, Closed, Goal, Path, Cost)
    ;  NewClosed = [closed_node(Node, Parent, G) | Closed],
       findall(Neighbor-CostEdge, edge(Node, Neighbor, CostEdge), Neighbors),
       process_neighbors(Neighbors, Node, G, Goal, RestOpen, NewOpen, NewClosed),
       a_star(NewOpen, NewClosed, Goal, Path, Cost)
    ).

% Построение пути по обратным ссылкам
build_path(_, nil, Path, Path) :- !.
build_path(Closed, Node, Acc, Path) :-
    get_parent(Closed, Node, Parent),
    build_path(Closed, Parent, [Node | Acc], Path).

% Поиск родителя вершины в закрытом списке
get_parent([closed_node(Node, Parent, _) | _], Node, Parent) :- !.
get_parent([_ | T], Node, Parent) :-
    get_parent(T, Node, Parent).
