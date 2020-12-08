require_relative 'bag'

rules = File.readlines('input.dat')

rules.each do |rule|
  Bag.parse_rule(rule)
end

puts Bag.can_include_list('shiny gold').count

puts Bag.get_bag('shiny gold').child_count
