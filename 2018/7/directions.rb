require './step'

class Directions
  attr_accessor :steps

  def initialize(input_file)
    @steps = Hash.new

    ('A'..'Z').each do |id|
      @steps[id] = Step.new(id)
    end

    File.open('input.txt', 'r').each_line do |line|
      matcher = /Step (?<prereq>\w) must be finished before step (?<step>\w) can begin./.match(line)

      steps[matcher[:step]].add_prerequisite(steps[matcher[:prereq]])
    end
  end

  def print_steps
    instructions = ''

    until all_steps_complete?
      step = next_step
      instructions += step.id
      step.complete
    end

    instructions
  end

  def next_step
    next_step = nil

    @steps.each do |id, step|
      next if step.complete?
      if step.ready?
        next_step = step
        break
      end
    end

    next_step
  end

  def all_steps_complete?
    @steps.each do |id, step|
      return false unless step.complete?
    end

    return true
  end
end