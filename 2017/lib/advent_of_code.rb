require './lib/spiral_grid'

module AdventOfCode
  def self.find_doubles(input, advance = 1)
    matches = []

    (0..(input.length - 1)).each do |index|
      char = input[index]
      matches.push(char.to_i) if char == input[(index + advance) % input.length]
    end

    matches
  end

  def self.sum_array(input)
    sum = 0
    input.map {|val| sum += val}

    sum
  end

  def self.min_max_difference(input)
    min = input.min || 0
    max = input.max || 0

    max - min
  end

  def self.divisible_quotients(input)
    sorted_input = input.sort

    (0..(sorted_input.length - 1)).each do |small_index|
      ((small_index + 1)..(sorted_input.length - 1)).each do |large_index|
        return sorted_input[large_index] / sorted_input[small_index] if (sorted_input[large_index] % sorted_input[small_index] == 0)
      end
    end
  end

  def self.spiral_distance(input)
    index = 1

    while input > (index * index)
      index += 1
    end

    min_dist = (index / 2).to_i
    max_dist = min_dist * 2

    if index.even?
      current_distance = max_dist - 1
      increment = -1
    else
      current_distance = max_dist
      increment = 1
    end

    current_num = index * index

    while true
      return current_distance if current_num == input

      current_num -= 1

      if current_distance == min_dist or current_distance == max_dist
        increment *= -1
      end

      current_distance += increment
    end
  end

  def self.spiral_sums(input)
    node = SpiralGrid.new_grid
    (input - 1).times do
      node = SpiralGrid.populate_next_node
    end

    node.value
  end

  def self.reallocate_memory!(input)
    max_value = input.max
    max_val_index = input.index(max_value)

    input[max_val_index] = 0

    current_index = max_val_index + 1

    max_value.times do
      input[current_index % input.length] += 1
      current_index += 1
    end
  end

  def self.int_array_to_hex(input)
    hex_string = ''
    input.each do |num|
      hex_string << sprintf("%02x", num)
    end

    hex_string
  end

  def self.hex_to_binary(input)
    binary_string = ''
    input.chars.each do |num|
      binary_string << num.hex.to_s(2).rjust(num.size*4, '0')
    end

    binary_string
  end

  def self.reduce_directions!(input)
    rotation = ['n', 'ne', 'se', 's', 'sw', 'nw']

    index = 0
    while index < input.length
      direction = input[index]

      position = rotation.index(direction)

      left_diagnol = rotation[(position + 2) % 6]
      opposite = rotation[(position + 3) % 6]

      unless input.index(left_diagnol).nil?
        input[index] = rotation[(position + 1) % 6]
        input.delete_at(input.index(left_diagnol))
        next
      end

      unless input.index(opposite).nil?
        input.delete_at(index)
        input.delete_at(input.index(opposite))
        next
      end

      index += 1;
    end

    input
  end
end