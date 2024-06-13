# TP3 : Programmation logique -- Casse-tête combinatoire

Le but de ce TP est de mettre en pratique les concepts de programmation logique appris pendant le cours en implémentant un programme de vérification et de résolution pour un casse-tête combinatoire.

Le travail est à réaliser **individuellement**, et la date limite ainsi que les modalités de remises sont détaillées à la fin de cet énoncé.

## Dépôt git

Avant tout, vous pouvez télécharger un squelette de l'énoncé depuis le dépôt `git` suivant : https://gitlab.info.uqam.ca/inf6120/242-TP3

**Attention : ne pas faire de fork public de ce dépôt** (règlement 18).

## Dépendances

Il n'y a pas de dépendances particulières pour ce TP, à part qu'il doit rouler sur SWI-Prolog.

## Casse-tête combinatoire "Bridges"

Dans ce TP, on souhaite écrire un vérificateur de solution pour le casse-tête combinatoire [bridges](https://www.chiark.greenend.org.uk/~sgtatham/puzzles/js/bridges.html).

Dans ce casse-tête, on dispose d'une grille de taille `NxN` représentant plusieurs îles séparées par de l'eau. Chaque case peut donc contenir soit une île, représentée par un nombre positif, soit de l'eau.
Par exemple, avec `N = 4`, un casse-tête pourrait être le suivant, où `~` représente de l'eau :

```
1 ~ ~ 3
~ ~ ~ ~
~ ~ ~ ~
2 ~ ~ 4
```

Le but est de connecter les îles entre elles avec des ponts qui peuvent soit être des *ponts simples*, soit être des *ponts doubles*. Le nombre indiqué dans chaque île indique combien de connexion celle-ci doit avoir. Les ponts simples ont un poids de 1 en terme de connexion, et les ponts doubles ont un poids de 2. Dans notre exemple, l'île `1` donc avoir une connexion avec un pont simple, alors que l'île `2` peut avoir une connexion avec deux ponts simples, ou une connexion avec un pont double. Il ne peut pas y avoir de ponts plus grands que des ponts doubles, et les ponts ne peuvent pas se croiser.

Une solution pour notre exemple serait la suivante, où `-` représente un pont simple, et `=` et `║` représentent un pont double :

```
1 - - 3
~ ~ ~ ║
~ ~ ~ ║
2 = = 4
```

Vous devez écrire un programme Prolog qui permet de vérifier des solutions et résoudre des casse-tête de ce type.

## Représentation en Prolog

### Représentation d'un casse-tête
On représente un casse-tête d'exemple en Prolog par un fait ayant la forme `puzzle(Nom, Grille)` où

- `Nom` est un nom unique à ce casse-tête,
- `Grille` est la grille du casse-tête, où des nombres strictement positifs représentent des îles, et des 0 représentent l'eau.

Le casse-tête d'exemple se représente donc par :

```prolog
puzzle(exemple, [
  [1, 0, 0, 3],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [2, 0, 0, 4]
]).
```

### Représentation d'une solution

Une solution potentielle a un casse-tête sera représentée sous forme de liste de ponts, par exemple :

```prolog
[
  bridge(1, (0, 0), (3, 0)),
  bridge(2, (3, 0), (3, 3)),
  bridge(2, (0, 3), (3, 3))
]
```

Un pont est donc représenté par une structure `bridge(Taille, Origine, Destination)` où :

- la `Taille` est 1 pour un pont simple, 2 pour un pont double,
- l'`Origine` est la coordonnée d'origine du pont,
- la `Destination` est la coordonnée de destination du pont.

Les coordonnées :
  - commencent à `(0, 0)`, qui est la case en haut à gauche du casse-tête,
  - incrémente vers la droite pour le premier composant, donc `(3, 0)` correspond à la case en haut à droite du casse-tête d'exemple,
  - incrémente vers le bas pour le second composant, donc `(0, 3)` correspond à la case en bas à gauche du casse-tête d'exemple.

On a les contraintes suivantes pour chaque pont :

- leur taille ne peut être que simple ou double
- ils doivent partir d'une case dans le casse-tête, et arriver à une case dans le casse-tête
- ils doivent être droits (soit verticaux, soit horizontaux)
- ils ne peuvent aller que vers la droite ou vers le bas

Les ponts suivants sont donc invalides pour un casse-tête de taille 4 :

``` prolog
bridge(0, (0, 0), (3, 0)) % taille trop petite
bridge(3, (0, 0), (3, 0)) % taille trop grande
bridge(1, (-1, 0), (3, 0)) % démarre hors du casse-tête
bridge(1, (0, 0), (5, 0)) % termine hors du casse-tête
bridge(1, (0, 0), (1, 1)) % est en diagonale
bridge(1, (3, 0), (0, 0)) % est représenté de droite à gauche
bridge(1, (3, 3), (3, 0)) % est représenté de bas en haut
```

## Structure du fichier `tp3.pl` et suite de tests

Le fichier [tp3.pl](tp3.pl) contient la liste des relations que vous devez définir.
Les relation à compléter sont annotées avec la ligne `TODO: à compléter`, suivit d'un `fail.`. Vous pouvez ajouter des relations supplémentaires ainsi qu'étendre les relations à définir sur plusieurs clauses.
Les relations à définir sont décrites dans la suite de ce document.

Pour certaines des relations, vous avez une suite de test qui est définie pour vous aider à valider votre implémentation. Ces suites de tests vous serviront de spécification pour votre implémentation.

Pour lancer la suite de test, par exemple la suite `puzzle_valid` qui teste la relation `puzzle_valid/1`, vous pouvez lancer ceci depuis `swipl` :

```prolog
?- [tp3].
?- run_tests(puzzle_valid).
```

## Vérifier la validité d'un casse-tête : `puzzle_valid/1`

Définir une relation `puzzle_valid/1` qui détermine la validité d'un casse-tête, représenté par une grille.
Un casse-tête est valide si :

- il est représenté par une grille de taille `NxN` pour un certain `N`
- chaque case est un nombre, étant soit 0 pour représenter de l'eau, soit un entier positif inférieur ou égal à 8 pour représenter une île.

## Vérifier la légalité d'une solution : `solution_legal/2`

Définir une relation `solution_legal/2` qui détermine si une solution est *légale*, c'est-à-dire qu'elle est construite de la bonne façon, mais qu'on ne vérifie pas que c'est une solution à un casse-tête en particulier.
Concrètement, une solution est légale si :

- c'est une suite de ponts représentés par des structures `bridge(Taille, Origine, Destination)` décrite ci-dessus
- les ponts sont droits (soit verticaux, soit horizontaux)
- les ponts sont dans les bornes
- les ponts ont des tailles valides (soit 1, soit 2).
- les ponts ne sont représentés que de gauche à droite ou de haut en bas

La relation `solution_legal/2` est utilisée comme ceci : `solution_legal(N, Solution)`, où `N` est la taille du casse-tête, et `Solution` est la solution proposée.


## Vérifier les connexions : `connects/2`

Définir une relation `connects/2` qui s'assure qu'un pont connecte deux îles dans un casse-tête.
La relation `connects/2` est utilisée comme ceci : `connects(Puzzle, Bridge)` où `Puzzle` est la grille du casse-tête, et `Bridge` représente un pont.

## Vérifier l'absence d'intersection : `does_not_intersect/2` et `no_bridges_intersect/1`

Définir une relation `does_not_intersect/2` qui s'assure que deux ponts ne se croisent pas.
On ne considère pas que des ponts rejoignant la même île se croise.

Ensuite, définir une relation `no_bridges_intersect/1` qui s'assure qu'aucun pont dans une liste de ponts ne se croise avec un autre pont de la liste.

## Extraire la liste des îles : `islands/2`

Définir une relation `islands/2` qui associe à la grille d'un casse-tête, une représentation de chacune de ses îles sous la forme `island(N, X, Y)` où `N` est le nombre de connexion attendues pour cette île, et `X` et `Y` sont les coordonnées de cette île.
La relation `islands/2` est utilisée comme ceci : `islands(Puzzle, Islands)` où `Puzzle` est la grille du casse-tête, et `Islands` est la liste des îles.

## Vérifier qu'une île est connectée comme demandé : `island_well_connected/2`

Définir une relation `island_well_connected/2` qui s'assure que les contraintes imposées par une île (le nombre de connexions attendues) sont bien satisfaites par une solution.
La relation `island_well_connected/2` est utilisée comme ceci : `island_well_connected(Island, Solution)`, où `Island` est une île au même format qu'utilisé dans `islands/2`, et `Solution` est une solution.

## Vérifier qu'une solution est correcte : `validate/2`

Finalement, définir une relation `validate/2` qui valide une solution pour un casse-tête.
La relation `validate/2` est utilisée comme ceci : `validate(Puzzle, Solution)` où `Puzzle` est la grille du casse-tête, et `Solution` est la liste de ponts qui forme la solution.

## Résoudre un casse-tête

Finalement, il faut s'assurer que l'on peut utiliser la relation `validate/2` pour résoudre un casse-tête. En faisant une requête comme `puzzle(example, Puzzle), validate(Puzzle, Solution)`, votre implémentation devrait pouvoir générer la solution attendue.

TODO: mettre en place des puzzles plus complexes

## Évaluation
### Fonctionnalités

Votre programme sera évalué en terme de fonctionnalités sur les trois critères suivants.

- Si le programme ne compile pas ou ne roule pas en effectuant les étapes décrites dans "Exécution de la solution", une note de 0 sera attribuée au TP.
- Une note sera attribuée en fonction du nombre de tests de la suite de tests publics qui passent.
- Une note sera attribuée en fonction du nombre de tests de la suite de tests privées qui passent. Assurez-vous donc que votre code soit correct au delà de la suite de tests publics.

### Qualité du code
Votre programme sera évalué en terme de qualité de code selon les règles de bonne pratiques générales à tout langage. En particulier, il est important d'éviter la duplication de code, des définitions de relations trop longues, la présence de *warning*. La présence de documentation est importante.

### Exécution de la solution

Le script `correction.pl` sera utilisé pour la correction.
En plus des tests décrits plus haut, vous pouvez vérifier que votre implémentation roule bien avec le script de correction.
Pour ce faire, il faut charger le script de correction dans `swipl` et appeler `report`.

```sh
$ git clone https://gitlub.info.uqam.ca/inf6120/242-TP3
$ cd 242-TP3/
$ cp /chemin/vers/tp3.pl tp3.pl
$ swipl
?- [correction].
?- report.
```

Lors de la correction, des tests supplémentaires seront présents dans le fichier de correction.

### Date de remise
Le TP est à remettre pour le dimanche **11 août 2024 à 23:59**

À partir de minuit, une pénalité de **2 points par heure entamée** sera appliqué, avec un retard maximal
de **24 heures**. Un travail remis à 00:00 ou 00:59 aura donc une pénalité de 2 points,
tandis qu'un travail remis à 01:00 aura une pénalité de 4 points.

**Aucune remise par courriel ne sera acceptée**. Une remise au delà de 24 heures
après la date limite ne sera pas acceptée.

## Modalités de remise

On vous demande de ne remettre **que** le fichier `tp3.pl`, à l'emplacement prévu dans le Moodle du cours.

Vérifiez bien les éléments suivants lors de votre remise :

- [ ] Le fichier `tp3.pl` contient votre nom et votre code permanent
- [ ] Le fichier charge sans erreur ni *warning* dans `swipl` avec la commande `[tp3]`
- [ ] Le code suit les bonnes pratiques en terme de style
- [ ] Le code est documenté
- [ ] Les tests passent en lançant `run_tests.` après avoir chargé votre fichier dans `swipl`
- [ ] Le script de correction fonctionne comme attendu (cf. plus haut)

