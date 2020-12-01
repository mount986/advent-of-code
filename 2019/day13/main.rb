require_relative '../lib/arcade'
program = File.new('input.dat').read().split(',').map { |line| line.to_i }

arcade = Arcade.new(program.clone)
arcade.play

puts arcade.num_blocks

game = Arcade.free_play(program.clone)
game.play

puts game.score