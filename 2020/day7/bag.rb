class Bag
  class << self
    attr_accessor :bags
  end

  @bags = Hash.new

  def self.get_bag(name)
    bag = @bags[name]
    if bag.nil?
      bag = Bag.new(name)
      @bags[name] = bag
    end

    bag
  end

  def self.parse_rule(rule)
    match, descriptor, name = rule.match(/(\w+) (\w+) bags contain/).to_a
    bag_name = "#{descriptor} #{name}"
    bag = get_bag(bag_name)

    rule.scan(/(\d+) (\w+) (\w+) bag/).each do |content|
      count, descriptor, name = content
      child_name = "#{descriptor} #{name}"
      bag.add_child(child_name, count.to_i)
      get_bag(child_name).add_parent(bag_name)
    end
  end

  def self.can_include_list(name)
    valid_bags = Array.new
    @bags.values.each do |bag|
      if bag.include?(name)
        valid_bags = valid_bags + bag.parent_list + [bag.name]
      end
    end

    valid_bags.uniq
  end

  attr_reader :name, :children, :parents

  def initialize(name)
    @name = name
    @children = Hash.new
    @parents = Array.new
  end

  def add_parent(name)
    @parents.push name
  end

  def add_child(name, count)
    @children[name] = count
  end

  def parent_list
    list = @parents

    @parents.each do |parent|
      list = list + self.class.get_bag(parent).parent_list
    end

    list
  end

  def include?(name)
    @children.keys.include?(name)
  end

  def child_count
    sum = 0

    children.each do |name, count|
      sum += count * (self.class.get_bag(name).child_count + 1)
    end

    sum
  end
end