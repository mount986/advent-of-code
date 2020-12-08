require_relative 'wire'

rules = File.readlines('input.dat')

rules.each do |rule|
  Wire.parse_rule(rule)
end

result = Wire.get_wire('a').value
puts result

Wire.reset_all
Wire.get_wire('b').value = result
puts Wire.get_wire('a').value
