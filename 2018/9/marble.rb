class Marble
  attr_accessor :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
  end

  def add_to_right(new_marble)
    new_marble.left = self
    new_marble.right = @right
    @right.left = new_marble
    @right = new_marble
  end

  def remove
    @left.right = @right
    @right.left = @left
  end
end