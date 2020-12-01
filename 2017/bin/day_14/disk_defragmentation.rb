require './lib/advent_of_code'
require './lib/knot_hash'
require './lib/disk_grid'

input = File.read('./bin/day_14/disk_defragmentation.dat').strip

grid = DiskGrid.new

(0..127).each do |index|
  line = "#{input}-#{index}"
  ribbon = KnotHash.new
  ribbon.sparse_hash!(line)
  dense_hash = ribbon.dense_hash
  hex = AdventOfCode.int_array_to_hex(dense_hash)
  grid.add_row(index, AdventOfCode.hex_to_binary(hex))
end

puts grid.count_on

grid.build_regions!

puts grid.count_regions