class Gift
  attr_reader :height, :width, :length

  def initialize(dimensions)
    @height, @length, @width = dimensions.split('x')
  end

  def surface_area
    2 * height * width + 2 * width * 
  end
end