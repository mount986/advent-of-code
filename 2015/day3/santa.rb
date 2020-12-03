class Santa
  attr_reader :pos_x, :pos_y

  def initialize
    @pos_x = 0
    @pos_y = 0
  end

  def move(direction)
    case direction
    when '>'
      @pos_x += 1
    when '<'
      @pos_x -= 1
    when '^'
      @pos_y -= 1
    when 'v'
      @pos_y += 1
    end
  end

  def location
    "#{@pos_x},#{@pos_y}"
  end
end