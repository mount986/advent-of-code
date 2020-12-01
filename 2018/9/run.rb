require './game'

$debug = false
game = Game.new('input.txt')
game.play_game

puts "Winning points: #{game.winner}"

game = Game.new('input.txt')
game.final_point_value *= 100
game.play_game

puts "Winning points: #{game.winner}"