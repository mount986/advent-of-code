require './light'

class Sky
  attr_accessor :lights

  def initialize(input_file)
    @lights = Array.new
    File.open(input_file, 'r').each_line do |line|
      match_data = /position=\<\s*(?<pos_x>-?\d+),\s*(?<pos_y>-?\d+)\> velocity=\<\s*(?<vel_x>-?\d+),\s*(?<vel_y>-?\d+)\>/.match(line)
      lights.push Light.new(match_data[:pos_x].to_i,
                            match_data[:pos_y].to_i,
                            match_data[:vel_x].to_i,
                            match_data[:vel_y].to_i)
    end

    @step = 0
  end

  def show_lights
    min_x = @lights.min {|light_1, light_2| light_1.pos_x <=> light_2.pos_x}.pos_x
    min_y = @lights.min {|light_1, light_2| light_1.pos_y <=> light_2.pos_y}.pos_y
    max_x = @lights.max {|light_1, light_2| light_1.pos_x <=> light_2.pos_x}.pos_x
    max_y = @lights.max {|light_1, light_2| light_1.pos_y <=> light_2.pos_y}.pos_y

    if (max_x - min_x).abs > 100
      puts "Step #{@step}: The sky is too wide to print: (#{min_x}, #{min_y}) (#{max_x}, #{max_y})"
      return
    end

    sky_string = ''

    (min_y..max_y).each do |y|
      (min_x..max_x).each do |x|
        if @lights.any? {|light| light.at_position?(x, y)}
          sky_string << '#'
          next
        end
        sky_string << '.'
      end
      sky_string << "\n"
    end

    File.write("output_#{@step}", sky_string)
    puts "Wrote Step #{@step} to file output_#{@step}"

  end

  def time_passes
    @lights.each do |light|
      light.move
    end

    @step += 1
  end

  def speed_up(num)
    @lights.each do |light|
      light.jump(num)
    end

    @step += num
  end

end