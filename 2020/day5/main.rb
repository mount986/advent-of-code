require_relative 'boarding_pass'
seats = File.readlines('input.dat')

seats.map! { |seat| BoardingPass.new(seat).id }

seats.sort!

puts seats.last

(seats.first..seats.last).each do |id|
  puts id unless seats.include?(id)
end