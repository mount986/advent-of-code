class PipeNode

  class << self
    attr_accessor :nodes
  end

  @nodes = Array.new

  def self.get_node(name)
    @nodes.each do |node|
      return node if node.name == name
    end

    return nil
  end
  
  def self.build_nodes
    @nodes.each do |node|
      node.children.map!{|child| get_node(child)}
    end
  end

  def self.build_group(name, group = [])
    current_node = get_node(name)
    return if group.include? current_node

    group.push current_node
    current_node.children.each do |child|
      build_group(child.name, group)
    end

    group
  end

  attr_accessor :name
  attr_accessor :children

  def initialize(name, *children)
    @name = name
    @children = children.flatten || []

    PipeNode.nodes.push self
  end
end