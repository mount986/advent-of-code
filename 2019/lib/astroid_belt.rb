class AstroidBelt
  attr_reader :astroids
  attr_reader :tracker_astroid

  def initialize(map)
    @astroids = Array.new
    @tracker_astroid = nil

    map.each_index do |y|
      row = map[y].strip.chars
      row.each_index do |x|
        @astroids.push Astroid.new(x, y) if row[x] == '#'
      end
    end
  end

  def has_astroid(x, y)
    @astroids.include? Astroid.new(x, y)
  end

  def find_best_tracker_location
    most_astroids = 0

    @astroids.each do |astroid|
      astroid.scan(@astroids)
      num_seen = astroid.field_of_view.size
      if num_seen > most_astroids
        most_astroids = num_seen
        @tracker_astroid = astroid
      end
    end

    most_astroids
  end

  def sort_astroids
    @tracker_astroid.sort
  end
end

class Astroid
  attr_reader :pos_x, :pos_y
  attr_reader :field_of_view
  attr_reader :targets

  def initialize(x, y)
    @pos_x = x
    @pos_y = y

    @field_of_view = Hash.new
    @targets = Array.new
  end

  def to_s
    "#{@pos_x}, #{@pos_y}"
  end

  def ==(other_astroid)
    other_astroid.pos_x == @pos_x and other_astroid.pos_y == @pos_y
  end

  def scan(field)
    field.each do |astroid|
      next if self == astroid

      slope = slope(astroid)
      if @field_of_view[slope].nil?
        @field_of_view[slope] = Array.new
      end

      @field_of_view[slope].push astroid
    end

    return @field_of_view.size
  end

  def slope(other_astroid)
    slope = nil

    diff_x = (other_astroid.pos_x - @pos_x).to_f
    diff_y = (other_astroid.pos_y - @pos_y).to_f

    if diff_x == 0
      if diff_y > 0
        slope = 0
      else
        slope = 200
      end
    elsif diff_y == 0
      if diff_x > 0
        slope = 100
      else
        slope = -100
      end
    else
      slope = (diff_y / diff_x).abs

      if diff_x > 0 and diff_y < 0
        slope = 100 + slope
      elsif diff_x > 0 and diff_y > 0
        slope = 100 - slope
      elsif diff_x < 0 and diff_y > 0
        slope = -100 + slope
      elsif diff_x < 0 and diff_y < 0
        slope = -100 - slope
      end
    end

    slope
  end

  def target_for_elimination
    target_order = @field_of_view.keys.sort.reverse

    @field_of_view.each do |slope, astroids|
      astroids.sort { |a, b| (a.pos_x * a.pos_y).abs <=> (b.pos_x * b.pos_y).abs }
    end

    until @field_of_view.empty?
      target_order.each do |slope|
        @targets.push @field_of_view[slope].shift
        if @field_of_view[slope].empty?
          @field_of_view.delete(slope)
          target_order.delete(slope)
        end
      end
    end
  end
end