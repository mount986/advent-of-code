require_relative '../lib/jupiter'

moon_defs = File.readlines('input.dat')

jupiter = Jupiter.new

moon_defs.each do |moon|
  jupiter.add_moon(moon)
end

1000.times do
  jupiter.cycle
end

puts jupiter.total_energy

while true
  jupiter.cycle
end