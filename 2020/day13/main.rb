require_relative 'bus'

current_time, buses_list = File.readlines('input.dat', chomp: true)
# current_time, buses_list = File.readlines('test.dat', chomp: true)

current_time = current_time.to_i
buses = Array.new
buses_list.split(',').each_with_index do |id, index|
  next if id == 'x'
  buses.push Bus.new(id.to_i, index)
end

next_bus = nil
min_time_left = buses.first.time_until_departure(current_time)

buses.each do |bus|
  time_left = bus.time_until_departure(current_time)
  if time_left < min_time_left
    next_bus = bus
    min_time_left = time_left
  end
end

puts min_time_left * next_bus.id

slowest_bus = buses.sort_by!{ |bus| bus.id }.last

time = slowest_bus.id - slowest_bus.pos

while true
  break if buses.all? { |bus| (time + bus.pos) % bus.id == 0 }

  time += slowest_bus.id
end

puts time
