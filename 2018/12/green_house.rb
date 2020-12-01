require './pots'

class GreenHouse
  attr_accessor :pots
  attr_accessor :rules
  attr_accessor :generation

  def initialize(input_file)
    @generation = 0
    file = File.readlines(input_file)

    @pots = Pots.new
    counter = 0
    initial_match = /initial state: (?<gen_0>[\.\#]+)/.match(file[0])
    initial_match[:gen_0].chars.each do |plant|
      @pots[counter] = plant
      counter += 1
    end

    @rules = Hash.new
    (2..(file.length - 1)).each do |index|
      rule_match = /(?<rule>[\.\#]{5}) => (?<result>[\.\#])/.match(file[index])
      @rules[rule_match[:rule]] = rule_match[:result]
    end
  end

  def print_pots()
    plants_stream = ''
    index_stream = ''
    (@pots.keys.min..@pots.keys.max).each do |index|
        plants_stream << @pots[index]

    end

    puts "#{@generation}: #{plants_stream}"
    @generation += 1
  end

  def run_generation
    new_pots = Pots.new

    (@pots.keys + [@pots.keys.min - 1] + [@pots.keys.max + 1]).each do |pot_id|
      rule = ''
      ((pot_id - 2)..(pot_id + 2)).each do |index|
        rule << @pots[index]
      end

      new_pots[pot_id] = @rules[rule]
    end

    while new_pots[new_pots.keys.min] == '.'
      new_pots.delete(new_pots.keys.min)
    end

    while new_pots[new_pots.keys.max] == '.'
      new_pots.delete(new_pots.keys.max)
    end

    @pots = new_pots
  end

  def sum_plants
    @pots.select {|key, value| value == '#'}.keys.sum
  end

  def run_speed(num_gens)
    new_pots = Pots.new

    @pots.keys.each do |pot_id|
      new_pots[pot_id + num_gens] = @pots[pot_id]
    end

    @pots = new_pots
  end

end