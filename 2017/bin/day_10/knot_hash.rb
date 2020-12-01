require './lib/advent_of_code'
require './lib/knot_hash'

ribbon = KnotHash.new
knot_lengths = File.read('./bin/day_10/knot_hash.dat').strip.split(',').map{|val| val.to_i}

knot_lengths.each do |length|
  ribbon.twist!(length)
end

puts (ribbon.memory[0] * ribbon.memory[1])


ribbon = KnotHash.new
knot_lengths = File.read('./bin/day_10/knot_hash.dat').strip.chars.map{|val| val.ord} + [17, 31, 73, 47, 23]

64.times do
  knot_lengths.each do |length|
    ribbon.twist!(length)
  end
end

dense_hash = ribbon.dense_hash

puts AdventOfCode.int_array_to_hex(dense_hash)