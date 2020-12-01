require './grid'

grid = Grid.new('input.txt')
grid.build_grid

largest_node = grid.largest_node

puts "Largest Area is node #{largest_node.id}: #{largest_node.size}"

puts "Total Area in Range: #{grid.nodes_in_range}"