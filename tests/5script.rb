require 'pry'
require_relative 'board'
require_relative 'solver'

require 'benchmark'

times = []
3.times do
  times << Benchmark.realtime do
    board = Board.new(5, 5)
    board.print
    solver = Solver.new(board)
    solver.find_solutions
    puts "puzzle solved"
    # solver.print_solutions
  end
end

average = times.reduce(:+)/times.size
puts "5x5 average execution time: #{average}"
