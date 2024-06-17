:- consult(puzzles).
:- consult(tp3).

:- discontiguous test/1.
:- discontiguous test/2.

test(puzzle_valid).
puzzle_valid_test(Name) :- puzzle(Name, Puzzle), puzzle_valid(Puzzle).
test(puzzle_valid, example) :- puzzle_valid_test(example).
test(puzzle_valid, invalid1) :- not(puzzle_valid_test(invalid1)).
test(puzzle_valid, invalid2) :- not(puzzle_valid_test(invalid2)).
test(puzzle_valid, invalid3) :- not(puzzle_valid_test(invalid3)).
test(puzzle_valid, trivial1) :- puzzle_valid_test(trivial1).
test(puzzle_valid, trivial2) :- puzzle_valid_test(trivial2).
test(puzzle_valid, easy1) :- puzzle_valid_test(easy1).
test(puzzle_valid, regular1) :- puzzle_valid_test(regular1).

test(solution_legal).
test(solution_legal, example) :- solution(example, S), solution_legal(4, S).
test(solution_legal, trivial1) :- solution(trivial1, S), solution_legal(3, S).
test(solution_legal, trivial2) :- solution(trivial2, S), solution_legal(3, S).
test(solution_legal, easy1) :- solution(easy1, S), solution_legal(5, S).
test(solution_legal, regular1) :- solution(regular1, S), solution_legal(7, S).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(0, (0, 0), (3, 0)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(3, (0, 0), (3, 0)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(1, (-1, 0), (3, 0)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(1, (0, 0), (5, 0)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(1, (0, 0), (1, 1)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(1, (3, 0), (0, 0)))).
test(solution_legal, illegal1) :- not(solution_legal(4, bridge(1, (3, 3), (3, 0)))).
test(solution_legal, unique) :-
    findall((X, Y),
            solution_legal(2, [bridge(1, (0, 0), (X, Y))]),
            L),
    list_to_set(L, [(1, 0), (0, 1)]).

test(connects).
test(connects, example1) :- puzzle(example, P), connects(P, bridge(1, (0, 0), (3, 0))).
test(connects, example2) :- puzzle(example, P), connects(P, bridge(2, (0, 0), (3, 0))).
test(connects, example3) :- puzzle(example, P), not(connects(P, bridge(2, (0, 0), (2, 0)))).
test(connects, example4) :- puzzle(example, P), connects(P, bridge(1, (0, 0), (0, 3))).
test(connects, example4) :- puzzle(example, P), connects(P, bridge(1, (0, 3), (3, 3))).

test(does_not_intersect).
test(does_not_intersect, 1) :- does_not_intersect(bridge(1, (0, 0), (3, 0)), bridge(1, (0, 0), (0, 3))).
test(does_not_intersect, 2) :- does_not_intersect(bridge(1, (0, 0), (1, 0)), bridge(1, (1, 0), (3, 0))).
test(does_not_intersect, 3) :- not(does_not_intersect(bridge(1, (0, 0), (2, 0)), bridge(1, (1, 0), (3, 0)))).
test(does_not_intersect, 4) :- not(does_not_intersect(bridge(1, (0, 0), (0, 2)), bridge(1, (0, 1), (0, 3)))).
test(does_not_intersect, 5) :- not(does_not_intersect(bridge(1, (0, 1), (2, 1)), bridge(1, (1, 0), (1, 2)))).

test(no_bridges_intersect).
test(no_bridges_intersect, 1) :- no_bridges_intersect([]).
test(no_bridges_intersect, 2) :- no_bridges_intersect([bridge(1, (0, 0), (3, 0))]).
test(no_bridges_intersect, 3) :- no_bridges_intersect([bridge(1, (0, 0), (1, 0)), bridge(1, (1, 0), (2, 0))]).

test(islands).
test(islands, example) :- puzzle(example, P), islands(P, [island(1, 0, 0), island(3, 3, 0), island(2, 0, 3), island(4, 3, 3)]).

test(island_well_connected).
test(island_well_connected, 1) :- island_well_connected(island(1, 0, 0), [bridge(1, (0, 0), (3, 0))]).
test(island_well_connected, 2) :- not(island_well_connected(island(1, 0, 0), [bridge(2, (0, 0), (3, 0))])).
test(island_well_connected, 3) :- island_well_connected(island(2, 0, 0), [bridge(1, (0, 0), (3, 0)), bridge(1, (0, 0), (0, 3))]).

test(validate).
test_validate(Name) :- puzzle(Name, P), solution(Name, S), validate(P, S).
test(validate, example) :- test_validate(example).
test(validate, example_incorrect1) :- puzzle(example, P), not(validate(P, [bridge(1, (0, 0), (3, 0)), bridge(1, (3, 0), (3, 3)), bridge(2, (0, 3), (3, 3))])).
test(validate, example_incorrect2) :-  puzzle(example, P), not(validate(P, [bridge(1, (0, 0), (3, 0)), bridge(2, (3, 0), (3, 3)), bridge(2, (0, 3), (3, 3)), bridge(2, (1, 3), (2, 3))])).
test(validate, trivial1) :- test_validate(trivial1).
test(validate, trivial2) :- test_validate(trivial2).
test(validate, easy1) :- test_validate(easy1).
test(validate, regular1) :- test_validate(regular1).

test(resolution).
resolution_test(Name) :-
    puzzle(Name, Puzzle),
    validate(Puzzle, Sol), sort(Sol, SortedSol),
    solution(Name, RealSol), sort(RealSol, SortedSol).
test(resolution, trivial1) :- resolution_test(trivial1).
test(resolution, trivial2) :- resolution_test(trivial2).
test(resolution, example) :- resolution_test(example).


print_failures([]) :- !.
print_failures(Failures) :-
    format(' ! Tests échoués : ~w~n', [Failures]).

report(Name) :-
    findall(_, clause(test(Name, _), _), AllTests), length(AllTests, NumberOfTests),
    findall(_, ( clause(test(Name, _), Body),
                 catch(call_with_time_limit(120, Body), time_limit_exceeded, fail) ),
            PassingTests),
    findall(TestNumber, ( clause(test(Name, TestNumber), Body),
                          not(catch(call_with_time_limit(120, Body), _, fail))),
            FailingTests),
    length(PassingTests, NumberOfSuccess),
    format('~w: ~w/~w tests réussis~n', [Name, NumberOfSuccess, NumberOfTests]),
    print_failures(FailingTests).


report() :-
    findall(_, ( test(TestName), report(TestName) ), _).
