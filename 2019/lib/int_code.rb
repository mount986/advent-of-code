class IntCode
  attr_reader :name
  attr_reader :program
  attr_reader :output
  attr_reader :running
  attr_accessor :state

  def initialize(name: 'IntCode', program: [99], input: [], debug: false)
    @name = name
    @program = Hash.new
    @input = input
    @output = Array.new
    @position = 0
    @state = :running
    @relative_base = 0
    @debug = debug

    program.each_with_index { |value, index| @program[index] = value }

    puts "#{@name} started with program: #{program.join(',')}" if @debug

  end

  def alter_program(list)

    puts "#{@name} - program altered:" if @debug

    list.each do |position, value|
      @program[position.to_s.to_i] = value
      puts "  position #{position} changed to #{value}" if @debug
    end

    puts "New program: #{@program.join(',')}" if @debug
  end

  def run_program
    while @state == :running
      compute
    end
  end

  def compute
    if @debug
      puts " "
    end
    instruction = "%05d" % @program[@position].to_s

    command = instruction[-2, 2].to_i
    mode1 = instruction[-3].to_i
    mode2 = instruction[-4].to_i
    mode3 = instruction[-5].to_i

    if @debug
      puts "#{@name} received instruction #{instruction}"
      puts "position: #{@position}"
      puts "command:  #{command}"
    end

    case command
    when 1
      _add(mode1, mode2, mode3)
    when 2
      _multiply(mode1, mode2, mode3)
    when 3
      _input(mode1)
    when 4
      _output(mode1)
    when 5
      _jump_if_true(mode1, mode2)
    when 6
      _jump_if_false(mode1, mode2)
    when 7
      _less_than(mode1, mode2, mode3)
    when 8
      _equal(mode1, mode2, mode3)
    when 9
      _increase_relative_base(mode1)
    when 99
      _terminate
    else
      raise "Unknown command #{command}"
    end
  end

  def send(input)
    @input.push input

    if @state == :waiting_input
      @state = :running
    end
  end

    def receive
    @output.shift
  end

  def response
    @output.last
  end

  def has_output?
    !@output.empty?
  end

  private

  def _get_parameter(position, mode)
    value = case mode
            when 0
              @program.fetch(@program.fetch(position, 0), 0)
            when 1
              @program.fetch(position, 0)
            when 2
              @program.fetch(@program.fetch(position, 0) + @relative_base, 0)
            else
              raise "Unknown mode #{mode}"
            end

    value
  end

  def _get_target_address(position, mode)
    address = case mode
              when 0
                @program.fetch(position, 0)
              when 2
                @program.fetch(position, 0) + @relative_base
              else
                raise "Targeting address run with improper mode #{mode}"
              end

    address
  end

  def _set_memory(position, mode, value)
    case mode
    when 0
      @program[@program.fetch(position, 0)] = value
    when 2
      @program[@program.fetch(position, 0) + @relative_base] = value
    end
  end

  def _add(mode1, mode2, mode3)
    if @debug
      puts "Running #add function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}, #{@program.fetch(@position + 3, 0)}"
      puts "modes: #{mode1}, #{mode2}, #{mode3}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}, #{_get_target_address(@position + 3, mode3)}"
      puts "Adding #{_get_parameter(@position + 1, mode1)} and #{_get_parameter(@position + 2, mode2)}, storing at position #{_get_target_address(@position + 3, mode3)}"
    end

    _set_memory(@position + 3, mode3, _get_parameter(@position + 1, mode1) + _get_parameter(@position + 2, mode2))

    @position += 4
  end

  def _multiply(mode1, mode2, mode3)
    if @debug
      puts "Running #multiply function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}, #{@program.fetch(@position + 3, 0)}"
      puts "modes: #{mode1}, #{mode2}, #{mode3}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}, #{_get_target_address(@position + 3, mode3)}"
      puts "Multiplying #{_get_parameter(@position + 1, mode1)} and #{_get_parameter(@position + 2, mode2)}, storing at position #{_get_target_address(@position + 3, mode3)}"
    end

    _set_memory(@position + 3, mode3, _get_parameter(@position + 1, mode1) * _get_parameter(@position + 2, mode2))

    @position += 4
  end

  def _less_than(mode1, mode2, mode3)
    if @debug
      puts "Running #less_than function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}, #{@program.fetch(@position + 3, 0)}"
      puts "modes: #{mode1}, #{mode2}, #{mode3}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}, #{_get_target_address(@position + 3, mode3)}"
      puts "Comparing #{_get_parameter(@position + 1, mode1)} and #{_get_parameter(@position + 2, mode2)}, storing at position #{_get_target_address(@position + 3, mode3)}"
    end

    _set_memory(@position + 3, mode3, (_get_parameter(@position + 1, mode1) < _get_parameter(@position + 2, mode2) ? 1 : 0))

    @position += 4
  end

  def _equal(mode1, mode2, mode3)
    if @debug
      puts "Running #equal function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}, #{@program.fetch(@position + 3, 0)}"
      puts "modes: #{mode1}, #{mode2}, #{mode3}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}, #{_get_target_address(@position + 3, mode3)}"
      puts "Comparing #{_get_parameter(@position + 1, mode1)} and #{_get_parameter(@position + 2, mode2)}, storing at position #{_get_target_address(@position + 3, mode3)}"
    end

    _set_memory(@position + 3, mode3, (_get_parameter(@position + 1, mode1) == _get_parameter(@position + 2, mode2) ? 1 : 0))

    @position += 4
  end

  def _input(mode1)
    if @debug
      puts "Running #input function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}"
      puts "modes: #{mode1}"
      puts "values: #{_get_target_address(@position + 1, mode1)}"

      puts "Input array: #{@input.join(',')}"
    end
    if @input.empty?
      puts "#{@name} state set to :awaiting_input" if @debug
      @state = :waiting_input
      return
    end

    puts "placing input value #{@input.first} , storing at position #{_get_target_address(@position + 1, mode1)}" if @debug

    _set_memory(@position + 1, mode1, @input.shift)

    @position += 2
  end

  def _output(mode1)
    if @debug
      puts "Running #output function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}"
      puts "modes: #{mode1}"
      puts "values: #{_get_parameter(@position + 1, mode1)}"
      puts "placing value #{_get_parameter(@position + 1, mode1)} into output array"
    end

    @output.push _get_parameter(@position + 1, mode1)

    @position += 2
  end

  def _jump_if_true(mode1, mode2)
    if @debug
      puts "Running #jump_if_true function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}"
      puts "modes: #{mode1}, #{mode2}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}"
      puts "Testing if #{_get_parameter(@position + 1, mode1)} is true, if so jumping to #{_get_parameter(@position + 2, mode2)}"
    end

    if _get_parameter(@position + 1, mode1) != 0
      @position = _get_parameter(@position + 2, mode2)
    else
      @position += 3
    end
  end

  def _jump_if_false(mode1, mode2)
    if @debug
      puts "Running #jump_if_false function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}, #{@program.fetch(@position + 2, 0)}"
      puts "modes: #{mode1}, #{mode2}"
      puts "values: #{_get_parameter(@position + 1, mode1)}, #{_get_parameter(@position + 2, mode2)}"
      puts "Testing if #{_get_parameter(@position + 1, mode1)} is false, if so jumping to #{_get_parameter(@position + 2, mode2)}"
    end

    if _get_parameter(@position + 1, mode1) == 0
      @position = _get_parameter(@position + 2, mode2)
    else
      @position += 3
    end
  end

  def _increase_relative_base(mode1)
    if @debug
      puts "Running #increase_relative_base function"
      puts "parameters: #{@program.fetch(@position + 1, 0)}"
      puts "modes: #{mode1}"
      puts "values: #{_get_parameter(@position + 1, mode1)}"
    end

    @relative_base += _get_parameter(@position + 1, mode1)

    puts "increasing relative base by #{_get_parameter(@position + 1, mode1)} to #{@relative_base}" if @debug

    @position += 2
  end

  def _terminate
    if @debug
      puts "Running #terminate function"
      puts "#{@name} is finished running"
    end

    @state = :finished

    @position += 1
  end

end