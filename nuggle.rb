require 'pry'

def random_integer
  Random.rand(10)
end

def print_board(board)
  board.each do |row|
    puts row[0].to_s + " " + row[1].to_s + " " + row[2].to_s
  end
end

def find_areas(board)
  board.each do |rows|
    rows.each do |num|

    end
  end
end

board = [
  [random_integer, random_integer, random_integer],
  [random_integer, random_integer, random_integer],
  [random_integer, random_integer, random_integer],
]

print_board board
