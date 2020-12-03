class Gift
  attr_reader :height, :width, :length

  def initialize(dimensions)
    @width, @length, @height = dimensions.split('x').map{|num| num.to_i}.sort
  end

  def surface_area
    2 * @height * @width + 2 * @width * @length + 2 * @length * @height
  end

  def extra
    @width * @length
  end

  def perimeter
    2 * @width + 2 * @length
  end

  def volume
    @height * @width * @length
  end

  def paper_needed
    surface_area + extra
  end

  def ribbon_needed
    perimeter + volume
  end
end