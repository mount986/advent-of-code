require './lib/advent_of_code'
require './lib/spiral_grid'

input = File.read('bin/day_3/spiral_memory.dat').strip.to_i

puts AdventOfCode.spiral_distance(input)

node = SpiralGrid.new_grid
while (node.value <= input)
  node = SpiralGrid.populate_next_node
end

puts node.value