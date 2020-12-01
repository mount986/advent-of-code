class Polymer
  attr_accessor :units

  def initialize(input_file)
    @original_units = File.read(input_file).strip.chars
    reset
  end

  def reset
    @units = @original_units.clone
  end

  def react?
    reaction_occurred = false

    index = 0
    while index < (@units.length - 1)
      if (@units[index].ord == @units[index + 1].ord + 32) or (@units[index].ord == @units[index + 1].ord - 32)
        2.times {@units.delete_at(index)}
        reaction_occurred = true
        index -= 1 unless index == 0
      else
        index += 1
      end
    end

    reaction_occurred
  end

  def remove(letter)
    @units.delete(letter)
    @units.delete(letter.upcase)
  end
end