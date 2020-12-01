class Painter
  attr_reader :panels
  attr_reader :direction
  attr_reader :pos_x, :pos_y

  def initialize(processor, starting_color: 0)
    @pos_x = 0
    @pos_y = 0
    @panels = [Panel.new(@pos_x, @pos_y, color: starting_color)]
    @direction = :up

    @processor = processor
  end

  def get_panel(x, y)
    new_panel = Panel.new(x, y)

    if index = @panels.index(new_panel)
      return @panels[index]
    end

    @panels.push new_panel

    new_panel
  end

  def run
    while true
      color = nil
      direction = nil

      @processor.send(get_panel(@pos_x, @pos_y).color)

      while color.nil?
        @processor.compute
        return if @processor.state == :finished
        color = @processor.receive
      end

      while direction.nil?
        @processor.compute
        return if @processor.state == :finished
        direction = @processor.receive
      end

      perform_job(color, direction)
    end
  end

  def perform_job(color, direction)
    paint(color)
    turn(direction)
    move_forward
  end

  def num_cells_painted
    @panels.select { |panel| panel.painted }.count
  end

  def print
    prev_y = nil
    (0..5).each do |y|
      (0..40).each do |x|
        panel = get_panel(x, y * -1)
        $stdout << "\n" if panel.pos_y != prev_y
        $stdout << panel.print
        prev_y = panel.pos_y
      end
    end
  end

  private

  def paint(color)
    get_panel(@pos_x, @pos_y).paint(color)
  end

  def turn(direction)
    case direction
    when 0
      turn_left
    when 1
      turn_right
    else
      raise "Unknown direction: #{direction}"
    end
  end

  def move_forward
    case @direction
    when :up
      @pos_y += 1
    when :down
      @pos_y -= 1
    when :left
      @pos_x -= 1
    when :right
      @pos_x += 1
    end
  end

  def turn_left
    @direction = case @direction
                 when :up
                   :left
                 when :left
                   :down
                 when :down
                   :right
                 when :right
                   :up
                 end
  end

  def turn_right
    @direction = case @direction
                 when :up
                   :right
                 when :left
                   :up
                 when :down
                   :left
                 when :right
                   :down
                 end
  end
end

class Panel
  attr_reader :pos_x, :pos_y
  attr_reader :color
  attr_reader :painted

  def initialize(x, y, color: 0)
    @pos_x = x
    @pos_y = y

    @color = color
    @painted = false
  end

  def paint(color)
    @color = color
    @painted = true
  end

  def ==(other)
    other.pos_x == @pos_x and other.pos_y == @pos_y
  end

  def print
    output = case @color
             when 0
               "_"
             when 1
               "8"
             end

    output
  end
end