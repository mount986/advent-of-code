require_relative '../lib/repair_droid'

program = File.new('input.dat').read().split(',').map { |line| line.to_i }

robot = RepairDroid(program)

robot.run!
