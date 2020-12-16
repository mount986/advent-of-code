input = '18,8,0,5,4,1,20'.split(',').map { |i| i.to_i }

def play_game(input, iterations)
  numbers = Hash.new
  input.each_with_index { |number, index| numbers[number] = index }

  (iterations - input.length).times do |index|
    last = input.last

    age = (numbers[last] ? input.length - 1 - numbers[last] : 0)
    numbers[last] = input.length - 1

    input.push age
  end

  input.last
end

puts play_game(input.dup, 2020)
puts play_game(input.dup, 30_000_000)

