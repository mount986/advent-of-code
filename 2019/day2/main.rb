require_relative '../lib/int_code'
program = File.new('input.dat').read().split(',').map{|line| line.to_i }

computer = IntCode.new(program: program.clone)
computer.alter_program('1': 12, '2': 2)
computer.run_program
puts computer.program[0]


target = 19690720
solved = false

(0..99).each do |noun|
	(0..99).each do |verb|
		computer = IntCode.new(program: program.clone)
		computer.alter_program('1': noun, '2': verb)
		computer.run_program
		result = computer.program[0]

		if result == target
			solved = true
			puts "#{noun}#{verb}"
			break
		end
	end
	break if solved
end