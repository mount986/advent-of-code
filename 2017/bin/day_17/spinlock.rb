require './lib/advent_of_code'

# step_size  = 3
step_size = File.read('./bin/day_17/spinlock.dat').strip.to_i

buffer = [0]
current_position = 0

(1..2017).each do |index|
  current_position = (current_position + step_size) % index + 1
  buffer.insert(current_position, index)
end

puts buffer[buffer.index(2017) + 1]

solution = nil
current_position = 0

(1..50000000).each do |index|
  current_position = (current_position + step_size) % index + 1
  solution = index if current_position == 1
end

puts solution



