require './fabric'

fabric = Fabric.new
fabric.parse_input('input.txt')
puts "Total overlapping inches: #{fabric.find_dupes.count}"
puts "Only unique claim: #{fabric.find_uniq}"