require_relative 'rule'
require_relative 'ticket'

rules, my_ticket, nearby_tickets = File.readlines('input.dat', "\n\n", chomp: true)
# rules, my_ticket, nearby_tickets = File.readlines('test.dat', "\n\n", chomp: true)

rules = rules.split("\n").map { |rule| Rule.new(rule) }
nearby_tickets = nearby_tickets.split("\n")
nearby_tickets.shift
nearby_tickets.map! { |ticket| Ticket.new(ticket) }

my_ticket = Ticket.new(my_ticket.split("\n").last)
invalid_fields = Array.new

nearby_tickets.each do |ticket|
  ticket.fields.each do |field|
    found = false
    rules.each do |rule|

      if rule.match?(field)
        found = true
        break
      end
    end

    unless found
      invalid_fields.push field
      ticket.invalidate
    end
  end
end

puts invalid_fields.sum

valid_tickets = nearby_tickets.select { |ticket| ticket.valid? }

all_possible_rules = Array.new

my_ticket.fields.length.times do |index|
  field_values = valid_tickets.collect { |ticket| ticket.fields[index] }
  possible_rules = Array.new
  rules.each do |rule|
    possible_rules.push rule.name if rule.match_all?(field_values)
  end

  all_possible_rules.push possible_rules
end

until all_possible_rules.all? { |possible_rules| possible_rules.length == 1 }
  all_possible_rules.each do |considered_rule|
    if considered_rule.length == 1
      found_rule = considered_rule.first
      all_possible_rules.each { |rule| rule.delete(found_rule) }
      considered_rule.push found_rule
    end
  end
end

all_possible_rules.flatten!

departure_fields = Array.new

my_ticket.fields.length.times do |index|
  departure_fields.push my_ticket.fields[index] if all_possible_rules[index].start_with?("departure")
end

puts departure_fields.reduce(:*)