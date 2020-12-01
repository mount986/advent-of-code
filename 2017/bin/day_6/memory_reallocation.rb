require './lib/advent_of_code'

memory_allocation = File.read('bin/day_6/memory_reallocation.dat').strip.split("\t").map{|val| val.to_i}
memory_history = Array.new

count = 0

until memory_history.include? memory_allocation
  memory_history.push memory_allocation.clone
  AdventOfCode.reallocate_memory!(memory_allocation)
  count += 1
end

puts count

puts memory_history.length - memory_history.index(memory_allocation)