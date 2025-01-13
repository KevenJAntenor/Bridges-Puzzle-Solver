% Charge les casse-têtes définis dans le fichier puzzles.pl
:- consult(puzzles).

% Vérifie la validité dun casse-tête
puzzle_valid(Puzzle) :-
    length(Puzzle, N),
    maplist(valid_row(N), Puzzle).

% Validates the length and content of each row
valid_row(N, Row) :-
    length(Row, N),
    maplist(valid_cell, Row).

% Validates the content of each cell
valid_cell(Cell) :-
    integer(Cell),
    Cell >= 0,
    Cell =< 8.

% Assuming bridges are generated correctly, this checks for uniqueness explicitly
solution_legal(N, Bridges) :-
    maplist(valid_bridge(N), Bridges),
    all_bridges_have_unique_destinations(Bridges).

all_bridges_have_unique_destinations(Bridges) :-
    findall((X1, Y1, X2, Y2), member(bridge(_, (X1, Y1), (X2, Y2)), Bridges), AllBridges),
    sort(AllBridges, SortedBridges),
    length(AllBridges, OriginalLength),
    length(SortedBridges, SortedLength),
    OriginalLength == SortedLength.

% Validates that the bridge configuration is within bounds and either horizontal or vertical
valid_bridge(N, bridge(Size, (X1, Y1), (X2, Y2))) :-
    member(Size, [1, 2]),
    integer(X1), integer(Y1), integer(X2), integer(Y2),
    X1 >= 0, X1 < N, Y1 >= 0, Y1 < N,
    X2 >= 0, X2 < N, Y2 >= 0, Y2 < N,
    ((X1 = X2, Y1 \= Y2); (Y1 = Y2, X1 \= X2)),
    ((X1 = X2, Y1 < Y2); (Y1 = Y2, X1 < X2)).

    % Connects two islands with a bridge
connects(Puzzle, bridge(_, (X1, Y1), (X2, Y2))) :-
    nth0(Y1, Puzzle, Row),
    nth0(X1, Row, Cell1),
    Cell1 > 0,
    nth0(Y2, Puzzle, Row2),
    nth0(X2, Row2, Cell2),
    Cell2 > 0.

% Verifies no two bridges intersect
does_not_intersect(bridge(, (X1, Y1), (X2, Y2)), bridge(, (X3, Y3), (X4, Y4))) :-
    % Intersect condition logic refined again for accuracy
    \+ (min(X1, X2) < max(X3, X4), max(X1, X2) > min(X3, X4), min(Y1, Y2) < max(Y3, Y4), max(Y1, Y2) > min(Y3, Y4)).

% Ensures no bridges intersect
no_bridges_intersect(Bridges) :-
    \+ (select(B1, Bridges, Rest), member(B2, Rest), \+ does_not_intersect(B1, B2)).

% Extracts all islands from the puzzle
islands(Puzzle, Islands) :-
    findall(island(Cell, X, Y), (nth0(Y, Puzzle, Row), nth0(X, Row, Cell), Cell > 0), Islands).

% Verifies an island is connected as required
island_well_connected(Bridges, island(N, X, Y)) :-
    findall(Size, member(bridge(Size, (X, Y), _), Bridges), Sizes),
    findall(Size, member(bridge(Size, _, (X, Y)), Bridges), Sizes2),
    append(Sizes, Sizes2, AllSizes),
    sum_list(AllSizes, Total),
    Total >= N.

% Validates a solution for a puzzle
validate(Puzzle, Bridges) :-
    length(Puzzle, N),
    puzzle_valid(Puzzle),
    solution_legal(N, Bridges),
    maplist(connects(Puzzle), Bridges),
    no_bridges_intersect(Bridges),
    islands(Puzzle, Islands),
    maplist(island_well_connected(Bridges), Islands).
