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
    solutions = []
    @height.times do |row|
      @width.times do |col|
        solution = Solution.new(@target, @min_sequence, ["[#{row},#{col}]",@board[row][col]])

        # begin with board[row][col]
        # start chaining up and work around clock wise
        #   ignore cells that are included in current solution
        add_to_chain(solution, row, col)

      end
    end
    #@TODO do a better uniniqueness thing
    # @solutions.uniq!
    print_solutions
  end

  def print_solutions
    puts "-------------------------------------------------"
    @solutions.each do |solution|
      @board.print
      solution.print
    end
  end

  # recursivly build solution chains, adding correct one to solution list
  def add_to_chain(solution, cur_row, cur_col)
    cur_element = ["[#{cur_row},#{cur_col}]",@board[cur_row][cur_col]]

    # repeat for each direction a new element could be
    8.times do |iteration|
      solution.print
      @board.print
      puts "current cell [#{cur_row},#{cur_col}] #{@board[cur_row][cur_col]}"
      if !solution.complete?
        case iteration
        when 0
          # traverse north
          if cur_row == 0
            puts "can't traverse north"
          else
            puts "next cell is #{@board[cur_row - 1][cur_col]}"
            cur_row -= 1
          end
        when 1
          # traverse northeast
          if cur_row == 0 || cur_col == @col_max_index
            puts "can't traverse northeast"
          else
            puts "next cell is #{@board[cur_row - 1][cur_col + 1]}"
            cur_row -= 1
            cur_col += 1
          end
        when 2
          # traverse east
          if cur_col == @col_max_index
            puts "can't traverse east"
          else
            puts "next cell is #{@board[cur_row][cur_col + 1]}"
            cur_col += 1
          end
        when 3
          # traverse southeast
          if cur_col == @col_max_index || cur_row == @row_max_index
            puts "can't traverse southeast"
          else
            puts "next cell is #{@board[cur_row + 1][cur_col + 1]}"
            cur_row += 1
            cur_col += 1
          end
        when 4
          # traverse south
          if cur_row == @row_max_index
            puts "can't traverse south"
          else
            puts "next cell is #{@board[cur_row + 1][cur_col]}"
            cur_row += 1
          end
        when 5
          # traverse southwest
          if cur_col == 0 || cur_row == @row_max_index
            puts "can't traverse southeast"
          else
            puts "next cell is #{@board[cur_row + 1][cur_col - 1]}"
            cur_row += 1
            cur_col -= 1
          end
        when 6
          # traverse west
          if cur_col == 0
            puts "can't traverse east"
          else
            puts "next cell is #{@board[cur_row][cur_col - 1]}"
            cur_col -= 1
          end
        when 7
          # traverse northwest
          if cur_row == 0 || cur_col == 0
            puts "can't traverse northeast"
          else
            puts "next cell is #{@board[cur_row - 1][cur_col - 1]}"
            cur_row -= 1
            cur_col -= 1
          end
        else
          # something went horribly wrong
        end

        next_element = ["[#{cur_row},#{cur_col}]",@board[cur_row][cur_col]]
        unless cur_element == next_element or solution.include? next_element
          duplicate_solution = solution.dup
          duplicate_solution.add next_element
          add_to_chain(duplicate_solution, cur_row, cur_col)
        end
      elsif solution.correct?
        # binding.pry
        @solutions << solution unless @solutions.include? solution
      end
    end
  end
end
