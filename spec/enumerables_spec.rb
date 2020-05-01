require './lib/enumerable_methods.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'should return each element of an array' do
      expect([1, 2, 3, 4, 5].my_each { |num| puts num }).to eq([1, 2, 3, 4, 5])
      expect([1, 2, 3, 4, 5].my_each { |num| puts num }).not_to eq([1, 2, 3, 4])
    end

    it 'should not return an element that is not in the aray' do
      expect([1, 2, 3, 4, 5].my_each { |num| puts num }).not_to eq([1, 2, 3, 4, 5, 6])
    end
  end

  describe '#my_each_with_index' do
    it 'should return each element of an array and its index' do
      expect([1, 3, 2].each_with_index { |ele, idx| puts "#{idx}:#{ele}" }).to eq([1, 3, 2])
      expect([1, 3, 2].each_with_index { |ele, idx| puts "#{idx}:#{ele}" }).not_to eq([1, 2, 3])
    end
  end

  describe '#my_select' do
    it 'shoudld return a new array containing all elements for which the block returns true' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eq([2, 4])
      expect([1, 2, 3, 4, 5].my_select(&:odd?)).to eq([1, 3, 5])
      expect([1, 2, 3, 4, 5].my_select(&:even?)).not_to eq([2])
      expect([1, 2, 3, 4, 5].my_select(&:odd?)).not_to eq([1, 3])
    end

    it 'should not return a new array containing elements for which the block returns false' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).not_to eq([1, 3, 5])
      expect([1, 2, 3, 4, 5].my_select(&:odd?)).not_to eq([2, 4])
      expect([1, 2, 3, 4, 5].my_select(&:even?)).not_to eq([2, 4, 6])
      expect([1, 2, 3, 4, 5].my_select(&:odd?)).not_to eq([1, 2, 3, 4, 5])
    end
  end

  describe '#my_all?' do
    it 'should return true if the array is empty' do
      expect([].my_all?).to eq(true)
    end

    it 'should return true when none of the elements are false or nil if no block is given' do
      expect([true, true, true, []].my_all?).to eq(true)
    end

    it 'should return false if one or more of the elements is false or nil and no block is given' do
      expect([nil, false, true, []].my_all?).to eq(false)
    end

    it 'should return false if  one or more of the elements is false when passed into the block' do
      expect([2, 2, 2, 1, 5].my_all?(&:even?)).to eq(false)
      expect([2, 2, 2].my_all?(&:even?)).not_to eq(false)
    end

    context 'when a class is passed as an argument' do
      it 'should return true if all of the elements in the collection is a member' do
        expect([1, 2.5, 'a', 9].my_all?(Integer)).not_to eq(true)
        expect([1, 2.5, 5, 9].my_all?(Integer)).not_to eq(true)
        expect([1, 25, 5, 9].my_all?(Integer)).to eq(true)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'should return true if all the elements matches the Regex' do
        expect(%w[dog door rod blade].my_all?(/d/)).to eq(true)
        expect(%w[dog boor rod blade].my_all?(/d/)).not_to eq(true)
      end
    end

    context 'when a pattern other than a Regex or a Class is given' do
      it 'should return true if all of the collection matches the pattern' do
        expect([3, 4, 7, 11].my_all?(3)).not_to eq(true)
      end
    end
  end

  describe '#my_any?' do
    it 'should return false if the array is empty' do
      expect([].my_any?).to eq(false)
    end

    it 'should return true when at least one element of the collection is not false or nil if no block is given' do
      expect([nil, false, true, []].my_any?).to eq(true)
    end

    context 'when a class is passed as an argument' do
      it 'should return true if at least one of the elements in the collection is a member' do
        expect([1, 2.5, 'a', 9].my_any?(Integer)).to eq(true)
        expect([1, 2.5, 5, 9].my_any?(Integer)).to eq(true)
        expect([1, 25, 5, 9].my_any?(Integer)).to eq(true)
        expect([2.5, 'a'].my_any?(Integer)).not_to eq(true)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'should return false if none the elements matches the Regex' do
        expect(%w[dog door rod blade].my_any?(/z/)).to eq(false)
        expect(%w[dog boor rod blade].my_any?(/d/)).not_to eq(false)
        expect(%w[dog door rod blade].my_any?('cat')).to eq(false)
      end
    end

    context 'when a pattern other than a Regex or a Class is given' do
      it 'should return false if none of the collection matches the pattern' do
        expect([3, 4, 7, 11].my_any?(3)).not_to eq(false)
        expect([4, 7, 11].my_any?(3)).to eq(false)
      end
    end
  end

  describe '#my_none?' do
    it 'should return true if the array is empty' do
      expect([].my_none?).to eq(true)
    end

    it 'should return false when at least one element of the collection is not false or nil if no block is given' do
      expect([nil, false, true, []].my_none?).to eq(false)
    end

    context 'when a class is passed as an argument' do
      it 'should return true if none of the elements in the collection is a true' do
        expect([1, 2.5, 'a', 9].my_none?(Integer)).not_to eq(true)
        expect([1, 2.5, 5, 9].my_none?(Integer)).not_to eq(true)
        expect([1, 25, 5, 9].my_none?(Integer)).not_to eq(true)
        expect([2.5, 'a'].my_none?(Integer)).to eq(true)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'should return true if none the elements matches the Regex' do
        expect(%w[dog door rod blade].my_none?(/z/)).to eq(true)
        expect(%w[dog boor rod blade].my_none?(/d/)).not_to eq(true)
        expect(%w[dog door rod blade].my_none?('cat')).to eq(true)
      end
    end

    context 'when a pattern other than a Regex or a Class is given' do
      it 'should return true if none of the collection matches the pattern' do
        expect([3, 4, 7, 11].my_none?(3)).not_to eq(true)
        expect([4, 7, 11].my_none?(3)).to eq(true)
      end
    end
  end

  describe '#my_count' do
    it 'should return the number of elements in an array' do
      expect([2, 2, 2, 1, 5].my_count).to eq(5)
    end

    it 'should return the number of elements that satisfy the argument or block given' do
      expect([1, 2, 3].my_count(&:even?)).to eq(1)
      expect([1, 2, 3].my_count(2)).to eq(1)
      expect([-1, 1, -2, 2, -3].my_count { |ele| ele < 0 }).to eq(3)
    end

    it 'should not return the wrong number of elements' do
      expect([2, 2, 2, 1, 5].my_count).not_to eq(6)
      expect([1, 2, 3].my_count(&:even?)).not_to eq(2)
      expect([1, 2, 3].my_count(2)).not_to eq(3)
      expect([-1, 1, -2, 2, -3].my_count { |ele| ele < 0 }).not_to eq(2)
    end
  end

  describe '#my_map' do
    my_proc = proc { |num| num > 10 }
    it 'should return a new array that satisfies the block or argument passed' do
      expect([5, 2, 1].my_map { |x| x * 2 }).to eq([10, 4, 2])
      expect([18, 22, 5, 6].my_map(my_proc)).to eq([true, true, false, false])
      expect(%w[this is a test].my_map(&:upcase)).to eq(%w[THIS IS A TEST])
    end

    it 'should not return new array where all the elements do not satisfy the block or argument passed' do
      expect([5, 2, 1].my_map { |x| x * 2 }).not_to eq([5, 2, 1])
      expect([18, 22, 5, 6].my_map(my_proc)).not_to eq([false, true, false, false])
      expect(%w[this is a test].my_map(&:upcase)).not_to eq(%w[This IS a TEST])
    end
  end

  describe '#my_inject' do
    it 'should select the first item of the array to be the initial value when no initial value is passed' do
      expect([5, 2, 1].my_inject { |result, x| result + x }).to eq(8)
      expect([5, 2, 1].my_inject { |result, x| result * x }).to eq(10)
    end

    it 'should use the given value as the initial value when an initial value is passed' do
      expect([5, 2, 1].my_inject(2) { |result, x| result + x }).to eq(10)
      expect([5, 2, 1].my_inject(2) { |result, x| result * x }).to eq(20)
    end

    it 'should combine all elements of enum by applying a binary operation specified by a block' do
      expect((1..5).my_inject(4) { |prod, n| prod * n }).to eq(480)
    end

    context 'when a symbol is provided as an argument' do
      it 'should combine the elements of the enum using that symbol as a named method' do
        expect([2, 5, 6].my_inject(:+)).to eq(13)
      end
    end

    it 'should not return the wrong solution' do
      expect([5, 2, 1].my_inject { |result, x| result * x }).not_to eq(8)
      expect([5, 2, 1].my_inject(2) { |result, x| result + x }).not_to eq(8)
      expect((1..5).my_inject(4) { |prod, n| prod * n }).not_to eq(48)
      expect([2, 5, 6].my_inject(:+)).not_to eq(12)
    end
  end

  describe '#multiply_els' do
    it 'should return the product of all of the elements in the array' do
      expect([2, 4, 5].multiply_els).to eq(40)
    end

    it 'should not return the incorrect product of all of the elements in the array' do
      expect([2, 4, 5].multiply_els).not_to eq(11)
    end
  end
end
