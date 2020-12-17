require_relative 'cube3_d'

class Pocket3Dimension

  attr_reader :cubes

  def initialize(initial_state)
    @cubes = Hash.new

    initial_state.each_with_index do |row, y|
      row.chars.each_with_index do |state, x|
        get_cube(x, y, 0).activate if state == '#'
      end
    end

    @cubes.values.each { |cube| cube.neighbor_coordinates.each { |c| get_cube(c[0], c[1], c[2]) } }
  end

  def get_cube(x, y, z)
    @cubes["#{x},#{y},#{z}"] ||= Cube3D.new(x, y, z)
  end

  def start_cycle
    @cubes.values.each do |cube|
      neighbors_active_count = cube.neighbor_coordinates.map { |c| get_cube(c[0], c[1], c[2]) }.count { |cube| cube.active? }
      cube.mark_for_deactivation if cube.active? and not (neighbors_active_count == 2 or neighbors_active_count == 3)
      cube.mark_for_activation if neighbors_active_count == 3 and not cube.active?
    end

    @cubes.values.each { |cube| cube.toggle }
  end
end