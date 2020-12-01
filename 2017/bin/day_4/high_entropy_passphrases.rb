require './lib/advent_of_code'

valid_passphrases_1 = 0
valid_passphrases_2 = 0

File.readlines('bin/day_4/high_entropy_passphrases.dat').each do |line|
  line_data = line.strip.split(" ")
  sorted_line_data = line_data.map{|data| data.chars.sort.join('') }
  valid_passphrases_1 += 1 if line_data.count == line_data.uniq.count
  valid_passphrases_2 += 1 if sorted_line_data.count == sorted_line_data.uniq.count
end

puts valid_passphrases_1
puts valid_passphrases_2