require './lib/advent_of_code'
require './lib/register'

registers = Register.new

File.readlines('./bin/day_8/registers.dat').each do |line|
  registry, instruction, value, if_, other_reg, check, other_val = line.split(' ')

  registers.send(instruction.to_sym, registry, value.to_i) if registers[other_reg].send(check.to_sym, other_val.to_i)
end

puts registers.values.max
puts registers.max

