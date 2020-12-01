require './lib/advent_of_code'
require './lib/balancing_tower'

parent_list = Array.new
child_list = Array.new

File.readlines('bin/day_7/recursive_circus.dat').each do |line|
  if line.include? '->'
    parent_info, child_info = line.split('->')

    parent_name, weight = parent_info.strip.split(' ')
    children_names = child_info.strip.split(', ')    
  else
    parent_name, weight = line.strip.split(' ')
    children_names = []
  end
  BalancingTower.new(parent_name, weight.delete('()').to_i, children_names)
end

BalancingTower.build_towers

unbalanced_towers = Array.new

BalancingTower.towers.each do |tower|
  unbalanced_towers.push tower unless tower.balanced?
end

unbalanced_towers.each do |tower|
  puts "#{tower.name} #{tower.weight}"
  tower.children.each do |child|
    puts "   #{child.name} #{child.weight} #{child.total_weight}"
  end
end