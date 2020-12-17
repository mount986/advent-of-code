require_relative 'pocket3_dimension'
require_relative 'pocket4_dimension'

# energy_3d = Pocket3Dimension.new(File.readlines('test.dat', chomp: true))
# energy_4d = Pocket4Dimension.new(File.readlines('test.dat', chomp: true))
energy_3d = Pocket3Dimension.new(File.readlines('input.dat'))
energy_4d = Pocket4Dimension.new(File.readlines('input.dat'))

6.times do
  energy_3d.start_cycle
  energy_4d.start_cycle
end

puts energy_3d.cubes.values.count { |cube| cube.active? }
puts energy_4d.cubes.values.count { |cube| cube.active? }