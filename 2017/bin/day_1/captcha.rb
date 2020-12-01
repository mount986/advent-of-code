require './lib/advent_of_code'

test_string = File.read('captcha.dat').strip

puzzle_1_advance = 1
puzzle_1_double_numbers = AdventOfCode.find_doubles(test_string, puzzle_1_advance)
puts AdventOfCode.sum_array(puzzle_1_double_numbers)

puzzle_2_advance = test_string.length / 2
puzzle_2_double_numbers = AdventOfCode.find_doubles(test_string, puzzle_2_advance)
puts AdventOfCode.sum_array(puzzle_2_double_numbers)
