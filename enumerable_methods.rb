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
end

[1, 2, 3, 4, 5].each { |i| puts i }

[1, 2, 3, 4, 5].my_each { |element| puts element }
