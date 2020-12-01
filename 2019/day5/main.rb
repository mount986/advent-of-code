require_relative '../lib/int_code'
program = File.new('input.dat').read().split(',').map{|line| line.to_i }

computer = IntCode.new(program: program.clone, input: [1])
computer.run_program
puts computer.response


computer = IntCode.new(program: program.clone, input: [5])
computer.run_program
puts computer.response
