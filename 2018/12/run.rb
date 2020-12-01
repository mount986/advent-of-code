require './green_house'

green_house = GreenHouse.new('input.txt')
200.times do
  green_house.print_pots
  green_house.run_generation
end

puts "Short Sum: #{green_house.sum_plants}"

repeating_green_house = GreenHouse.new('input_100.txt')
repeating_green_house.run_speed(50000000000 - 100)

puts "Final Sum: #{repeating_green_house.sum_plants}"