require './lib/advent_of_code'

directions = File.read('./bin/day_11/hex_ed.dat').strip.split(',')
step_directions = Array.new
max_distance = 0

counter = 0
puts directions.length

directions.each do |direction|
  counter += 1

  step_directions.push direction
  step_directions = AdventOfCode.reduce_directions!(step_directions)

  max_distance = step_directions.length if step_directions.length > max_distance
end

puts step_directions.length
puts max_distance