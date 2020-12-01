require './tree'

tree = Tree.new('input.txt')
tree.build_tree

puts "Total Metadata Sum: #{tree.sum_metadata}"
puts "Total Tree Value: #{tree.sum_value}"