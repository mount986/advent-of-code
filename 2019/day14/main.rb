require_relative '../lib/nanofactory'
input = File.new('input.dat').readlines().map{|line| line.strip }
# input = File.new('test1.dat').readlines().map{|line| line.strip }
# input = File.new('test2.dat').readlines().map{|line| line.strip }
# input = File.new('test3.dat').readlines().map{|line| line.strip }

factory = Nanofactory.new(input)

factory.gather_ingredients(element: 'FUEL', needed_quantity: 1)
puts factory.total_ore

factory = Nanofactory.new(input)

puts factory.max_fuel(1_000_000_000_000)

# factory.store_one_fuel_state
# max_ore = 1_000_000_000_000
#
# while factory.total['ORE'] < (max_ore - factory.one_fuel_total['ORE'])
#   factory.increase_by((((max_ore  - factory.total['ORE'])/ factory.one_fuel_total['ORE']) / 2) + 1)
#
#   until factory.ore_needed?
#     factory.gather_ingredients(element: 'FUEL', needed_quantity: factory.total['FUEL'] + 1 )
#   end
# end
#
# puts factory.total['FUEL']