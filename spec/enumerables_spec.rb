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
end
