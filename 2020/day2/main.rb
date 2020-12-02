input = File.readlines('input.dat')

def valid_password_sled?(password_rule)
  match, min_range, max_range, letter, password = password_rule.match(/(\d+)-(\d+) ([a-z]): ([a-z]+)/).to_a
  count = password.count(letter)
  return (count >= min_range.to_i and count <= max_range.to_i)
end

def valid_password_tobogan?(password_rule)
  match, first_position, second_position, letter, password = password_rule.match(/(\d+)-(\d+) ([a-z]): ([a-z]+)/).to_a
  if password[first_position.to_i - 1] == letter
    if password[second_position.to_i - 1] == letter
      return false
    else
      return true
    end
  else
    if password[second_position.to_i - 1] == letter
      return true
    else
      return false
    end
  end
end

valid_count_sled = 0
valid_count_tobogan = 0

input.each do |password|
  valid_count_sled += 1 if valid_password_sled?(password)
  valid_count_tobogan += 1 if valid_password_tobogan?(password)
end

puts valid_count_sled
puts valid_count_tobogan