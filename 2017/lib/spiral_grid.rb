class SpiralGrid
  class << self
    attr_accessor :nodes
    attr_accessor :direction
  end

  class Node
    attr_accessor :up, :down, :left, :right, :upleft, :upright, :downleft, :downright
    attr_accessor :x, :y
    attr_accessor :value

    def initialize(x, y, value = nil)
      @x = x
      @y = y

      @up = SpiralGrid.get_node(x, y + 1)
      @down = SpiralGrid.get_node(x, y - 1)
      @left = SpiralGrid.get_node(x - 1, y)
      @right = SpiralGrid.get_node(x + 1, y)
      @upleft = SpiralGrid.get_node(x - 1, y + 1)
      @upright = SpiralGrid.get_node(x + 1, y + 1)
      @downleft = SpiralGrid.get_node(x - 1, y - 1)
      @downright = SpiralGrid.get_node(x + 1, y - 1)

      @value = value || sum_of_surrounding_nodes
    end

    def sum_of_surrounding_nodes
      value = @left.value
      value += @upleft.value
      value += @right.value
      value += @upright.value
      value += @up.value
      value += @downleft.value
      value += @down.value
      value += @downright.value

      value
    end
  end

  class EmptyNode < Node
    def initialize()
      @x = 1000000000000000
      @y = 1000000000000000
      @value = 0
    end
  end

  @direction = :down

  def self.new_grid
    @nodes = []
    @nodes = [Node.new(0, 0, 1)]
    @nodes.last
  end

  def self.populate_next_node
    current_node = @nodes.last
    if get_node(*next_node(current_node.x, current_node.y, next_direction(@direction))).value == 0
      @direction = next_direction(@direction)
    end

    (new_x, new_y) = next_node(current_node.x, current_node.y, @direction)
    @nodes.push (Node.new(new_x, new_y))

    @nodes.last
  end

  def self.next_node(x, y, direction)
    new_x = x
    new_y = y

    case direction
      when :left
        new_x -= 1
      when :right
        new_x += 1
      when :up
        new_y += 1
      when :down
        new_y -= 1
    end

    return [new_x, new_y]
  end

  def self.get_node(x, y)
    @nodes.each do |node|
      return node if node.x == x and node.y == y
    end

    return EmptyNode.new
  end

  def self.next_direction(direction)
    case direction
      when :left
        next_dir = :down
      when :right
        next_dir = :up
      when :up
        next_dir = :left
      when :down
        next_dir = :right
    end

    next_dir
  end
end