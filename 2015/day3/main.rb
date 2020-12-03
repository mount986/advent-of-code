require_relative 'santa'

directions = File.read('input.dat')

santa = Santa.new
houses = [santa.location]

directions.each_char do |direction|
  santa.move(direction)
  houses.push santa.location
end

puts houses.uniq.count

santa = Santa.new
robot = Santa.new
current = santa
houses = [santa.location]

directions.each_char do |direction|
  current = (current == santa ? robot : santa)

  current.move(direction)
  houses.push current.location
end

puts houses.uniq.count
