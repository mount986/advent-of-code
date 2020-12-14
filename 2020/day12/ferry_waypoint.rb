class FerryWaypoint
  attr_accessor :pos_x, :pos_y
  attr_accessor :way_x, :way_y

  def initialize
    @pos_x = 0
    @pos_y = 0

    @way_x = 10
    @way_y = 1
  end

  def navigate(directions)
    directions.each do |direction|
      command, arg = direction.match(/([NEWSLRF])(\d+)/).captures
      send(command.downcase, arg.to_i)
    end
  end

  def move_north(distance)
    @way_y += distance
  end

  alias n move_north

  def move_south(distance)
    @way_y -= distance
  end

  alias s move_south

  def move_east(distance)
    @way_x += distance
  end

  alias e move_east

  def move_west(distance)
    @way_x -= distance
  end

  alias w move_west

  def move_forward(distance)
    @pos_x += @way_x * distance
    @pos_y += @way_y * distance
  end

  alias f move_forward

  def rotate_left(degrees)
    rotate(degrees)
  end

  alias l rotate_left

  def rotate_right(degrees)
    rotate(-1 * degrees)
  end

  def rotate(degrees)
    radians = degrees * Math::PI / 180

    new_x = (@way_x * Math.cos(radians) - @way_y * Math.sin(radians)).round
    new_y = (@way_x * Math.sin(radians) + @way_y * Math.cos(radians)).round

    @way_x = new_x
    @way_y = new_y
  end

  alias r rotate_right

  def distance
    return @pos_x.abs + @pos_y.abs
  end
end