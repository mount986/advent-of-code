require './lib/advent_of_code'

jump_list_1 = Array.new
File.readlines('bin/day_5/twisty_trampolines.dat').each do |line|
  jump_list_1.push line.strip.to_i
end

jump_list_2 = jump_list_1.clone

count = 0
index = 0

while index >= 0 and index < jump_list_1.length
  next_index = index + jump_list_1[index]
  jump_list_1[index] += 1
  index = next_index
  count += 1
end

puts count

count = 0
index = 0

while index >= 0 and index < jump_list_2.length
  next_index = index + jump_list_2[index]
  jump_list_2[index] += (jump_list_2[index] > 2 ? -1 : 1)
  index = next_index
  count += 1
end

puts count