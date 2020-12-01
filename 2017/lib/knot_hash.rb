class KnotHash
  attr_accessor :memory
  attr_accessor :skip
  attr_accessor :current_position

  def initialize
    @memory = (0..255).to_a
    @skip = 0
    @current_position = 0
  end

  def twist!(length)
    sub_array = Array.new

    length.times do |index|
      sub_array.push memory[(@current_position + index) % memory.length]
    end

    sub_array.reverse!

    length.times do |index|
      memory[(@current_position + index) % memory.length] = sub_array[index]
    end

    @current_position += length + @skip
    @skip += 1
  end

  def sparse_hash!(input)
    knot_lengths = input.strip.chars.map {|val| val.ord} + [17, 31, 73, 47, 23]

    64.times do
      knot_lengths.each do |length|
        twist!(length)
      end
    end
  end

  def dense_hash
    temp_memory = @memory.clone
    pieces = Array.new

    until temp_memory.empty?
      piece = temp_memory.shift(16)
      sub_piece = piece.shift

      piece.each do |value|
        sub_piece = sub_piece ^ value
      end

      pieces.push sub_piece
    end

    pieces
  end
end