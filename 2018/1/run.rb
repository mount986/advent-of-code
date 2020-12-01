require './gadget'

gadget = Gadget.new

repeated = false
until repeated do
  puts gadget.frequency
  File.open("input.txt", 'r').each_line do |line|
    gadget.change_frequency line
    if gadget.repeated_frequency?
      repeated = true
      break
    end
  end
end

puts gadget.frequency