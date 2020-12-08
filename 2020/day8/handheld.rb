class Handheld
  attr_reader :instructions, :curremt_step, :accumulator

  def initialize(instructions)
    @instructions = instructions
    @curremt_step = 0
    @accumulator = 0

    @history = Array.new
  end

  def run
    until @curremt_step >= @instructions.size
      take_step
    end
  end

  def debug
    until @curremt_step >= @instructions.size
      step = instructions[@curremt_step]
      instruction, value = step.split(' ')
      if instruction == 'acc'
        take_step
        next
      end

      stored_history = @history.dup
      stored_step = @curremt_step.dup
      stored_accumulator = @accumulator.dup

      begin
        take_alternate_step
        run
      rescue IndexError
        @history = stored_history
        @curremt_step = stored_step
        @accumulator = stored_accumulator

        take_step
      end
    end
  end

  def acc(value)
    @accumulator += value
    @curremt_step += 1
  end

  def jmp(value)
    @curremt_step += value
  end

  def nop(value)
    @curremt_step += 1
  end

  private

  def take_step
    raise(IndexError, "Infinite Loop Identified") if @history.include?(@curremt_step)
    @history.push @curremt_step

    step = instructions[@curremt_step]
    instruction, value = step.split(' ')
    send(:"#{instruction}", value.to_i)
  end

  def take_alternate_step
    raise(IndexError, "Infinite Loop Identified") if @history.include?(@curremt_step)
    @history.push @curremt_step

    step = instructions[@curremt_step]
    instruction, value = step.split(' ')
    case instruction
    when 'acc'
      acc(value.to_i)
    when 'nop'
      jmp(value.to_i)
    when 'jmp'
      nop(value.to_i)
    end
  end
end

