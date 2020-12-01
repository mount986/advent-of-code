require './cart_track'

cart_track = CartTrack.new('input.txt')
until cart_track.carts.count == 1
  # cart_track.print_track_to_file
  cart_track.move_carts
end

last_cart = cart_track.carts.first
puts "Final Cart located at: #{last_cart.x},#{last_cart.y}"