# Board
# Generates a nuggle board with the specified dementions
#
# Note:
#   elements are accessed with a coordinate system starting in the upper
#   left corner of the board
#   Ex: the 1 in the following board would be accessed by board_variable[0][0]
#       the 4 in the following board would be accessed by board_variable[1][0]
#       the 9 in the following board would be accessed by board_variable[2][2]
#   1 2 3
#   4 5 6
#   7 8 9
class Board
  attr_reader :width, :height

  # a board can be passed in to allow manual control for testing
  def initialize(width, height, board = nil)
    @width = width
    @height = height

    if board.nil?
      @board = []

      height.times do
        row = []
        width.times do
          row << random_integer
        end
        @board << row
      end
    else
      @board = board
    end
  end

  def print
    @board.each do |row|
      row.each do |element|
        # STDOUT necessary because namespace collision
        STDOUT.print element.to_s + " "
      end
      STDOUT.print "\n"
    end
  end

  def [](row)
    @board[row]
  end

  private
  def random_integer
    Random.rand(10)
  end
end
