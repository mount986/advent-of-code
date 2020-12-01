require './fuel_grid'

fuel_grid = FuelGrid.new('input.txt')

puts "Most power located at: #{fuel_grid.find_most_power.join(',')}"
puts "Most power located at: #{fuel_grid.find_greatest_power.join(',')}"
