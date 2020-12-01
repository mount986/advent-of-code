class FirewallLayer
  class << self
    attr_accessor :layers
  end

  @layers = Array.new

  attr_accessor :depth, :range

  def initialize(depth, range)
    @depth = depth
    @range = range

    FirewallLayer.layers.push self
  end

  def collision?(delay = 0)
    return (delay + depth) % (range * 2 - 2) == 0
  end
end