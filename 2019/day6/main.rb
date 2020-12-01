require_relative '../lib/solar_system'
require_relative '../lib/solar_system'

SolarSystem.load('input.dat')

puts SolarSystem.total_size

your_parents = SolarSystem.get_orbital('YOU').get_parent_list
santa_parents =  SolarSystem.get_orbital('SAN').get_parent_list

puts your_parents.difference(santa_parents).size + santa_parents.difference(your_parents).size