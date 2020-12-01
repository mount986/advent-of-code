class Register < Hash
  attr_reader :max

  def initialize
    @max = 0
  end

  def [](key)
    super(key) || 0
  end

  def []=(key, value)
    super(key, value)

    @max = value if value > @max
  end

  def inc(reg, val)
    self[reg] += val
  end

  def dec(reg, val)
    self[reg] -= val
  end
end