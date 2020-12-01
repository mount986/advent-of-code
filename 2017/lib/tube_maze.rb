class TubeMaze
  attr_reader :letters, :count

  def initialize(input)
    @maze = Array.new
    200.times do |row|
      @maze.push Array.new
      input[row].chomp.chars.each do |char|
        @maze[row].push char
      end
    end

    @letters = Array.new
    @history = Array.new

    @current_row = 0
    @current_column = 1
    @current_direction = :south
  end

  def move_forward?(direction = @current_direction)
    new_row = @current_row
    new_column = @current_column
    case direction
      when :north
        new_row -= 1
      when :south
        new_row += 1
      when :east
        new_column += 1
      when :west
        new_column -= 1
    end

    if new_row < 0 or
        new_row >= @maze.length or
        @maze[new_row].nil? or
        new_column < 0 or
        new_column >= @maze[new_row].length or
        @maze[new_row][new_column].nil? or
        @maze[new_row][new_column] == ' ' or
        @maze[new_row][new_column] == ''
      return false
    end

    if at_crossroads?
      case direction
        when :north, :south
          return false if @maze[new_row][new_column] == '-'
        when :east, :west
          return false if @maze[new_row][new_column] == '+'
      end
    end

    @current_row = new_row
    @current_column = new_column
    @current_direction = direction

    @history.push "(#{new_row},#{new_column}) #{direction}"
    true
  end

  def turn_left?
    case @current_direction
      when :north
        return move_forward? :west
      when :south
        return move_forward? :east
      when :east
        return move_forward? :north
      when :west
        return move_forward? :south
    end
  end

  def turn_right?
    case @current_direction
      when :north
        return move_forward? :east
      when :south
        return move_forward? :west
      when :east
        return move_forward? :south
      when :west
        return move_forward? :north
    end
  end

  def at_crossroads?
    @maze[@current_row][@current_column] == '+'
  end

  def traverse_maze
    @count = 1
    while @history.uniq.length == @history.length do
      if move_forward? or turn_left? or turn_right?
        @letters.push @maze[@current_row][@current_column] if @maze[@current_row][@current_column] =~ /[A-Z]/
      else
        break
      end
      @count += 1
    end
  end
end