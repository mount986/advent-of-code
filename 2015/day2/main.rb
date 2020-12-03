require_relative 'gift'
gifts = File.readlines('input.dat')

paper = 0
ribbon = 0

gifts.each do |gift_dimensions|
  gift = Gift.new(gift_dimensions)

  paper += gift.paper_needed
  ribbon += gift.ribbon_needed
end

puts paper
puts ribbon
