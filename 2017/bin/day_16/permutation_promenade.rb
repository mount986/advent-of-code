require './lib/dance'

dance = Dance.new

moves = File.read('./bin/day_16/permutation_pomenade.dat').split(',')

moves.each do |move|
  dance.do(move)
end

puts dance.join('')

dance = Dance.new
history = Array.new

until history.include? dance.join('')
  history.push dance.join('')

  moves.each do |move|
    dance.do(move)
  end
end

repeat = history.count

dance = Dance.new

(1000000000 % repeat).times do
  moves.each do |move|
    dance.do(move)
  end
end

puts dance.join('')