require './lib/tube_maze'

maze = TubeMaze.new(File.readlines('./bin/day_19/series_of_tubes.dat'))
maze.traverse_maze

puts maze.letters.join('')
puts maze.count