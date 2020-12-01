class StreamParser

  class << self
    attr_reader :score, :garbage_score
  end

  @score = 0
  @garbage_score = 0
  @current_level = 0

  def self.parse_stream(input)


    while input.length > 0
      next_char = input.shift
      case next_char
        when '{'
          @current_level += 1
          @score += @current_level
        when '<'
          parse_garbage(input)
        when '}'
          @current_level -= 1
      end
    end
  end

  def self.parse_garbage(input)
    while input.length > 0
      next_char = input.shift
      case next_char
        when '!'
          input.shift
        when '>'
          return
        else
          @garbage_score += 1
      end
    end
  end
end
