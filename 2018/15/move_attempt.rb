class MoveAttempt
  attr_accessor :map
  attr_accessor :start_location
  attr_accessor :target_location
  attr_accessor :steps
  attr_accessor :shortest_path
  attr_accessor :next_location

  def initialize(map, start, target)
    @map = map
    @start_location = start
    @target_location = target
    @steps = 0
    @shortest_path = nil
    @tried_locations = Hash.new
  end

  def shortest_distance
    @next_location = attempt_to_reach?(@start_location)
    (@next_location.nil? ? -1 : @steps)
  end

  def attempt_to_reach_2(current_location, current_length)
    return if current_location == @target_location
    return if current_length > @shortest_path

  end

  def attempt_to_reach?(current_location)
    path_found = current_location == @target_location

    return current_location if

    return nil if @tried_locations.include? current_location

    @steps += 1
    @tried_locations.push current_location

    target_directions = current_location.direction_towards(@target_location)
    target_directions.each do |direction|
      next_location = try_direction(current_location, direction)
      unless next_location.nil?
        return next_location unless attempt_to_reach?(next_location).nil?
      end
    end

    next_location = try_step_toward(current_location)
    unless next_location.nil?
      return next_location unless attempt_to_reach?(next_location).nil?
    end
    next_location = try_left_turn(current_location)
    unless next_location.nil?
      return next_location unless attempt_to_reach?(next_location).nil?
    end
    next_location = try_right_turn(current_location)
    unless next_location.nil?
      return next_location unless attempt_to_reach?(next_location).nil?
    end

    @steps -= 1
    return nil
  end

  def try_direction(current_location, direction)
    next_location =
        case direction
        when :north
          @map.location(current_location.x + 1, current_location.y)
        when :east
          @map.location(current_location.x, current_location.y + 1)
        when :south
          @map.location(current_location.x - 1, current_location.y)
        when :west
          @map.location(current_location.x, current_location.y - 1)
        end

    (next_location.open? ? next_location : nil)
  end
end