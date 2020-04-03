module Enumerable
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # start of my_each
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
      new_array << self[i] if yield self[i]
      i += 1
    end
    new_array
  end
  # end of my_select

  # my_all?
  def my_all?(arg = nil, &block)
    if block_given?
      my_each do |item|
        return false unless block.call(item)
      end
    elsif arg.nil?
      my_each do |item|
        return false unless item
      end
    elsif arg.class == Class
      my_each do |item|
        return false unless item.is_a?(arg)
      end
    elsif arg.class == Regexp
      my_each do |item|
        return false unless item =~ arg
      end
    else
      my_each do |item|
        return false unless item == arg
      end
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
  def my_count(arg = nil)
    count = 0

    if block_given?
      my_each do |ele|
        count += 1 if yield(ele) == true
      end

    elsif arg.nil?
      my_each do |_ele|
        count += 1
      end

    else
      my_each do |ele|
        count += 1 if ele == arg
      end
    end
    count
  end
  # end of my_count

  # start of my_map

  def my_map(_proc = nil)
    new_array = []
    my_each do |item|
      return to_enum unless block_given?

      new_array << yield(item)
    end
    new_array
  end

  # end of my_map

  # start of my_inject
  def my_inject(initial = nil)
    acc = if initial.nil?
            0
          else
            initial
          end

    my_each do |i|
      acc = yield(acc, i)
    end
    acc
  end
  # end of my_inject

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # multiply elements method
  def multiply_els
    my_inject(1) { |product, n| product * n }
  end
  # end of multiply elements method
end

# tests

# p [nil, false, true, []].all?
# p [nil, false, true, []].my_all?
# p [true, true, true, []].all?
# p [true, true, true, []].my_all?
# p [1, 2.5, 'a', 9].all?(Integer)
# p [1, 2.5, 'a', 9].my_all?(Integer)
# p [1, 2.5, 5, 9].all?(Integer)
# p [1, 2.5, 5, 9].my_all?(Integer)
# p [1, 25, "a", 9].all?(Integer)
# p [1, 25, "a", 9].my_all?(Integer)
# p [1, 25, 5, 9].all?(Integer)
# p [1, 25, 5, 9].my_all?(Integer)
# p %w[dog door rod blade].all?(/d/)
# p %w[dog door rod blade].my_all?(/d/)
# p %w[dog boor rod blade].all?(/d/)
# p %w[dog boor rod blade].my_all?(/d/)
# p %w[dog door rod blade].all?(/o/)
# p %w[dog door rod blade].my_all?(/o/)
# p %w[dog door rod blode].all?(/o/)
# p %w[dog door rod blode].my_all?(/o/)
# p %w[dog doorrod blade].all?(/d/)
# p %w[dog doorrod blade].my_all?(/d/)
# p [3,4,7,11].all?(3)
# p [3,4,7,11].my_all?(3)
