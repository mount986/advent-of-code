class Bus
  attr_accessor :id, :pos

  def initialize(id, pos)
    @id = id
    @pos = pos
  end

  def time_until_departure(current_time)
    @id - (current_time % id)
  end
end
