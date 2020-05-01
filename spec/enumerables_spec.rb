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
        expect([2,2,2,1,5].my_all? {|i| i.even?}).to eq(false)
        expect([2,2,2].my_all? {|i| i.even?}).not_to eq(false)
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
            expect([3,4,7,11].my_all?(3)).not_to eq(true)
        end
    end
  end
end
