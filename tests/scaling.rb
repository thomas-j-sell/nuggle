require 'pry'
require_relative '../board'
require_relative '../solver'

require 'benchmark'

times = []
100.times do
  times << Benchmark.realtime do
    board = Board.new(2, 2)
    solver = Solver.new(board)
    solver.find_solutions
  end
end

average = times.reduce(:+)/times.size
puts "2x2 average execution time: #{average}"

times = []
100.times do
  times << Benchmark.realtime do
    board = Board.new(3, 3)
    solver = Solver.new(board)
    solver.find_solutions
  end
end

average = times.reduce(:+)/times.size
puts "3x3 average execution time: #{average}"

times = []
100.times do
  times << Benchmark.realtime do
    board = Board.new(4, 4)
    solver = Solver.new(board)
    solver.find_solutions
  end
end

average = times.reduce(:+)/times.size
puts "4x4 average execution time: #{average}"

times = []
2.times do
  times << Benchmark.realtime do
    board = Board.new(5, 5)
    solver = Solver.new(board)
    solver.find_solutions
    # solver.print_solutions
  end
end

average = times.reduce(:+)/times.size
puts "5x5 average execution time: #{average}"
