require './lib/firewall_layer'

File.readlines('./bin/day_13/packet_scanner.dat').each do |line|
  depth, range = line.strip.split(': ')
  FirewallLayer.new(depth.to_i, range.to_i)
end

severity = 0
FirewallLayer.layers.each do |layer|
  severity += (layer.depth * layer.range) if layer.collision?
end

puts severity

FirewallLayer.layers.clear
File.readlines('./bin/day_13/packet_scanner.dat').each do |line|
  depth, range = line.strip.split(': ')
  FirewallLayer.new(depth.to_i, range.to_i)
end

delay = -2
no_collisions = false

until no_collisions
  no_collisions = true
  delay += 1

  FirewallLayer.layers.each do |layer|
    if layer.collision?(delay)
      no_collisions = false
      break
    end
  end
end

puts delay
