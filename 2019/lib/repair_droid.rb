class RepairDroid
  attr_reader :program
  attr_reader :pos_x, :pos_y
  attr_reader :map
  attr_reader :target

  def initialize(program, debug: false)
    @program = IntCode.new(name: 'Repair Droid', program: program, debug: debug)

    @pos_x = 0
    @pos_y = 0    

    @map = Hash.new
    @map["#{@pos_x},#{@pos_y}"] = Node.new(@pos_x, @pos_y)
  end

  def run!
    until @program.state == :finished
      if @program.has_output?
        process_move(@program.receive)
      end

      if @program.state == :waiting_input
        @program.send(next_direction)
      end

      @program.compute
    end
  end

  private

  def process_move(response)
    case response
    when 0
      wall!
    when 1
      move!
    when 2
      move!
      found!
    else
      raise "Unexpected move response: #{response}"
    end

  end

  def wall!
    @map["#{@attempt_x},#{@attempt_y}"] = Wall.new(@attempt_x, @attempt_y)
  end
  
  def move!
    @map["#{@attempt_x},#{@attempt_x}"] = Node.new(@attempt_x, @attempt_x)
    @map["#{@attempt_x},#{@attempt_x}"].add_link(@map["#{@pos_x},#{@pos_y}"])
    @map["#{@pos_x},#{@pos_y}"].add_link(@map["#{@attempt_x},#{@attempt_x}"])

    @pos_x = @attempt_x
    @pos_y = @attempt_y
  end

  def found!
    @target = @map["#{@pos_x},#{@pos_y}"]
  end
end

class Node
  attr_reader :pos_x, :pos_y
  attr_reader :links
  attr_reader :distance_from_center

  def initialize(x, y)
    @pos_x = x
    @pos_y = y

    @links = Array.new
    @distance_from_center = 0 if x == 0 and y == 0
  end

  def add_link(other_node)
    @linkes.push other_node

    if @distance_from_center.nil? or @distance_from_center > other_node.distance_from_center + 1
      @distance_from_center = other_node.distance_from_center + 1
    end
  end
end

class Wall < Node
  def add_link(other_node)

  end
end