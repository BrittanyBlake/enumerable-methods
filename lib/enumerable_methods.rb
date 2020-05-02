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
  def my_any?(arg = nil, &block)
    if block_given?
      my_each do |item|
        return true if block.call(item)
      end
    elsif arg.nil?
      my_each do |item|
        return true if item
      end
    elsif arg.class == Class
      my_each do |item|
        return true if item.is_a?(arg)
      end
    elsif arg.class == Regexp
      my_each do |item|
        return true if item =~ arg
      end
    else
      my_each do |item|
        return true if item == arg
      end
    end
    false
  end
  # end of my_any?

  # my_none?
  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
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
  def my_map(proc = nil)
    new_array = []
    if proc.nil?
      return to_enum unless block_given?

      my_each do |item|
        new_array << yield(item)
      end
    else
      my_each do |item|
        new_array << proc.call(item)
      end
    end
    new_array
  end
  # end of my_map

  # start of my_inject
  def my_inject(initial = nil, arg = nil)
    arg = initial if arg.nil?

    if initial.nil? || initial.is_a?(Symbol)
      array = drop(1)
      initial = to_a[0]
    else
      array = to_a
    end

    if block_given?
      array.my_each do |i|
        initial = yield(initial, i)
      end
    else
      array.my_each do |i|
        initial = initial.send(arg, i)
      end
    end
    initial
  end
  # end of my_inject

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # multiply elements method
  def multiply_els
    my_inject(1) { |product, n| product * n }
  end
  # end of multiply elements method
end
