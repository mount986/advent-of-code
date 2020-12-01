require './node'

class Grid
  attr_accessor :nodes
  attr_accessor :super_nodes
  attr_accessor :nodes_in_range

  NIL_NODE = NilNode.new(0,0)

  def initialize(input_file)
    @min_x = 0
    @max_x = 500
    @min_y = 0
    @max_y = 500
    @max_distance = 10000

    @nodes_in_range = 0

    @nodes = Array.new
    @super_nodes = Array.new

    File.open(input_file, 'r').each_line do |line|
      x, y = line.strip.split(', ').map {|coord| coord.to_i}

      @super_nodes.push SuperNode.new(x, y)
    end
  end

  def build_grid
    (@min_x..@max_x).each do |x|
      (@min_y..@max_y).each do |y|
        node = Node.new(x, y)
        nearest_super_node = nearest_super_node(x, y)
        nearest_super_node.expand
        node.owner = nearest_super_node
        @nodes_in_range += 1 if total_distance_to_super_nodes(x,y) < @max_distance
        @nodes.push node
      end
    end
  end

  def largest_node
    largest_node = nil
    largest_area = 0

    viable_nodes = super_nodes - edge_nodes

    viable_nodes.each do |node|
      if node.size > largest_area
        largest_area = node.size
        largest_node = node
      end
    end

    largest_node
  end

  def edge_nodes
    nodes.select {|node|
      node.x == @min_x or
          node.x == @max_x or
          node.y == @min_y or
          node.y == @max_y}.
        collect {|node| node.owner}.uniq
  end

  def total_distance_to_super_nodes(x,y)
    total_distance = 0

    @super_nodes.each do |node|
      distance = (node.x - x).abs + (node.y - y).abs
      total_distance += distance
    end

    total_distance
  end


  def nearest_super_node(x, y)
    closest_distance = 10000
    closest_nodes = Array.new

    @super_nodes.each do |node|
      distance = (node.x - x).abs + (node.y - y).abs
      if distance < closest_distance
        closest_distance = distance
        closest_nodes = [node]
      elsif distance == closest_distance
        closest_nodes.push node
      end
    end

    (closest_nodes.size == 1 ? closest_nodes.first : NIL_NODE)
  end
end