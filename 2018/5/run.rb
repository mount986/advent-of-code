require './polymer'

polymer = Polymer.new('input.txt')

while polymer.react?
  puts "Reaction occurred, new polymer: #{polymer.units.join('')}"
end

puts "\n\nNo Reaction, final polymer: #{polymer.units.join('')}"
puts "\n\nPolymer length: #{polymer.units.length}"


tests = Hash.new
('a'..'z').each do |letter|
  polymer.reset
  polymer.remove letter
  while polymer.react?
  end

  tests[letter] = polymer.units.length
  puts "Without #{letter} final length is: #{polymer.units.length}"
end

min = 10000
shortest = nil
tests.each do |letter, length|
  if length < min
    min = length
    shortest = letter
  end
end
puts "Shortest improvement is #{shortest}: #{min}"