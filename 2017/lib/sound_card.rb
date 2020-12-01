require './lib/register'

class SoundCard
  attr_reader :register
  attr_reader :frequency
  attr_reader :song_over

  def initialize(instructions)
    @current_position = 0
    @instructions = instructions
    @register = Register.new
    @song_over = false
  end

  def snd(value)
    result = (value =~ /\d/ ? value : @register[value])
    @frequency = result
  end

  def set(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] = result.to_i
  end

  def add(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] += result.to_i
  end

  def mul(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] *= result.to_i
  end

  def mod(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] = @register[reg] % result.to_i
  end

  def rcv(reg)
    @song_over = true unless @register[reg] == 0
  end

  def jgz(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @current_position += (result.to_i - 1) if @register[reg] > 0
  end

  def next_instruction
    instruction = @instructions[@current_position]
    @current_position += 1

    command, *values = instruction.strip.split(' ')
    send(command.to_sym, *values)
  end
end