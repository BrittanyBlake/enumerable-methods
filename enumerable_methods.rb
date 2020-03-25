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

  #my_select
  def my_select
    return to_enum unless block_given?

    new_array = []
    i = 0

    until i >= length
      new_array << i if yield self[i]
      i += 1
    end
  end
  #end of my_select
end

#tests
  [1, 2, 3, 4, 5].each { |i| puts i }
  [1, 2, 3, 4, 5].my_each { |element| puts element }

 [1, 2, 3, 4, 5].each_with_index { |ele, idx|  puts "#{idx}:#{ele}" }
 [1, 2, 3, 4, 5].my_each_with_index { |ele, idx|  puts "#{idx}:#{ele}"}

 [1, 2, 3, 4, 5].select { |i| p i.even? }
[3, 3, 3, 4, 5].my_select { |i| p i.even? }