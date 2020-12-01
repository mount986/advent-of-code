require './node'

class Tree

  attr_accessor :stream
  attr_accessor :root

  def initialize(input_file)
    @stream = File.read(input_file).strip.split(/\s+/).map{|value| value.to_i}
  end

  def build_tree
    @root = Node.build_node(@stream)
  end

  def sum_metadata
    @root.metadata_sum
  end

  def sum_value
    @root.value
  end
end