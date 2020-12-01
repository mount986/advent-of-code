class Node
  attr_accessor :children
  attr_accessor :metadata

  def self.build_node(stream)
    node = Node.new
    num_children = stream.shift
    num_metadata = stream.shift

    num_children.times do
      node.add_child(Node.build_node(stream))
    end

    num_metadata.times do
      node.add_metadata(stream.shift)
    end

    node
  end

  def initialize
    @children = Array.new
    @metadata = Array.new
  end

  def add_child(other_node)
    @children.push other_node
  end

  def add_metadata(value)
    @metadata.push value
  end

  def metadata_sum
    sum = @metadata.sum

    @children.each do |child|
      sum += child.metadata_sum
    end

    sum
  end

  def value
    if @children.size == 0
      return metadata_sum
    end

    sum = 0
    @metadata.each do |meta|
      next if meta == 0
      next if meta > @children.length
      sum += @children[ meta - 1].value
    end

    sum
  end
end