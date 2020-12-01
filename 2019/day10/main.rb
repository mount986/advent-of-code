require_relative '../lib/astroid_belt'

astroid_map = File.readlines('input.dat')

belt = AstroidBelt.new(astroid_map)

belt.find_best_tracker_location
puts belt.tracker_astroid.field_of_view.size

belt.tracker_astroid.target_for_elimination

puts belt.tracker_astroid.targets[199]