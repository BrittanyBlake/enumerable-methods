module Enumerable
   #start of my_ech
  def my_each
    return to_enum unless block_given?

    i = 0
    until i >= length
      yield self[i]
      i += 1
    end
    self
  end
  #end of my_each
   #start of my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    until i >= length
      yield self[i], i
      i += 1
    end
    self
  end
  #end of my_each_with_index
end


#tests
 [1, 2, 3, 4, 5].each { |i| puts i }
 [1, 2, 3, 4, 5].my_each { |element| puts element }

[1, 2, 3, 4, 5].each_with_index { |ele, idx|  puts "#{idx}:#{ele}" }
[1, 2, 3, 4, 5].my_each_with_index { |ele, idx|  puts "#{idx}:#{ele}"}