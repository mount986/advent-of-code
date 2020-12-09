input = File.readlines('input.dat').map { |value| value.to_i }
preamble = 25

def is_sum?(array, preamble, index)
  sub_array = array[index - preamble, preamble]

  until sub_array.empty?
    value = sub_array.shift
    return true if sub_array.include?(array[index] - value)
  end

  false
end

def find_sum(array, value)
  sub_array = [array.first]
  index = 1

  loop do
    sum = sub_array.sum
    break if sum == value

    if sum < value
      sub_array.push array[index]
      index += 1
    else
      sub_array.shift
    end
  end

  sub_array.min + sub_array.max

end

bad_index = nil

(preamble..input.size - 1).each do |index|
  bad_index = index unless is_sum?(input, preamble, index)
end

puts input[bad_index]

puts find_sum(input, input[bad_index])

