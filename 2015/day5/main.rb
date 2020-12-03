require_relative 'string'
input = File.readlines('input.dat')

old_nice = 0
new_nice = 0

input.each do |line|
  old_nice += 1 if line.old_nice?
  new_nice += 1 if line.new_nice?
end

puts old_nice
puts new_nice
