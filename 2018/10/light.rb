class Light
  attr_accessor :pos_x
  attr_accessor :pos_y
  attr_accessor :vel_x
  attr_accessor :vel_y

  def initialize(pos_x, pos_y, vel_x, vel_y)
    @pos_x = pos_x
    @pos_y = pos_y
    @vel_x = vel_x
    @vel_y = vel_y
  end

  def move
    @pos_x += @vel_x
    @pos_y += @vel_y
  end

  def jump(num)
    @pos_x += (@vel_x * num)
    @pos_y += (@vel_y * num)
  end

  def at_position?(x, y)
    x == @pos_x and y == @pos_y
  end
end