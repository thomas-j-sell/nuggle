# solutions consist of an coordinate list and a total
class Solution
  # must include:
  #   target: the total the solution must add up to to be correct
  #   minimum_size: minimum number of elements a solution must contain to be correct
  #
  # can include:
  #   element: the first element of the solution
  def initialize(target, minimum_size, element = nil)
    @target = target
    @minimum_size = minimum_size
    @element_list = []
    @element_list << element unless element.nil?
  end

  def dup
    Marshal::load(Marshal.dump(self))
  end

  # assumes element is properly formatted
  # Should be a two element array
  #   element one is a string representing coordinates in the board
  #   element two is the number at those coordinates
  #   ex: ['[0,1]', 7]
  #
  # @TODO don't allow elemets to be added if they are already a part of the solution?
  def add(element)
    @element_list << element
  end

  def print
    str = 'elements: '
    total = 0
    @element_list.each do |element|
      str += element[0] + ' '
      total += element[1]
    end
    puts str + " total: #{total}"
  end

  # a solution is complete if the sum of it's elements is greater than
  # or equal to the target total
  def complete?
    total = 0
    @element_list.each do |element|
      total += element[1]
    end
    total >= @target
  end

  # a solution is correct if the sum of it's elements is exactly equal
  # to the target total and consists of at least @mimimun_size elements
  def correct?
    total = 0
    @element_list.each do |element|
      total += element[1]
    end
    total == @target && @element_list.size >= @minimum_size
  end

  def empty?
    @element_list.empty?
  end

  def size
    @element_list.size
  end
end
