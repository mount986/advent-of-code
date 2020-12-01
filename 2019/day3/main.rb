wire1, wire2 = File.new('input.dat').readlines

def build_wire(wire)
  wire_locations = Hash.new

  steps = 0
  x = 0
  y = 0

  wire.split(',').each do |instruction|
    direction = instruction[0]
    distance = instruction[1,10].to_i

    distance.times do
      steps += 1
      case direction
      when 'U'
        y += 1
      when 'D'
        y -= 1
      when 'L'
        x -= 1
      when 'R'
        x += 1
      else
        raise "Unknown direction #{direction}"
      end

      wire_locations[steps] = "#{x},#{y}"
    end
  end

  return wire_locations
end

wire1_locations = build_wire(wire1)
wire2_locations = build_wire(wire2)

intersections = wire1_locations.values & wire2_locations.values

closest = nil
shortest = nil
intersections.each do |location|
  x, y = location.split(',').map{|c| c.to_i}
  
  distance = x.abs + y.abs
  if closest.nil? or distance < closest
    closest = distance
  end

  wire1_locations.select{|key, value| value == location}.keys.map{|value| value.to_i}.each do |wire1_steps|
    wire2_locations.select{|key, value| value == location}.keys.map{|value| value.to_i}.each do |wire2_steps|
      length = wire1_steps + wire2_steps
      if shortest.nil? or length < shortest
        shortest = length
      end
    end
  end
end

puts closest
puts shortest