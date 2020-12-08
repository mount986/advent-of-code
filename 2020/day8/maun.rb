require_relative 'handheld'

instructions = File.readlines('input.dat')

handheld = Handheld.new(instructions)

begin
  handheld.run
rescue IndexError, e
  puts handheld.accumulator
end

handheld = Handheld.new(instructions)
handheld.debug
puts handheld.accumulator