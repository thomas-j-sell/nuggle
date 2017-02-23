require 'pry'
require 'minitest/autorun'
require_relative "../solution.rb"

class TestSolution < Minitest::Test

  def test_initialize
    sol = Solution.new(9, 2)
    refute_nil sol
  end

  def test_add
    sol = Solution.new(9, 2)
    assert sol.empty?
    sol.add ['[0,0]', 7]
    refute sol.empty?
    assert_equal sol.size, 1
    sol.add ['[0,1]', 1]
    assert_equal sol.size, 2
  end

  def test_complete
    sol = Solution.new(9, 2)
    sol.add ['[0,0]', 9]
    assert sol.complete?

    sol2 = Solution.new(9, 2)
    sol2.add ['[0,0]', 8]
    sol2.add ['[0,1]', 1]
    assert sol2.complete?

    sol3 = Solution.new(9, 2)
    sol3.add ['[0,0]', 8]
    sol3.add ['[0,1]', 3]
    assert sol3.complete?

    sol4 = Solution.new(9, 2)
    refute sol4.complete?

    sol5 = Solution.new(9, 2)
    sol5.add ['[0,1]', 3]
    refute sol5.complete?

    sol6 = Solution.new(9, 2)
    sol6.add ['[0,1]', 3]
    sol6.add ['[1,1]', 5]
    refute sol6.complete?
  end

  def test_correct
    # not enough elements
    sol = Solution.new(9, 2)
    sol.add ['[0,0]', 9]
    refute sol.correct?

    # legit correct
    sol2 = Solution.new(9, 2)
    sol2.add ['[0,0]', 7]
    sol2.add ['[0,1]', 2]
    assert sol2.correct?

    # total to small
    sol3 = Solution.new(9, 2)
    sol3.add ['[0,0]', 6]
    sol3.add ['[0,1]', 2]
    refute sol3.correct?

    # total to large
    sol4 = Solution.new(9, 2)
    sol4.add ['[0,0]', 6]
    sol4.add ['[0,1]', 2]
    sol4.add ['[0,2]', 3]
    refute sol4.correct?
  end

  def test_duplicate
    sol = Solution.new(9, 2)
    sol.add ['[0,0]', 2]
    assert_equal sol.size, 1
    sol2 = sol.dup
    sol2.add ['[0,1]', 3]
    assert_equal sol.size, 1
    assert_equal sol2.size, 2
  end

  def test_comparison
    sol = Solution.new(9, 2)
    sol.add ['[0,0]', 2]
    sol.add ['[0,1]', 3]
    sol2 = Solution.new(9, 2)
    sol2.add ['[0,0]', 2]
    sol2.add ['[0,1]', 3]
    assert sol == sol2
   end
end
