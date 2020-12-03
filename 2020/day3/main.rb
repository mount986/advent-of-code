map = File.readlines('input.dat').map { |line| line.strip }

def traverse(map, x_slope, y_slope)
  pos_x = 0
  pos_y = 0
  trees = 0

  while pos_y < map.size - 1
    pos_x += x_slope
    pos_y += y_slope

    trees += 1 if map[pos_y][pos_x % map[pos_y].size] == '#'
  end

  trees
end

puts traverse(map, 3, 1)

slopes = [{x: 1, y: 1},
          {x: 3, y: 1},
          {x: 5, y: 1},
          {x: 7, y: 1},
          {x: 1, y: 2}]

trees = 1
slopes.each do |slope|
  trees *= traverse(map, slope[:x], slope[:y])
end

puts trees