class Ferry
  attr_accessor :pos_x, :pos_y
  attr_accessor :dir_x, :dir_y

  def initialize
    @pos_x = 0
    @pos_y = 0

    @dir_x = 1
    @dir_y = 0
  end

  def navigate(directions)
    directions.each do |direction|
      command, arg = direction.match(/([NEWSLRF])(\d+)/).captures
      send(command.downcase, arg.to_i)
    end
  end

  def move_north(distance)
    @pos_y += distance
  end

  alias n move_north

  def move_south(distance)
    @pos_y -= distance
  end

  alias s move_south

  def move_east(distance)
    @pos_x += distance
  end

  alias e move_east

  def move_west(distance)
    @pos_x -= distance
  end

  alias w move_west

  def move_forward(distance)
    @pos_x += @dir_x * distance
    @pos_y += @dir_y * distance
  end

  alias f move_forward

  def turn_left(degrees)
    (degrees / 90).times do
      if @dir_x == 1
        @dir_x = 0
        @dir_y = 1
      elsif @dir_x == -1
        @dir_x = 0
        @dir_y = -1
      else
        if @dir_y == 1
          @dir_y = 0
          @dir_x = -1
        else
          @dir_y = 0
          @dir_x = 1
        end
      end
    end
  end

  alias l turn_left

  def turn_right(degrees)
    (degrees / 90).times do
      if @dir_x == 1
        @dir_x = 0
        @dir_y = -1
      elsif @dir_x == -1
        @dir_x = 0
        @dir_y = 1
      else
        if @dir_y == 1
          @dir_y = 0
          @dir_x = 1
        else
          @dir_y = 0
          @dir_x = -1
        end
      end
    end
  end

  alias r turn_right

  def distance
    return @pos_x.abs + @pos_y.abs
  end
end