class Cube4D
  attr_reader :x, :y, :z, :w, :future_state

  def initialize(x, y, z, w, active: false)
    @x = x
    @y = y
    @z = z
    @w = w

    @active = active
  end

  def active?
    @active
  end

  def activate
    @active = true
  end

  def deactivate
    @active = false
  end

  def mark_for_activation
    @future_state = true
  end

  def mark_for_deactivation
    @future_state = false
  end

  def toggle
    @active = @future_state unless @future_state.nil?
    @future_state = nil
  end

  def neighbor_coordinates
    neighbors = Array.new
    ((@x - 1)..(@x + 1)).each do |x|
      ((@y - 1)..(@y + 1)).each do |y|
        ((@z - 1)..(@z + 1)).each do |z|
          ((@w - 1)..(@w + 1)).each do |w|
            neighbors.push [x, y, z, w] unless @x == x and @y == y and @z == z and @w == w
          end
        end
      end
    end

    neighbors
  end

  def to_s
    "#{@x},#{@y},#{z},#{w}" + (active? ? '#' : '')
  end
end