class BalancingTower
  class << self
    attr_accessor :towers
  end

  @towers = Array.new

  def self.get_tower(name)
    @towers.each do |tower|
      return tower if tower.name == name
    end

    return nil
  end

  def self.build_towers
    @towers.each do |tower|
      tower.children.map!{|child| get_tower(child)}
    end
  end

  attr_accessor :name
  attr_accessor :children
  attr_accessor :weight

  def initialize(name, weight, *children)
    @name = name
    @weight = weight
    @children = children.flatten

    BalancingTower.towers.push self
  end

  def has_children?
    return !@children.empty?
  end

  def total_weight
    total_weight = @weight

    @children.each do |child|
      total_weight += child.total_weight
    end

    total_weight
  end

  def balanced?
    weights = Hash.new
    @children.each do |child|
      weights[child.name] = child.total_weight
    end

    return weights.values.uniq.count <= 1
  end


end