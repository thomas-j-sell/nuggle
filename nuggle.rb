require 'pry'
require_relative 'board'
require_relative 'solver'

board = Board.new(3, 3)

board.print

solver = Solver.new(board)
solver.find_solutions
solver.print_solutions
