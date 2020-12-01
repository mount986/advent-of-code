require './lib/knot_hash'

describe KnotHash do
  context '#twist!' do
    it 'will reverse the elements of memory starting at the current position going to the length passed in' do
      ribbon = KnotHash.new
      ribbon.memory = [0, 1, 2, 3, 4, 5]

      ribbon.current_position = 1
      ribbon.twist!(2)
      expect(ribbon.memory).to eq([0, 2, 1, 3, 4, 5])

      ribbon.current_position = 3
      ribbon.twist!(3)
      expect(ribbon.memory).to eq([0, 2, 1, 5, 4, 3])

      ribbon.current_position = 0
      ribbon.twist!(0)
      expect(ribbon.memory).to eq([0, 2, 1, 5, 4, 3])
    end

    it 'will wrap around to the beginning when the length goes past the end of memory' do
      ribbon = KnotHash.new
      ribbon.memory = [0, 1, 2, 3, 4, 5]

      ribbon.current_position = 3
      ribbon.twist!(4)
      expect(ribbon.memory).to eq([3, 1, 2, 0, 5, 4])

      ribbon.current_position = 3
      ribbon.twist!(6)
      expect(ribbon.memory).to eq([4, 5, 0, 2, 1, 3])
    end

    it 'will increase the skip size by 1' do
      ribbon = KnotHash.new
      ribbon.memory = [0, 1, 2, 3, 4, 5]

      ribbon.skip = 0
      ribbon.twist!(2)
      expect(ribbon.skip).to eq 1

      ribbon.skip = 20
      ribbon.twist!(5)
      expect(ribbon.skip).to eq 21
    end

    it 'will increase current_position by the length passed in plus the skip' do
      ribbon = KnotHash.new
      ribbon.memory = [0, 1, 2, 3, 4, 5]

      ribbon.skip = 0
      ribbon.current_position = 0
      ribbon.twist!(2)
      expect(ribbon.current_position).to eq 2

      ribbon.skip = 20
      ribbon.current_position = 5
      ribbon.twist!(5)
      expect(ribbon.current_position).to eq 30
    end
  end

  context

  context '#dense_hash' do
    it 'will return th dense hash from the current memory, performing XOR on every 16 numbers' do
      ribbon = KnotHash.new
      ribbon.memory.shuffle!

      expect(ribbon.dense_hash.length).to eq(16)
    end
  end
end