require 'digest'

# input = 'abcdef'
input = 'iwrupvqb'

count = 0
while true
  hash = Digest::MD5.hexdigest("#{input}#{count}")
  break if hash.start_with? '00000'
  count += 1
end

puts count

count = 0
while true
  hash = Digest::MD5.hexdigest("#{input}#{count}")
  break if hash.start_with? '000000'
  count += 1
end

puts count
