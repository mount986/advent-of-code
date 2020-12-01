require './arena'

arena = Arena.new('test_1.txt')
3.times do
  arena.fight_round
end