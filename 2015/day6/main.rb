require_relative 'light'

instructions = File.readlines('input.dat')

grid = Hash.new
grid2 = Hash.new

instructions.each do |instruction|
  match, action, top, bottom = instruction.match(/(turn on|turn off|toggle) (\d+,\d+) through (\d+,\d+)/).to_a

  action.gsub!(' ', '_')
  top_x, top_y = top.split(',')
  bottom_x, bottom_y = bottom.split(',')

  (top_x..bottom_x).each do |x|
    (top_y..bottom_y).each do |y|
      grid["#{x},#{y}"] ||= Light.new
      grid["#{x},#{y}"].send(action)

      grid2["#{x},#{y}"] ||= Light2.new
      grid2["#{x},#{y}"].send(action)
    end
  end
end

on_count = 0

puts grid.values.count { |light| light.on? }
puts grid2.values.sum { |light| light.brightness }