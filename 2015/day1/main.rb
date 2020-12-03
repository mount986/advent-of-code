input = File.read('input.dat')

floor = 0
index = 0
basement = nil
input.each_char do |c|
  floor += 1 if c == '('
  floor -= 1 if c == ')'
  index += 1
  basement = index if basement.nil? and floor < 0
end

puts floor
puts basement