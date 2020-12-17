class Ticket
  attr_reader :fields
  attr_accessor :departure_location
  attr_accessor :departure_station
  attr_accessor :departure_platform
  attr_accessor :departure_track
  attr_accessor :departure_date
  attr_accessor :departure_time
  attr_accessor :arrival_location
  attr_accessor :arrival_station
  attr_accessor :arrival_platform
  attr_accessor :arrival_track
  attr_accessor :class
  attr_accessor :duration
  attr_accessor :price
  attr_accessor :route
  attr_accessor :row
  attr_accessor :seat
  attr_accessor :train
  attr_accessor :type
  attr_accessor :wagon
  attr_accessor :zone

  def initialize(fields)
    @fields = fields.chomp.split(',').map { |field| field.to_i }
    @valid = true
  end

  def invalidate
    @valid = false
  end

  def valid?
    @valid
  end
end
