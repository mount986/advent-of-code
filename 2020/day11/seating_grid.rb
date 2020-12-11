require_relative 'seat'

class SeatingGrid
  attr_reader :seats

  def initialize(layout, tolerance: 4, skip_floor: false)
    @seats = Hash.new
    @tolerance = tolerance
    @skip_floor = skip_floor

    @length = layout.size
    @width = layout.first.length

    layout.each_with_index do |row, y|
      row.chars.each_with_index do |col, x|
        seats["#{x},#{y}"] = Seat.new(x, y) if col == 'L'
      end
    end
  end

  def count_occupied
    seats.values.count { |seat| seat.occupied? }
  end

  def cycle
    @seats.each do |cord, seat|
      occupied_considered_count = count_occupied_line_of_sight_seats(seat.x, seat.y)

      seat.prepare_to(:occupy) if seat.empty? and occupied_considered_count == 0
      seat.prepare_to(:empty) unless seat.empty? or occupied_considered_count < @tolerance
    end

    @seats.each do |cord, seat|
      seat.update
    end
  end

  def changes?
    @seats.each do |cord, seat|
      return true unless seat.unchanged?
    end

    false
  end

  def count_occupied_adjacent_seats(col, row)
    occupied_seats_count = 0

    (row - 1..row + 1).each do |y|
      (col - 1..col + 1).each do |x|
        next if (x == col and y == row)

        occupied_seats_count += 1 unless @seats["#{x},#{y}"].nil? or @seats["#{x},#{y}"].empty?
      end
    end

    occupied_seats_count
  end

  def count_occupied_line_of_sight_seats(col, row)
    occupied_seats_count = 0

    %w( N E S W NE NW SE SW).each do |direction|
      occupied_seats_count += 1 if send("#{direction}_occupied?", col, row)
    end

    occupied_seats_count
  end

  def N_occupied?(col, row)
    row.times do |index|
      if @seats["#{col},#{row - 1 - index}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col},#{row - 1 - index}"].occupied?
    end

    false
  end

  def E_occupied?(col, row)
    col.times do |index|
      if @seats["#{col - 1 - index},#{row}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col - 1 - index},#{row}"].occupied?
    end

    false
  end

  def S_occupied?(col, row)
    (@length - 1 - row).times do |index|
      if @seats["#{col},#{row + index + 1}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col},#{row + index + 1}"].occupied?
    end

    false
  end

  def W_occupied?(col, row)
    (@width - 1 - col).times do |index|
      if @seats["#{col + index + 1},#{row}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col + index + 1},#{row}"].occupied?
    end

    false
  end

  def NE_occupied?(col, row)
    [row, col].min.times do |index|
      if @seats["#{col - 1 - index},#{row - 1 - index}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col - 1 - index},#{row - 1 - index}"].occupied?
    end

    false
  end

  def SE_occupied?(col, row)
    [@length - 1 - row, col].min.times do |index|
      if @seats["#{col - 1 - index},#{row + 1 + index}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col - 1 - index},#{row + 1 + index}"].occupied?
    end

    false
  end

  def SW_occupied?(col, row)
    [@length - 1 - row, @width - 1 - col].min.times do |index|
      if @seats["#{col + 1 + index},#{row + 1 + index}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col + 1 + index},#{row + 1 + index}"].occupied?
    end

    false
  end

  def NW_occupied?(col, row)
    [row, @width - 1 - col].min.times do |index|
      if @seats["#{col + 1 + index},#{row - 1 - index}"].nil?
        if @skip_floor
          next
        else
          return false
        end
      end
      return @seats["#{col + 1 + index},#{row - 1 - index}"].occupied?
    end

    false
  end

  def print
    $stdout << "\n"
    $stdout << "\n"
    @length.times do |row|
      @width.times do |col|
        $stdout << (@seats["#{col},#{row}"].nil? ? '.' : @seats["#{col},#{row}"].to_s)
      end
      $stdout << "\n"
    end
  end
end