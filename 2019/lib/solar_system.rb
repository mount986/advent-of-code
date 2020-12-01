require_relative './orbital'

class SolarSystem
  @orbitals = Hash.new

  class << self
    attr_reader :orbitals
  end

  def self.get_orbital(id, parent_id: nil)
    @orbitals[id] = Orbital.new(id: id, parent_id: parent_id) if @orbitals[id].nil?

    return @orbitals[id]
  end

  def self.total_size
    sum = 0

    @orbitals.each do |id, orbital|
      sum += orbital.distance_from_center
    end

    sum
  end

  def self.load(system_definition)
    @orbitals['COM'] = Orbital.new(id: 'COM')

    File.readlines(system_definition).each do |definition|
      parent_id, child_id = definition.strip.split(')')

      get_orbital(child_id, parent_id: parent_id)
    end
  end


end
