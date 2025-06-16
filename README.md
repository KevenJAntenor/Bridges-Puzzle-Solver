# 🧩🧠 Bridges Puzzle Solver in Prolog

## 🧩 Description
This project implements a Prolog-based solver and validator for the "Bridges" puzzle game. The Bridges puzzle is a logic game where the goal is to connect islands with bridges, adhering to specific rules.

---

## ✨ Key Features
- **Puzzle Validation**: Ensures that the input puzzle grid is valid and well-formed.
- **Solution Legality Check**: Verifies if a proposed solution follows the basic rules of bridge placement.
- **Connection Verification**: Checks if bridges properly connect islands without intersecting.
- **Island Connection Validation**: Ensures each island has the correct number of connections as specified in the puzzle.
- **Complete Solution Validation**: Combines all checks to validate a full puzzle solution.
- **Puzzle Solving Capability**: Generates solutions for given puzzles using logical inference.

This implementation serves as both a tool for verifying Bridges puzzle solutions and a solver capable of generating valid solutions. It highlights the power of logic programming in solving combinatorial puzzles efficiently.

---

## 🚀 How to Run

### Prerequisites
1. Install **SWI-Prolog** on your system:
   - On Linux:
     ```bash
     sudo apt-get install swi-prolog
     ```
   - On macOS (using Homebrew):
     ```bash
     brew install swi-prolog
     ```
   - On Windows, download the installer from the [official SWI-Prolog website](https://www.swi-prolog.org/).

2. Clone the repository and navigate to the project directory:
   ```bash
   git clone https://github.com/your-repo/bridges-puzzle-solver.git
   cd bridges-puzzle-solver

Running the Solver
Start the SWI-Prolog interpreter:

```bash
swipl
```
Load the main Prolog files:

```prolog
?- [main].
```
Run a specific puzzle-solving query. For example:

Validate a puzzle:
```prolog

?- validate_puzzle('path/to/puzzle.txt').
```
Solve a puzzle:
```prolog
?- solve_puzzle('path/to/puzzle.txt', 'path/to/solution.txt').
```
Exit the Prolog interpreter when done:

```prolog
?- halt.
```
📂 Project Structure
main.pl: The entry point for running and managing the solver.
puzzles.pl: Contains functions and predicates for puzzle validation, solution checking, and puzzle solving.
.DS_Store: System file (ignore this).
README.md: Documentation for the project.
