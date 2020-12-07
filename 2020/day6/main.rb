require_relative 'group'

group_answers = File.readlines('input.dat', "\n\n")
groups = Array.new
uniq_sum = 0
common_sum = 0

group_answers.each do |answers|
  group = Group.new(answers)
  groups.push group
  uniq_sum += group.uniq_answers.size
  common_sum += group.common_answers.size
end

puts uniq_sum
puts common_sum
