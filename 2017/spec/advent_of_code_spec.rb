require './lib/advent_of_code'

describe AdventOfCode do
  context '::find_doubles' do
    it 'will return a list of all numbers that match the next number in the list' do
      expect(AdventOfCode.find_doubles('1111')).to eq [1, 1, 1, 1]
      expect(AdventOfCode.find_doubles('1122')).to eq [1, 2]
      expect(AdventOfCode.find_doubles('12345')).to eq []
      expect(AdventOfCode.find_doubles('12341')).to eq [1]
    end

    it 'will return a list of all numbers that match a specified number of digits ahead, wrapping around' do
      expect(AdventOfCode.find_doubles('1212', 2)).to eq [1, 2, 1, 2]
      expect(AdventOfCode.find_doubles('1221', 2)).to eq []
      expect(AdventOfCode.find_doubles('123425', 3)).to eq [2, 2]
      expect(AdventOfCode.find_doubles('12131415', 4)).to eq [1, 1, 1, 1]
    end
  end

  context '::sum_array' do
    it 'will return a sum of the numbers in an array' do
      expect(AdventOfCode.sum_array([1, 1, 1, 1])).to eq 4
      expect(AdventOfCode.sum_array([1, 2, 1, 2])).to eq 6
      expect(AdventOfCode.sum_array([1, 2])).to eq 3
      expect(AdventOfCode.sum_array([2, 2])).to eq 4
      expect(AdventOfCode.sum_array([])).to eq 0
      expect(AdventOfCode.sum_array([1])).to eq 1
    end
  end

  context '::min_max_differencec' do
    it 'will return the difference between the min and max value in an array' do
      expect(AdventOfCode.min_max_difference([5, 1, 9, 5])).to eq 8
      expect(AdventOfCode.min_max_difference([7, 5, 3])).to eq 4
      expect(AdventOfCode.min_max_difference([2, 4, 6, 8])).to eq 6
      expect(AdventOfCode.min_max_difference([1, 1, 1, 1])).to eq 0
      expect(AdventOfCode.min_max_difference([])).to eq 0
    end
  end

  context '::divisible_quotients' do
    it 'will return the positive first whole number quotient found in a set of numbers' do
      expect(AdventOfCode.divisible_quotients([5, 9, 2, 8])).to eq 4
      expect(AdventOfCode.divisible_quotients([9, 4, 7, 3])).to eq 3
      expect(AdventOfCode.divisible_quotients([3, 8, 6, 5])).to eq 2
    end
  end

  context '::spiral_distance' do
    it 'will return the manhattan distance from a point on a grid to the origin' do
      expect(AdventOfCode.spiral_distance(1)).to eq 0
      expect(AdventOfCode.spiral_distance(12)).to eq 3
      expect(AdventOfCode.spiral_distance(23)).to eq 2
      expect(AdventOfCode.spiral_distance(1024)).to eq 31
    end
  end

  context 'spiral_sums' do
    it 'will return the sum of all surrounding nodes in a grid, numbered in a spiral' do
      expect(AdventOfCode.spiral_sums(1)).to eq 1
      expect(AdventOfCode.spiral_sums(6)).to eq 10
      expect(AdventOfCode.spiral_sums(13)).to eq 59
      expect(AdventOfCode.spiral_sums(20)).to eq 351
    end
  end

  context '::reallocate_memory!' do
    it 'will remove the largest value in the array and incrementally increase each index by one for that number of indexes' do
      array = [1,5,2,3,4,0,1,2]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([1,0,3,4,5,1,2,2])

      array = [1,2,0,1,1,1,0]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([1,0,1,2,1,1,0])
    end

    it 'will loop around to the beginning of the array while reistributing if the end of the array is reached' do
      array = [1,2,0]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([2,0,1])

      array = [1,5,2,3,4]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([2,1,3,4,5])
    end

    it 'will choose the smallest index if multiple indexes tie for the largest value' do
      array = [2,2,2,2]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([0,3,3,2])

      array = [1,5,2,3,4,5]
      AdventOfCode.reallocate_memory!(array)
      expect(array).to eq([2,0,3,4,5,6])
    end
  end

  context '::int_array_to_hex' do
    it 'will convert an array of integers to a string using the hex value of each element' do
      expect(AdventOfCode.int_array_to_hex([1,2,3,4,5])).to eq('0102030405')
      expect(AdventOfCode.int_array_to_hex([255,0,45,16,72])).to eq('ff002d1048')
    end
  end

  context '::hex_to_binary' do
    it 'will convert a string of hexidecimal numbers to a binary string' do
      expect(AdventOfCode.hex_to_binary('a')).to eq('1010')
      expect(AdventOfCode.hex_to_binary('0')).to eq('0000')
      expect(AdventOfCode.hex_to_binary('a0c2017')).to eq('1010000011000010000000010111')
    end
  end

  context '::reduce_directions!' do
    it 'will combine diagnol inputs into straight inputs, for all occurrences' do
      expect(AdventOfCode.reduce_directions!(['s', 'nw'])).to eq(['sw'])
      expect(AdventOfCode.reduce_directions!(['sw', 'n'])).to eq(['nw'])
      expect(AdventOfCode.reduce_directions!(['nw', 'ne'])).to eq(['n'])
      expect(AdventOfCode.reduce_directions!(['n', 'se'])).to eq(['ne'])
      expect(AdventOfCode.reduce_directions!(['ne', 's'])).to eq(['se'])
      expect(AdventOfCode.reduce_directions!(['sw', 'se'])).to eq(['s'])

      expect(AdventOfCode.reduce_directions!(['nw', 's', 's', 'nw'])).to eq(['sw', 'sw'])
      expect(AdventOfCode.reduce_directions!(['n', 'sw', 'sw', 'n'])).to eq(['nw', 'nw'])
      expect(AdventOfCode.reduce_directions!(['ne', 'nw', 'nw', 'ne'])).to eq(['n', 'n'])
      expect(AdventOfCode.reduce_directions!(['se', 'n', 'n', 'se'])).to eq(['ne', 'ne'])
      expect(AdventOfCode.reduce_directions!(['s', 'ne', 'ne', 's'])).to eq(['se', 'se'])
      expect(AdventOfCode.reduce_directions!(['se', 'sw', 'sw', 'se'])).to eq(['s', 's'])
    end

    it 'will remove opposite directions' do
      expect(AdventOfCode.reduce_directions!(['s', 'n'])).to eq([])
      expect(AdventOfCode.reduce_directions!(['sw', 'ne'])).to eq([])
      expect(AdventOfCode.reduce_directions!(['nw', 'se'])).to eq([])
      expect(AdventOfCode.reduce_directions!(['n', 's'])).to eq([])
      expect(AdventOfCode.reduce_directions!(['ne', 'sw'])).to eq([])
      expect(AdventOfCode.reduce_directions!(['sw', 'ne'])).to eq([])

      expect(AdventOfCode.reduce_directions!(['nw', 's', 'ne', 'n'])).to eq(['n'])
      expect(AdventOfCode.reduce_directions!(['n', 'sw', 'se', 's'])).to eq(['s'])
      expect(AdventOfCode.reduce_directions!(['ne', 'nw', 's', 's'])).to eq(['s'])
    end
  end

end