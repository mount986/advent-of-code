class Node
  attr_accessor :owner, :x, :y, :distance

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class SuperNode < Node
  attr_accessor :id
  attr_accessor :size

  @last_id = 0

  def self.next_id
    @last_id += 1

    @last_id
  end

  def initialize(x, y)
    @id = SuperNode.next_id
    @owner = @id
    @size = 0

    @x = x
    @y = y
  end

  def expand
    @size += 1
  end
end

class NilNode < SuperNode
  NIL_ID = -99999

  def initialize(x, y)
    @id = NIL_ID
    @owner = @id
    @size = 0

    @x = x
    @y = y
  end

  def expand
    @size = 0
  end
end