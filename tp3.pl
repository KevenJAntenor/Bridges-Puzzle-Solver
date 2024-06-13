% INF6128 - Été 2024 (Groupe 050) - TP3
% Auteur : nom, code permanent

% Les casse-têtes sont définis dans le fichier puzzles.pl
:- consult(puzzles).

% 1. Vérifier la validité d'un casse-tête
puzzle_valid(_) :-
    % TODO: à compléter
    fail.

:- begin_tests(puzzle_valid).
puzzle_valid_test(Name) :- puzzle(Name, Puzzle), puzzle_valid(Puzzle).
test(example) :- puzzle_valid_test(example).
test(invalid1) :- not(puzzle_valid(invalid1)).
test(invalid2) :- not(puzzle_valid(invalid2)).
test(invalid3) :- not(puzzle_valid(invalid3)).
:- end_tests(puzzle_valid).


solution_legal(_, _) :-
    % TODO: à compléter
    fail.

:- begin_tests(solution_legal).
test(solution_legal1) :- solution_legal([
  bridge(1, (0, 0), (3, 0)),
  bridge(2, (3, 0), (3, 3)),
  bridge(2, (0, 3), (3, 3))
]).
test(solution_legal2) :- not(solution_legal(4, [bridge(0, (0, 0), (3, 0))]).
test(solution_legal3) :- not(solution_legal(4, [bridge(3, (0, 0), (3, 0))]).
test(solution_legal4) :- not(solution_legal(4, [bridge(1, (-1, 0), (3, 0))]).
test(solution_legal5) :- not(solution_legal(4, [bridge(1, (0, 0), (5, 0))]).
test(solution_legal6) :- not(solution_legal(4, [bridge(1, (0, 0), (1, 1))]).
test(solution_legal7) :- not(solution_legal(4, [bridge(1, (3, 0), (0, 0))]).
test(solution_legal8) :- not(solution_legal(4, [bridge(1, (3, 3), (3, 0))]).
test(solution_legal9) :- findall((X, Y), solution_legal(2, [bridge(1, (0, 0), (X, Y))], [(0, 1), (1, 0)])).
:- end_tests(solution_legal).

connects(_, _) :-
    % TODO: à compléter
    fail.

:- begin_tests(connects).
connects_test(Name, Bridge) :- puzzle(Name, Puzzle), connects(Puzzle, Bridge).
test(connects1) :- connects_test(example, bridge(1, (0, 0), (3, 0))).
test(connects2) :- connects_test(example, bridge(2, (0, 0), (3, 0))).
test(connects3) :- not(connects_test(example, bridge(1, (0, 0), (2, 0)))).
test(connects4) :- connects_test(example, bridge(1, (0, 0), (0, 3))).
test(connects5) :- connects_test(example, bridge(1, (0, 3), (3, 3))).
:- end_tests(connects).

does_not_intersect(_, _) :-
    % TODO: à compléter
    fail.

no_bridges_intersect(_) :-
    % TODO: à compléter
    fail.

:- begin_tests(does_not_intersect).
test(does_not_intersect1) :- does_not_intersect(bridge(1, (0, 0), (3, 0)), bridge(1, (0, 0), (0, 3))).
test(does_not_intersect2) :- does_not_intersect(bridge(1, (0, 0), (1, 0)), bridge(1, (1, 0), (3, 0))).
test(does_not_intersect3) :- not(does_not_intersect(bridge(1, (0, 0), (2, 0)), bridge(1, (1, 0), (3, 0)))).
test(does_not_intersect3) :- not(does_not_intersect(bridge(1, (0, 1), (2, 1)), bridge(1, (1, 0), (1, 2)))).
:- end_tests(does_not_intersect).

:- begin_tests(no_bridges_intersect).
test(no_bridges_intersect1) :- no_bridges_intersect([]).
test(no_bridges_intersect2) :- no_bridges_intersect([bridge(1, (0, 0), (3, 0))]).
test(no_bridges_intersect3) :- no_bridges_intersect([bridge(1, (0, 0), (1, 0)), bridge(1, (1, 0), (2, 0))]).
:- end_tests(no_bridges_intersect).

islands(_, _) :-
    % TODO: à compléter
    fail.

:- begin_tests(islands).
test(islands1) :- puzzle(example, Puzzle), islands(Puzzle, [island(1, 0, 0), island(3, 3, 0), island(2, 0, 3), island(4, 3, 3)]).
:- end_tests(islands).

island_well_connected(_, _) :-
    % TODO: à compléter
    fail.

:- begin_tests(island_well_connected).
test(island_well_connected1) :- island_well_connected(island(1, 0, 0), [bridge(1, (0, 0), (3, 0))]).
test(island_well_connected2) :- not(island_well_connected(island(1, 0, 0), [bridge(2, (0, 0), (3, 0))])).
test(island_well_connected3) :- island_well_connected(island(2, 0, 0), [bridge(1, (0, 0), (3, 0)), bridge(1, (0, 0), (0, 3)])).
:- end_tests(island_well_connected).


validate(_, _) :-
    % TODO: à compléter
    fail.

:- begin_tests(validate).
test(validate1) :- puzzle(example, Puzzle), validate(Puzzle, [bridge(1, (0, 0), (3, 0)), bridge(2, (3, 0), (3, 3)), bridge(2, (0, 3), (3, 3))]).
test(validate2) :- puzzle(example, Puzzle), not(validate(Puzzle, [bridge(1, (0, 0), (3, 0)), bridge(1, (3, 0), (3, 3)), bridge(2, (0, 3), (3, 3))])).
test(validate3) :- puzzle(example, Puzzle), not(validate(Puzzle, [bridge(1, (0, 0), (3, 0)), bridge(2, (3, 0), (3, 3)), bridge(2, (0, 3), (3, 3)), bridge(2, (1, 3), (2, 3))])).
:- end_tests(validate).

:- begin_tests(resolution).
test(resolution) :- puzzle(example, Puzzle), findall(Sol, validate(Puzzle, Solution), Solutions), length(Solutions, 1).
:- end_tests(resolution).
