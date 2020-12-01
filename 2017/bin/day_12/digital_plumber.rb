require './lib/advent_of_code'
require './lib/pipe_node'


File.readlines('./bin/day_12/digital_plumber.dat').each do |line|
  name, children = line.split(' <-> ')
  PipeNode.new(name.strip, children.strip.split(', '))
end

PipeNode.build_nodes

zero_group = PipeNode.build_group('0')

puts zero_group.count

count = 0
until PipeNode.nodes.empty?
  count += 1

  group = PipeNode.build_group(PipeNode.nodes.first.name)
  PipeNode.nodes -= group
end

puts count