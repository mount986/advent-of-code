class Orbital
  attr_reader :id
  attr_accessor :parent

  def initialize(id: nil, parent_id: nil)
    @id = id
    @parent = parent_id
  end

  def distance_from_center
    return 0 if @id == 'COM'

    SolarSystem.orbitals[@parent].distance_from_center + 1
  end

  def get_parent_list
    return [] if SolarSystem.orbitals[@parent].nil?

    parents = [@parent] + SolarSystem.orbitals[@parent].get_parent_list

    parents
  end

  def to_s
    @id
  end
end