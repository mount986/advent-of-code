require 'factory_bot'

class Location
  attr_accessor :x, :y
  attr_accessor :fighter
  attr_accessor :connections
  attr_accessor :distance

  def has_fighter?
    @fighter.nil?
  end

  def to_s
    "(#{@x},#{@y})"
  end

  def connect_to(other_loc)
    @connections.push other_loc unless @connections.include? other_loc
  end

  def reset
    @distance = 100_000
  end
end

FactoryBot.define do
  factory :location, class: Location do
    connections {Array.new}
  end
end

erb.result(binding)