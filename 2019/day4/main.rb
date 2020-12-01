min = 357253
max = 892942

def valid_pw?(number)
  num = number.to_s
  increasing?(num) and has_double?(num)
end

def valid_pw_ext?(number)
  num = number.to_s
  increasing?(num) and has_double_only?(num)
end

def has_double?(num)
  prev_char = nil
  num.each_char do |char|
    return true if char == prev_char
    prev_char = char
  end

  false
end

def has_double_only?(num)
  prev_char = nil
  streaks  = Array.new(6, 0)
  streak = 0

  num.each_char do |char|
    if char == prev_char
      streak += 1
    else
      streaks[streak] += 1
      streak = 0
    end
    prev_char = char
  end

  streaks[streak] += 1

  streaks[1] > 0
end

def increasing?(num)
  prev_digit = 0
  num.each_char do |char|
    digit = char.to_i
    return false if digit < prev_digit
    prev_digit = digit
  end

  true
end

first_count = 0
second_count = 0

(min..max).each do |number|
  first_count += 1 if valid_pw?(number)
  second_count += 1 if valid_pw_ext?(number)
end

puts first_count
puts second_count