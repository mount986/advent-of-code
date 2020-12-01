require_relative '../lib/int_code'
program = File.new('input.dat').read().split(',').map { |line| line.to_i }

max_thruster = 0

[0, 1, 2, 3, 4].permutation do |phases|
  input = 0

  amplifier = nil
  phases.each do |phase|
    amplifier = IntCode.new(program: program.clone, input: [phase, input])

    amplifier.run_program

    input = amplifier.response
  end

  max_thruster = amplifier.response if amplifier.response > max_thruster
end

puts max_thruster


max_thruster = 0

[5, 6, 7, 8, 9].permutation do |phases|
# [[5, 6, 7, 8, 9]].each do |phases|
  amplifiers = Array.new

  index = 'A'
  phases.each do |phase|
    amplifiers.push IntCode.new(name: "Amplifier #{index}", program: program.clone, input: [phase], debug: false)
    amplifiers.last.state = :waiting_input

    index.next!
  end

  amplifiers[0].send(0)

  finished = false

  until finished
    (0..4).each do |index|
      if amplifiers[index].state == :waiting_input
        amplifiers[index].send amplifiers[index - 1].receive
      end
      while amplifiers[index].state == :running
        amplifiers[index].compute
      end
    end

    if amplifiers[0].state == :finished and
        amplifiers[1].state == :finished and
        amplifiers[2].state == :finished and
        amplifiers[3].state == :finished and
        amplifiers[4].state == :finished
      finished = true
    end
  end

  max_thruster = amplifiers[4].response if amplifiers[4].response > max_thruster

end

puts max_thruster
