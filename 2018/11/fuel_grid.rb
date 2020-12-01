class FuelGrid
  attr_accessor :serial_number
  attr_accessor :nodes

  GRID_SIZE = 300
  SQUARE_SIZE = 3

  def initialize(input_file)
    @serial_number = File.read(input_file).strip.to_i

    @nodes = Hash.new
    (1..GRID_SIZE).each do |x|
      @nodes[x] = Hash.new
      (1..GRID_SIZE).each do |y|
        rack_id = x + 10

        power_level = rack_id * y
        power_level += serial_number
        power_level *= rack_id
        power_level = power_level.to_s[-3].to_i
        power_level -= 5

        @nodes[x][y] = power_level
      end
    end
  end

  def find_most_power
    max_power = -10
    max_location = [0, 0]

    (1..(GRID_SIZE - SQUARE_SIZE)).each do |x|
      (1..(GRID_SIZE - SQUARE_SIZE)).each do |y|
        square_power = 0
        SQUARE_SIZE.times do |x2|
          SQUARE_SIZE.times do |y2|
            square_power += @nodes[x + x2][y + y2]
          end
        end

        if square_power > max_power
          max_power = square_power
          max_location = [x, y]
        end
      end
    end

    max_location
  end

  def find_greatest_power
    max_power = 0
    max_info = [0, 0, 0]

    puts "Start time: #{Time.now}"

    (1..GRID_SIZE).each do |x|
      $stdout << "#{x}:  "

      (1..GRID_SIZE).each do |y|
        $stdout << "#{@nodes[x][y]} "
        current_power = 0
        (1..([GRID_SIZE + 1 - x, GRID_SIZE + 1 - y].min)).each do |square_size|
          add_x = -1
          add_y = square_size - 1
          square_size.times do
            add_x += 1
            current_power += @nodes[x + add_x][y + add_y]
          end
          (square_size - 1).times do
            add_y -= 1
            current_power += @nodes[x + add_x][y + add_y]
          end

          if current_power > max_power
            max_power = current_power
            max_info = [x, y, square_size]
          end
        end
      end
      $stdout << "\n"
    end

    puts "End time: #{Time.now}"

    max_info
  end
end