require 'pry'
require 'minitest/autorun'
require_relative "../solver.rb"

class TestSolution < Minitest::Test

  def test_initialize
    input_board = [[8,1,7],[7,7,7],[7,7,7]]
    board = Board.new(3, 3, input_board)
    # board.print
    solver = Solver.new(board)
    solutions = solver.find_solutions
    # solver.print_solutions
    assert_equal 1, solutions.size
  end

  def test_single_solution_different_configurations
    input_board = [[7,7,7],[8,7,7],[7,1,7]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 1, solutions.size

    input_board = [[1,7,7],[8,7,7],[7,7,7]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 1, solutions.size

    input_board = [[7,7,3],[7,6,7],[7,7,7]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 1, solutions.size
  end

  def test_no_solutions
    input_board = [[7,7,7],[7,7,7],[7,7,7]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 0, solutions.size

    input_board = [[7,7,1],[7,7,7],[8,7,7]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 0, solutions.size
  end

  def test_man_soutions
    input_board = [[3,4,7],[6,8,1],[8,1,0]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 11, solutions.size

    input_board = [[9,5,6],[1,4,9],[7,0,2]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 4, solutions.size

    input_board = [[6,2,3],[4,2,8],[0,5,9]]
    board = Board.new(3, 3, input_board)
    solver = Solver.new(board)
    solutions = solver.find_solutions
    assert_equal 8, solutions.size
    end
end
