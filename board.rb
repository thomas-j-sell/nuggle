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

  def initialize(width, height)
    @width = width
    @height = height
    @board = []

    height.times do
      row = []
      width.times do
        row << random_integer
      end
      @board << row
    end

    @board
  end

  def print
    @board.each do |row|
      puts row[0].to_s + " " + row[1].to_s + " " + row[2].to_s
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
