class Jupiter
  attr_reader :moons
  attr_reader :steps

  def initialize
    @moons = Array.new
    @moon_names = ['Io', 'Europa', 'Ganymede', 'Callisto']

    @steps = 0
  end

  def add_moon(moon_def)
    positions = moon_def.strip.delete('<>').split(', ')

    x = 0
    y = 0
    z = 0
    positions.each do |pos|
      case pos[0]
      when 'x'
        x = pos.split('=').last.to_i
      when 'y'
        y = pos.split('=').last.to_i
      when 'z'
        z = pos.split('=').last.to_i
      else
        raise "unknown dimension #{pos}"
      end
    end

    @moons.push Moon.new(name: @moon_names.shift, x: x, y: y, z: z)

  end

  def total_energy
    energy = 0

    @moons.each do |moon|
      energy += moon.total_energy
    end

    energy
  end

  def cycle
    @moons.each do |moon|
      moon.apply_gravity(@moons)
    end

    @moons.each do |moon|
      moon.move
    end

    @steps += 1
  end

  def check_for_repeats

  end

  def print_state
    puts "step: #{@steps}"

    @moons.each do |moon|
      moon.print_state
    end

    puts ""
  end
end

class Moon
  attr_reader :name
  attr_reader :pos_x, :pos_y, :pos_z
  attr_reader :vel_x, :vel_y, :vel_z
  attr_reader :history_x, :history_y, :history_z
  
  def initialize(name: nil, x: 0, y: 0, z: 0)
    @name = name

    @pos_x = x
    @pos_y = y
    @pos_z = z
    
    @vel_x = 0
    @vel_y = 0
    @vel_z = 0

    @history_x = Hash.new
    @history_y = Hash.new
    @history_z = Hash.new
    add_current_to_history(0)
  end
  
  def apply_gravity(moons)
    moons.each do |moon|
      next if self == moon
      
      if @pos_x > moon.pos_x
        @vel_x -= 1
      elsif @pos_x < moon.pos_x
        @vel_x += 1
      end      

      if @pos_y > moon.pos_y
        @vel_y -= 1
      elsif @pos_y < moon.pos_y
        @vel_y += 1
      end

      if @pos_z > moon.pos_z
        @vel_z -= 1
      elsif @pos_z < moon.pos_z
        @vel_z += 1
      end
    end
  end

  def ==(moon)
    moon.name == @name
  end
  
  def move
    @pos_x += @vel_x
    @pos_y += @vel_y
    @pos_z += @vel_z
  end

  def pos_to_s
    "#{@pos_x},#{@pos_y},#{@pos_y}"
  end

  def vel_to_s
    "#{@vel_x},#{@vel_y},#{@vel_z}"
  end

  def add_current_to_history(steps)
    @history_x["#{@pos_x},#{@vel_x}"] = steps
    @history_y["#{@pos_y},#{@vel_y}"] = steps
    @history_z["#{@pos_z},#{@vel_z}"] = steps
  end
  
  def potential_energy
    @pos_x.abs + @pos_y.abs + @pos_z.abs
  end
  
  def kinetic_energy
    @vel_x.abs + @vel_y.abs + @vel_z.abs    
  end
  
  def total_energy
    potential_energy * kinetic_energy
  end

  def to_s
    "<#{pos_to_s}><#{vel_to_s}>"
  end
  
  def print_state
    puts "name: #{@name}, pos: <#{pos_to_s}>, vel: <#{vel_to_s}>"
  end

  def is_repeat?
    (not history[to_s].nil?)
  end
end