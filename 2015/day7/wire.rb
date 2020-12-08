class Wire
  class << self
    attr_accessor :wires
  end

  @wires = Hash.new

  def self.get_wire(name)
    name.strip!
    wire = @wires[name]
    if wire.nil?
      wire = Wire.new(name)
      @wires[name] = wire
    end

    wire
  end

  def self.parse_rule(rule)
    sources, name = rule.split(' -> ')
    parsed_source = sources.split(' ')

    wire = get_wire(name)

    case parsed_source.count
    when 1
      wire.inputs.push parsed_source[0]
    when 2
      wire.operator = parsed_source[0]
      wire.inputs.push parsed_source[1]
    when 3
      wire.inputs.push parsed_source[0]
      wire.operator = parsed_source[1].to_sym
      wire.inputs.push parsed_source[2]
    end
  end

  def self.reset_all
    @wires.values.each { |wire| wire.reset_value }
  end

  attr_accessor :name, :operator, :inputs, :value

  def initialize(name)
    @name = name
    @inputs = Array.new
    @operator = :none
  end

  def operator=(operator)
    @operator = operator.downcase.to_sym
  end

  def and
    self.class.value_of(@inputs.first) & self.class.value_of(@inputs.last)
  end

  def or
    self.class.value_of(@inputs.first) | self.class.value_of(@inputs.last)
  end

  def not
    ~self.class.value_of(@inputs.first)
  end

  def lshift
    self.class.value_of(@inputs.first) << self.class.value_of(@inputs.last)
  end

  def rshift
    self.class.value_of(@inputs.first) >> self.class.value_of(@inputs.last)
  end

  def none
    self.class.value_of(@inputs.first)
  end

  def value
    @value ||= send(@operator)
  end

  def reset_value
    @value = nil
  end

  def self.value_of(input)
    if input.match? /\A\d+\z/
      return input.to_i
    end

    get_wire(input).value
  end
end