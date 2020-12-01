require './lib/advent_of_code'

a_value = 65
b_value = 8921

File.open('./bin/day_15/dueling_generators.dat') do |file|
  a_value = file.readline.strip.split(' ').last.to_i
  b_value = file.readline.strip.split(' ').last.to_i
end

judge = 0

40000000.times do
  a_value = a_value * 16807 % 2147483647
  b_value = b_value * 48271 % 2147483647

  a_bin = a_value.to_s(2)
  if a_bin.length < 16
    a_last_16 = ('0' * (16 - a_bin.length)) + a_bin
  else
    a_last_16 = a_bin[(a_bin.length - 16)..(a_bin.length - 1)]
  end

  b_bin = b_value.to_s(2)
  if b_bin.length < 16
    b_last_16 = ('0' * (16 - b_bin.length)) + b_bin
  else
    b_last_16 = b_bin[(b_bin.length - 16)..(b_bin.length - 1)]
  end

  judge += 1 if a_last_16 == b_last_16
end

puts judge

File.open('./bin/day_15/dueling_generators.dat') do |file|
  a_value = file.readline.strip.split(' ').last.to_i
  b_value = file.readline.strip.split(' ').last.to_i
end

judge = 0

5000000.times do
  loop do
    a_value = a_value * 16807 % 2147483647
    break if a_value % 4 == 0
  end

  loop do
    b_value = b_value * 48271 % 2147483647
    break if b_value % 8 == 0
  end

  a_bin = a_value.to_s(2)
  if a_bin.length < 16
    a_last_16 = ('0' * (16 - a_bin.length)) + a_bin
  else
    a_last_16 = a_bin[(a_bin.length - 16)..(a_bin.length - 1)]
  end

  b_bin = b_value.to_s(2)
  if b_bin.length < 16
    b_last_16 = ('0' * (16 - b_bin.length)) + b_bin
  else
    b_last_16 = b_bin[(b_bin.length - 16)..(b_bin.length - 1)]
  end

  judge += 1 if a_last_16 == b_last_16
end

puts judge