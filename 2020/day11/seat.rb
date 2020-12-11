class Seat
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y

    @occupied = false
    @unchanged = false
  end

  def empty?
    !@occupied
  end

  def occupied?
    @occupied
  end

  def occupy
    @occupied = true
  end

  def empty
    @occupied = false
  end

  def prepare_to(state)
    @future_state = state
  end

  def unchanged?
    @unchanged
  end

  def update
    if @future_state.nil?
      @unchanged = true
    else
      send(@future_state)
      @unchanged = false
      @future_state = nil
    end
  end

  def to_s
    (@occupied ? '#' : 'L')
  end
end