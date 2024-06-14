:- discontiguous puzzle/2.
:- discontiguous solution/2.

% Le casse-tête d'exemple
puzzle(example, [
  [1, 0, 0, 3],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [2, 0, 0, 4]
]).

solution(example, [
  bridge(1, (0, 0), (3, 0)),
  bridge(2, (3, 0), (3, 3)),
  bridge(2, (0, 3), (3, 3))
]).

% Ce casse-tête est invalide car les nombres sont incorrects
puzzle(invalid1, [
    [0, 0],
    [-1, a]
]).

% Ce puzzle est invalide car la grille n'a pas la même longueur que largeur
puzzle(invalid2, [
    [1, 0],
    [0, 0, 0],
    [1, 0, 0]
]).

% Ce puzzle est invalide car des îles requièrent trop de ponts
puzzle(invalid3, [
    [9, 0, 0],
    [0, 0, 0],
    [1, 0, 0]
]).


% Le reste du fichier contient des puzzles valides ainsi que leur solutions

puzzle(trivial1, [
  [1, 0, 0],
  [0, 0, 0],
  [2, 0, 1]
]).

solution(trivial1, [bridge(1, (0, 0), (0, 2)), bridge(1, (0, 2), (2, 2))]).

puzzle(trivial2, [
  [1, 0, 2],
  [0, 0, 0],
  [0, 0, 1]
]).

solution(trivial2, [bridge(1, (0, 0), (2, 0)), bridge(1, (2, 0), (2, 2))]).

puzzle(easy1, [
  [2, 0, 1, 0, 0],
  [0, 0, 0, 0, 0],
  [6, 0, 4, 0, 0],
  [0, 0, 0, 0, 0],
  [4, 0, 4, 0, 1]
]).

solution(easy1, [bridge(2, (0, 0), (0, 2)), bridge(1, (2, 0), (2, 2)),
                 bridge(2, (0, 2), (2, 2)), bridge(2, (0, 2), (0, 4)),
                 bridge(1, (2, 2), (2, 4)), bridge(2, (0, 4), (2, 4)),
                 bridge(1, (2, 4), (4, 4))]).

puzzle(regular1, [
  [3, 0, 5, 0, 0, 3, 0],
  [0, 0, 0, 2, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 3, 0, 0, 0, 0],
  [1, 0, 0, 3, 0, 2, 0],
  [0, 0, 4, 0, 0, 0, 3]
]).

solution(regular1, [bridge(2, (0, 0), (2, 0)), bridge(1, (0, 0), (0, 5)), bridge(2, (2, 0), (5, 0)),
                    bridge(1, (2, 0), (2, 4)), bridge(1, (5, 0), (5, 5)), bridge(2, (3, 1), (3, 5)),
                    bridge(1, (6, 1), (6, 6)), bridge(2, (2, 4), (2, 6)), bridge(1, (3, 5), (5, 5)),
                    bridge(2, (2, 6), (6, 6))]).
