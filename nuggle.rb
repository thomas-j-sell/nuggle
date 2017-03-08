require 'pry'
require_relative 'board'
require_relative 'solver'

width = ARGV[0] ? ARGV[0].to_i : 3
height = ARGV[1] ? ARGV[1].to_i : width

if width > 4 or height > 4
  puts "puzzles with dimensions greater than four can take a long time to process.  Continue [y/n]"
  x = STDIN.gets.chomp
  exit unless x == 'y'
end

board = Board.new(width, height)
board.print

solver = Solver.new(board)
solver.find_solutions
solver.print_solutions
