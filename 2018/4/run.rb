require 'active_support'
require 'active_support/core_ext'
require './calendar'

calendar = Calendar.new
calendar.read_entries('input.txt')
calendar.sort_entries!
# calendar.write_entries('sorted_input.txt')
calendar.build_timeline

puts "First best time: #{calendar.best_time_1}"
puts "Second best time: #{calendar.best_time_2}"