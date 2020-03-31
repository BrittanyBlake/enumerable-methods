module Enumerable
  # start of my_ech
  def my_each
    return to_enum unless block_given?

    i = 0
    until i >= length
      yield self[i]
      i += 1
    end
    self
  end
  # end of my_each

  # start of my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    until i >= length
      yield self[i], i
      i += 1
    end
    self
  end
  # end of my_each_with_index

  # my_select
  def my_select
    return to_enum unless block_given?

    new_array = []
    i = 0

    until i >= length
      new_array << i if yield self[i]
      i += 1
    end
  end
  # end of my_select

  # my_all?
  def my_all?
    my_each do |item|
      return false unless yield item
    end
    true
  end
  # end of my_all?

  # my_any?
  def my_any?
    my_each do |item|
      return true if yield item
    end
    false
  end
  # end of my_any?

  # my_none?
  def my_none?
    my_each do |item|
      return false if yield item
    end
    true
  end
  # end of my_none?

  # my_count
  def my_count
    count = 0
    my_each do |item|
      count += 1
    end
    count
  end
  # end of my_count

  # start of my_map
  def my_map
    new_array = []
    my_each do |item|
      new_array << item
    end
    new_array
  end
  # end of my_map

  # start of my_inject
  def my_inject(acc)
    my_each do |i|
      acc = yield(acc, i)
    end
    acc
  end
  # end of my_inject

  #multiply elements method
  def multiply_els
      my_inject(1) {|product, n|product * n}
  end
  #end of multiply elements method

end

# tests
# [1, 2, 3, 4, 5].each { |i| puts i }
# [1, 2, 3, 4, 5].my_each { |element| puts element }

# [1, 2, 3, 4, 5].each_with_index { |ele, idx| puts "#{idx}:#{ele}" }
# [1, 2, 3, 4, 5].my_each_with_index { |ele, idx| puts "#{idx}:#{ele}" }

# [1, 2, 3, 4, 5].select { |i| p i.even? }
# [3, 3, 3, 4, 5].my_select { |i| p i.even? }

# [2,2,2,1,5].all? {|i| p i.even?}
# [2,2,2,1,5].my_all? {|i| p i.even?}

# [2,2,2,1,5].any? {|i| p i.even?}
# [2,2,2,1,5].my_any? {|i| p i.even?}

#  [2,2,2,1,5].none? {|i| p i.even?}
#  [2,2,2,1,5].my_none? {|i| p i.even?}

# p [2, 2, 2, 1, 5].count { |i| i }
# p [2, 2, 2, 1, 5].my_count { |i| i }

# p [2, 2, 2, 1, 5].map { |i| i }
 p [2, 2, 2, 1, 5].my_map { |i| i }

# p [3, 6, 10, 13].inject(:+)
# p [3, 6, 10, 13].inject {|sum, number| sum + number}
# p [2,4,5].multiply_els 




