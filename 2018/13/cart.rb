require 'factory_bot'

class Cart
  attr_accessor :id
  attr_accessor :direction
  attr_accessor :next_turn
  attr_accessor :x, :y
  attr_accessor :crashed

  def move
    case @direction
    when '^'
      @y -= 1
    when '<'
      @x -= 1
    when 'v'
      @y += 1
    when '>'
      @x += 1
    end
  end

  def turn
    case @next_turn
    when :left
      turn_left
      @next_turn = :straight
    when :right
      turn_right
      @next_turn = :left
    when :straight
      @next_turn = :right
    end
  end

  def turn_left
    case @direction
    when '>'
      @direction = '^'
    when '^'
      @direction = '<'
    when '<'
      @direction = 'v'
    when 'v'
      @direction = '>'
    end
  end

  def turn_right
    case @direction
    when '>'
      @direction = 'v'
    when '^'
      @direction = '>'
    when '<'
      @direction = '^'
    when 'v'
      @direction = '<'
    end
  end

end

FactoryBot.define do
  factory :cart do
    sequence(:id) {|id| id}
    next_turn {:left}
    crashed {false}
  end
end