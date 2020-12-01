require './lib/register'

class Duet

  class << self
    attr_accessor :duets
    attr_accessor :next_id
  end

  @duets = Hash.new
  @next_id = 0

  attr_reader :register
  attr_reader :frequency
  attr_reader :waiting
  attr_reader :count
  attr_accessor :message_queue

  def initialize(instructions)
    @current_position = 0
    @instructions = instructions
    @register = Register.new
    @message_queue = Array.new
    @waiting = false
    @count = 0
    @id = Duet.next_id
    @other_id = (@id == 0 ? 1 : 0)

    @register['p'] = @id

    Duet.duets[@id] = self
    Duet.next_id += 1
  end

  def snd(value)
    result = (value =~ /\d/ ? value : @register[value])

    Duet.duets[@other_id].message_queue.push(result)
    @count += 1
    @current_position += 1
  end

  def set(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] = result.to_i
    @current_position += 1
  end

  def add(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] += result.to_i
    @current_position += 1
  end

  def mul(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] *= result.to_i
    @current_position += 1
  end

  def mod(reg, value)
    result = (value =~ /\d/ ? value : @register[value])
    @register[reg] = @register[reg] % result.to_i
    @current_position += 1
  end

  def rcv(reg)
    if @message_queue.empty?
      @waiting = true
    else
      @waiting = false
      @current_position += 1
      register[reg] = @message_queue.shift
    end
  end

  def jgz(reg, value)
    register = (reg =~ /\d/ ? reg : @register[reg]).to_i
    result = (value =~ /\d/ ? value : @register[value]).to_i
    @current_position += (register > 0 ? result : 1)
  end

  def next_instruction
    instruction = @instructions[@current_position]

    command, *values = instruction.strip.split(' ')
    send(command.to_sym, *values)
  end

  def deadlock?
    (@waiting and @message_queue.empty?) or
        @current_position >= @instructions.length or
        @current_position < 0
  end
end