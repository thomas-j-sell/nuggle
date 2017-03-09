# Nuggle
### Number Boggle
This is an solution for problem three of IGN's Code Foo 7 entry application.  The rest of my application can be found [here](https://github.com/thomas-j-sell/codefoo7).  The purpose of the program is to create a game board consisting of random whole positive numbers and then find all combinations of adjacent numbers that add up to the grid's area (more detailed explanation of rules criteria below).

This program can be run from the command line in the projects root directory with the command:

```ruby nuggle.rb```

This will generate a puzzle with default dimensions (3x3), find the solutions, and print both the game board and solutions to the console.  Output will appear similar to this:

```
6 3 6 
5 5 0 
0 2 4 
-------------------------------------------------
elements: [0,0]6 [0,1]3  total: 9
elements: [0,1]3 [0,2]6  total: 9
elements: [0,1]3 [1,2]0 [0,2]6  total: 9
elements: [0,1]3 [1,2]0 [2,2]4 [2,1]2  total: 9
elements: [1,1]5 [1,2]0 [2,2]4  total: 9
elements: [1,1]5 [2,2]4  total: 9
elements: [1,2]0 [0,1]3 [0,0]6  total: 9
elements: [2,0]0 [1,1]5 [1,2]0 [2,2]4  total: 9
elements: [2,0]0 [1,1]5 [2,2]4  total: 9
elements: [2,0]0 [2,1]2 [2,2]4 [1,2]0 [0,1]3  total: 9
Number of solutions: 10
```



Nuggle can be instructed to generate and solve game boards of various sizes by provided the command with arguments.

```ruby nuggle.rb 4``` will create and solve a 4x4 board

```ruby nuggle 2 3``` will create and solve a 2x3 (width, height) board

**NOTE**: puzzles with dimensions greater than 4 can take a very long time to solve.  When you attempt to solve such a puzzle the program will warn you and ask for confirmation before continuing (you must enter ```y``` to continue).

### Requirements
Taken from: http://www.ign.com/code-foo/2017/

Create a program that generates and displays a 3x3 grid of random whole positive numbers (n) where 0 <= n <= 9. The program should then find all possible combinations of numbers that add up to the area of the grid using these rules (similar to Boggle™):
  a. The numbers must be "chained" in sequentially adjacent cells, where "adjacent" cells are those horizontally, vertically, and diagonally neighboring

  b. The chain does not have to be in a line. For example, it could go horizontally once, then vertically once, and finally diagonally once

c. At least the “grid width - 1” cells must be used in the chain (a 3x3 grid means that at least two cells must be used)

  d. A chain cannot repeat a grid cell that it has already used

  e. Chains that use the exact same cells as a previous chain are considered repeats and should not be counted

  Grid Example:

  9 4 6

  8 1 0

  3 7 2


  Valid Answer Examples:

  7 + 2 = 9

  2 + 1 + 6 = 9

  2 + 1 + 6 + 0 = 9


  Invalid Answer Examples:

  9 = 9

  3 + 6 = 9

  1 + 7 + 1 = 9

  Explain how you implemented the solution. Can you make a version with a larger grid? How well does it scale?


### Explanation
  I broke my solution down into 4 files:

#### Board.rb
  Contains a class to represent the game board.  Provides methods to print the board to console and access elements.  New instances are created by passing in a width and a height.  The initializer will fill the board with random integers.  Alternatively you can pass in a "hand-built" matrix along with the dimensions if you want to manually control the layout of the board

#### Solution.rb
  Contains a class to represent potential solution chains.  Provides methods for appropriate mutation and querying.  Initialized with a target sum (the number elements should add to), a minimum size (smallest number of elements for a solution to be considered correct) and optionally a starting element.

#### Solver.rb
  The workhorse of the applicaton.  Initialized with a board object, it will determine board dimentions and solution criteria.  When instructed to find solutions it will "scan" the gameboard for all potential solutions and save correct solutions to an array.  Once complete those solutions can be printed to the console.

  Solution building algorithm:
  The solver employs a recursive chain-building algorithm that traverses the board in spirals oriented "clockwise".  Starting in turn with each cell it will attempt to build solutions by adding adjacent cells not already contianed in the solution.  Each time it finds an adjacent element to add, it recurses to start searching for the next element from that one.  Each time an element is added the solution is checked for "completeness", ei: the sum of its elements is greater than or equal to the target sum.  If the solution is complete, it is checked for "correctness".  "Correct solutions are saved to an array", incorrect solutions are discarded and the process continues from the previous point of "incompleteness".  If the solution is incomplete the algorithm continues searching.  This continues until all possible solutions are discovered.
  The program can theoretically scale to work on any sized grid but it does not scale well.

#### Nuggle.rb
The "main" file.  Instructions for use are at the top of this document.
