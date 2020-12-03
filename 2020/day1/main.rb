input = File.readlines('input.dat').map{|num|num.to_i}

input.sort!

def find_solution(input, target = 2020, numbers = 2)
  min = 0
  multiplicand = nil

  until multiplicand
    return nil if input.empty?

    min = input.shift

    multiplicand = (numbers > 2 ? find_solution(input.clone, target - min, numbers - 1) : input.delete(target - min))

  end

  min * multiplicand
end

puts find_solution(input.clone, 2020, 2)
puts find_solution(input.clone, 2020, 3)
