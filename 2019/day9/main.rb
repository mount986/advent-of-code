require_relative '../lib/int_code'
program = File.new('input.dat').read().split(',').map{|line| line.to_i }

computer = IntCode.new(program: program.clone, input: [1])
computer.run_program

while output = computer.receive
  puts output
end


computer = IntCode.new(program: program.clone, input: [2])
computer.run_program

while output = computer.receive
  puts output
end
