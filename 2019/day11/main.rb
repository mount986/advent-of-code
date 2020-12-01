require_relative '../lib/int_code'
require_relative '../lib/painter'
program = File.new('input.dat').read().split(',').map { |line| line.to_i }

painter1 = Painter.new(IntCode.new(program: program.clone))

painter1.run

puts painter1.num_cells_painted


painter2 = Painter.new(IntCode.new(program: program.clone), starting_color: 1)

painter2.run

painter2.print