require_relative './int_code'
class Arcade
  attr_accessor :tiles
  attr_accessor :score
  attr_accessor :program

  def self.free_play(program)
    game = self.new(program)
    game.program.alter_program('0': 2)

    game
  end

  def initialize(program)
    @program = IntCode.new(name: "Arcade", program: program)

    @tiles = Array.new
    @score = 0
    @paddle_position = 0
    @ball_position = 0
  end

  def play
    until @program.state == :finished
      @program.compute

      if @program.state == :waiting_input
        move_paddle()
      end

      if @program.output.size == 3
        x = @program.receive
        y = @program.receive
        id = @program.receive

        if x == -1 and y == 0
          @score = id
        else
          @paddle_position = x if id == 3
          @ball_position = x if id == 4

          @tiles.push Tile.new(x: x, y: y, id: id)
        end
      end
    end
  end

  def move_paddle
    if @paddle_position < @ball_position
      @program.send(1)
    elsif @paddle_position > @ball_position
      @program.send(-1)
    else
      @program.send(0)
    end
  end

  def num_blocks
    @tiles.select { |tile| tile.id == 2 }.count
  end

end

class Tile
  attr_reader :pos_x, :pos_y
  attr_reader :id

  def initialize(x: nil, y: nil, id: nil)
    raise "X value not specified" if x.nil?
    raise "Y value not specified" if y.nil?
    raise "ID not specified" if id.nil?

    @pos_x = x
    @pos_y = y
    @id = id
  end
end