class Gadget
  attr_accessor :frequency

  def initialize(frequency: 0)
    @frequency = frequency
    @possible_frequencies = (-100000..100000).to_a
  end

  def change_frequency(change)
      @frequency += change.strip.to_i
  end

  def repeated_frequency?
    @possible_frequencies.delete(@frequency).nil?
  end
end