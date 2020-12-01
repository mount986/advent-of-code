require './lib/advent_of_code'

line_differences = Array.new
line_quotients = Array.new

File.readlines('bin/day_2/checksum.dat').each do |line|
  line_data = line.strip.split("\t").map {|val| val.to_i}
  line_differences.push(AdventOfCode.min_max_difference(line_data))
  line_quotients.push(AdventOfCode.divisible_quotients(line_data))
end

puts AdventOfCode.sum_array(line_differences)
puts AdventOfCode.sum_array(line_quotients)