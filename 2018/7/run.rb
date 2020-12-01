require './directions'
require './worker'

directions = Directions.new('input.txt')
puts "Perform the steps in this order: #{directions.print_steps}"

directions = Directions.new('input.txt')
workers = Array.new(5) {Worker.new}

timeline = 0

until directions.all_steps_complete?
  workers.each do |worker|
    if worker.ready?
      worker.new_step(directions.next_step)
    end
  end
  workers.each do |worker|
    worker.work
  end
  timeline += 1
end

puts "Total Time to Complete: #{timeline}"
