require_relative 'seating_grid'

layout = File.readlines('input.dat').map{|row| row.strip}

grid = SeatingGrid.new(layout, tolerance: 4, skip_floor: false)

while grid.changes?
  grid.cycle
end

puts grid.count_occupied

grid = SeatingGrid.new(layout, tolerance: 5, skip_floor: true)

while grid.changes?
  grid.cycle
end

puts grid.count_occupied
