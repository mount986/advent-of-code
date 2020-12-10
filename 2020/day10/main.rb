adapters = File.readlines('input.dat').map{|jolt| jolt.to_i}

def fib3(num)
  return 0 if num < 1
  return 1 if num == 1 or num == 2

  return fib3(num - 1) + fib3(num - 2) + fib3(num - 3)
end

adapters.unshift(0)
adapters.push adapters.max + 3
adapters.sort!

permutations = 1
consecutive = 1
diff_1_count = 0
diff_3_count = 0

(adapters.count - 1).times do |index|
  case (adapters[index + 1] - adapters[index])
  when 1
    diff_1_count += 1
    consecutive += 1
  when 3
    diff_3_count += 1
    permutations = permutations * fib3(consecutive)
    consecutive = 1
  end
end

puts diff_1_count * diff_3_count
puts permutations

