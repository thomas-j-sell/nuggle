require_relative 'board'
require_relative 'solution'

class Solver
  def initialize(board)
    @board = board
    # will hold complete & correct solutions
    @solutions = []

    # board dementions
    @height = @board.height
    @width = @board.width

    # maximum cell coordinates
    @row_max_index = @height - 1
    @col_max_index = @width - 1

    # solution criteria
    @target = @height * @width
    @min_sequence = @width - 1
  end

  # find solution chains starting with each element as the base
  def find_solutions
    @height.times do |row|
      @width.times do |col|
        solution = Solution.new(@target, @min_sequence, ["[#{row},#{col}]",@board[row][col]])

        # begin with board[row][col]
        # start chaining up and work around clock wise
        #   ignore cells that are included in current solution
        add_to_chain(solution, row, col)

      end
    end
    # print_solutions
    @solutions
  end

  def print_solutions
    puts "-------------------------------------------------"
    @solutions.each do |solution|
      @board.print
      solution.print
    end
  end

  def check_for_duplicate_solutions(solution)
    @solutions.each do |existing_solution|
      return true if solution.eql? existing_solution
    end
    false
  end

  # recursivly build solution chains, adding correct one to solution list
  def add_to_chain(solution, cur_row, cur_col)
    cur_element = ["[#{cur_row},#{cur_col}]",@board[cur_row][cur_col]]

    # repeat for each direction a new element could be
    8.times do |iteration|

      # ensure next_row/next_col get reset each iteration
      next_row = cur_row
      next_col = cur_col

      if !solution.complete?
        case iteration
        when 0
          # traverse north
          next_row = cur_row - 1 unless cur_row == 0
        when 1
          # traverse northeast
          unless cur_row == 0 || cur_col == @col_max_index
            next_row = cur_row - 1
            next_col = cur_col + 1
          end
        when 2
          # traverse east
          next_col = cur_col + 1 unless cur_col == @col_max_index
        when 3
          # traverse southeast
          unless cur_col == @col_max_index || cur_row == @row_max_index
            next_row = cur_row + 1
            next_col = cur_col + 1
          end
        when 4
          # traverse south
          next_row = cur_row + 1 unless cur_row == @row_max_index
        when 5
          # traverse southwest
          unless cur_col == 0 || cur_row == @row_max_index
            next_row = cur_row + 1
            next_col = cur_col - 1
          end
        when 6
          # traverse west
          next_col = cur_col - 1 unless cur_col == 0
        when 7
          # traverse northwest
          unless cur_row == 0 || cur_col == 0
            next_row = cur_row - 1
            next_col = cur_col - 1
          end
        else
          # something went horribly wrong
        end

        next_element = ["[#{next_row},#{next_col}]",@board[next_row][next_col]]
        unless cur_element == next_element or solution.include? next_element
          duplicate_solution = solution.dup
          duplicate_solution.add next_element
          add_to_chain(duplicate_solution, next_row, next_col)
        end
      elsif solution.correct?
        @solutions << solution unless check_for_duplicate_solutions solution
      end
    end
  end
end
