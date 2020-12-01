require './cart'

class CartTrack
  attr_accessor :tracks
  attr_accessor :carts
  attr_accessor :move

  def initialize(input_file)
    @tracks = Hash.new
    @carts = Array.new
    @move = 0

    file = File.readlines(input_file)

    file.count.times do |count|
      @tracks[count] = Hash.new
    end

    y_index = 0
    file.each do |line|
      x_index = 0
      line.chars.each do |track|
        case track
        when '<', '>'
          @carts.push FactoryBot.build(:cart, direction: track, x: x_index, y: y_index)
          @tracks[x_index][y_index] = '-'
        when 'v', '^'
          @carts.push FactoryBot.build(:cart, direction: track, x: x_index, y: y_index)
          @tracks[x_index][y_index] = '|'
        when '-', '|', '+', '/', '\\'
          @tracks[x_index][y_index] = track
        end
        x_index += 1
      end
      y_index += 1
    end
  end

  def move_carts
    @carts.sort_by! {|cart| [cart.y, cart.x]}
    @carts.each do |cart|
      next if cart.crashed
      track = @tracks[cart.x][cart.y]

      case track
      when '/'
        case cart.direction
        when '^', 'v'
          cart.turn_right
        else
          cart.turn_left
        end
      when '\\'

        case cart.direction
        when '^', 'v'
          cart.turn_left
        else
          cart.turn_right
        end
      when '+'
        cart.turn
      end

      cart.move
      check_for_crash
    end

    @carts.delete_if {|cart| cart.crashed}
    @move += 1
  end

  def check_for_crash
    @carts.each do |cart_1|
      next if cart_1.crashed
      @carts.each do |cart_2|
        next if cart_1.id == cart_2.id
        next if cart_2.crashed

        if cart_1.x == cart_2.x and cart_1.y == cart_2.y
          puts "Move #{@move}: Crash occurred at (#{cart_1.x},#{cart_2.y})"
          cart_1.crashed = true
          cart_2.crashed = true
          break
        end
      end
    end
  end


  def print_track_to_file
    File.open("track_#{@move}.txt", 'w+') do |file|
      @tracks.count.times do |y|
        line = ''
        @tracks.count.times do |x|
          cart_found = false
          @carts.each do |cart|
            if cart.x == x and cart.y == y
              line << cart.direction
              cart_found = true
              break
            end
          end
          line << (@tracks[x][y].nil? ? ' ' : @tracks[x][y]) unless cart_found
        end
        file.puts line
      end
    end
  end

end