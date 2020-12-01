require './fighter'
require './location'
require './move_attempt'

class Arena
  attr_accessor :map
  attr_accessor :ogres
  attr_accessor :elves
  attr_accessor :rounds

  def initialize(input_file)
    @map = Hash.new
    @ogres = Array.new
    @elves = Array.new
    @rounds = 0

    y = 1
    File.readlines(input_file).each do |line|
      x = 1
      line.strip.chars.each do |char|
        case char
        when 'E'
          @elves.push FactoryBot.build(:elf)
          @map["#{x},#{y}"] = FactoryBot.build(:location, x: x, y: y, fighter: @elves.last)
          @elves.last.location = location(x,y)
        when 'G'
          @ogres.push FactoryBot.build(:ogre)
          @map["#{x},#{y}"] = FactoryBot.build(:location, x: x, y: y, fighter: @ogres.last)
          @ogres.last.location = location(x,y)
        when '.'
          @map["#{x},#{y}"] = FactoryBot.build(:location, x: x, y: y)
        end
        add_connections(location(x,y))
        x += 1
      end
      y += 1
    end
  end

  def add_connections(location)
    [[location.x + 1, location.y],
     [location.x, location.y + 1],
     [location.x - 1, location.y],
     [location.x, location.y - 1]].each do |x, y|

      unless location(x, y).nil?
        location.add_connection(location(x, y))
        location(x, y).add_connection(location)
      end
    end
  end

  def location(x, y)
    @map["#{x},#{y}"]
  end

  def fight_round
    (@ogres + @elves).sort_by {|fighter| [fighter.location.y, fighter.location.x]}.each do |fighter|
      enemies = (fighter.type == :elf ? @ogres : @elves)

      move(fighter, enemies)
      attack(fighter, enemies)

      return :game_over if enemies.empty?
    end

    @rounds += 1
    :continue
  end

  def move(fighter, enemies)
    attack_locations = locate_enemies(enemies)
    location_choice = Array.new
    attack_locations.each do |location|
      move_attempt = MoveAttempt.new(self, fighter.location, location)

      distance = move_attempt.shortest_distance
      next if distance == -1
      if distance < shortest_distance
        shortest_distance = distance
        location_choice = [move_attempt.next_location]
      elsif distance == shortest_distance
        location_choice.push move_attempt.next_location
      end
    end

    unless location_choice.empty?
      next_location = location_choice.sort_by {|loc| [loc.y, loc.x]}.first
      fighter.location.fighter = nil
      next_location.fighter = fighter
      fighter.location = next_location
    end
  end

  def attack(fighter, enemies)

  end

  def locate_enemies(enemies)
    attack_locations = Array.new
    enemies.each do |enemy|

      attack_locations.push location(enemy.location.x + 1, enemy.location.y) if location(enemy.location.x + 1, enemy.location.y).open?
      attack_locations.push location(enemy.location.x - 1, enemy.location.y) if location(enemy.location.x - 1, enemy.location.y).open?
      attack_locations.push location(enemy.location.x, enemy.location.y + 1) if location(enemy.location.x, enemy.location.y + 1).open?
      attack_locations.push location(enemy.location.x, enemy.location.y - 1) if location(enemy.location.x, enemy.location.y - 1).open?
    end

    attack_locations
  end

  def reset_distances
    @map.values.each do |loc|
      loc.reset
    end
  end
end