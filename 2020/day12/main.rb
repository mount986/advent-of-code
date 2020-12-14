require_relative 'ferry'
require_relative 'ferry_waypoint'

directions = File.readlines('input.dat')

ferry = Ferry.new
ferry.navigate(directions)

puts ferry.distance

ferry_with_waypoint = FerryWaypoint.new
ferry_with_waypoint.navigate(directions)

puts ferry_with_waypoint.distance
