class Image
  attr_reader :layers
  attr_reader :image

  def initialize(stream)
    @layers = Array.new
    load_layers(stream)

    @image = Layer.emptyLayer
  end

  def load_layers(stream)
    stream.each_char do |pixel|
      if @layers.empty? or layers.last.full?
        @layers.push Layer.new
      end

      @layers.last.add_pixel(pixel)
    end
  end

  def largest_layer
    largest_layer = nil

    @layers.each do |layer|
      largest_layer = layer if largest_layer.nil? or layer.count('0') < largest_layer.count('0')
    end

    largest_layer
  end

  def build_image
    @layers.each do |layer|
      @image.size_y.times do |y|
        @image.size_x.times do |x|
          if @image.pixels[y][x].nil? or @image.pixels[y][x] == '2'
            @image.pixels[y][x] = layer.pixels[y][x]
          end
        end
      end
    end
  end

  def print
    @image.print
  end
end

class Layer
  attr_reader :size_x, :size_y
  attr_reader :pixels

  def self.emptyLayer
    layer = self.new
    (layer.size_x * layer.size_y).times do
      layer.add_pixel('2')
    end

    layer
  end

  def initialize
    @size_x = 25
    @size_y = 6

    @pixels = Array.new
  end

  def add_pixel(pixel)
    if @pixels.empty? or @pixels.last.size == @size_x
      @pixels.push Array.new
    end

    @pixels.last.push pixel
  end

  def full?
    @pixels.flatten.size == @size_x * @size_y
  end

  def count(color)
    @pixels.flatten.select { |pixel| pixel == color }.size
  end

  def print
    @pixels.each do |row|
      row.each do |pixel|
        $stdout << case pixel
                   when '0'
                     ' '
                   when '1'
                     'X'
                   else
                     '_'
                   end
      end
      $stdout << "\n"
    end
  end
end