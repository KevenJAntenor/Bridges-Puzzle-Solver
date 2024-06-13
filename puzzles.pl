% Ce casse-tête est invalide car les nombres sont incorrects
puzzle(invalid1, [
    [0, 0],
    [-1, a]
]).

% Ce puzzle est invalide car la grille n'a pas la même longueur que largeur
puzzle(invalid2, [
    [1, 0],
    [0, 0, 0],
    [1, 0, 0],
]).

% Ce puzzle est invalide car des îles requièrent trop de ponts
puzzle(invalid3, [
    [9, 0, 0],
    [0, 0, 0],
    [1, 0, 0],
]).


puzzle(exemple, [
  [1, 0, 0, 3],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [2, 0, 0, 4]
]).
