require './marble'

class Game
  attr_accessor :players
  attr_accessor :final_point_value
  attr_accessor :current_marble

  SCORING_INC = 23
  LEFT_ROTATION = 7

  def initialize(input_file)
    match_data = /(?<num_players>\d+) players; last marble is worth (?<final_point_value>\d+) points/.match(File.read(input_file))
    @players = Array.new(match_data[:num_players].to_i) {0}
    @final_point_value = match_data[:final_point_value].to_i

    @current_marble = Marble.new(0)
    @current_marble.right = @current_marble
    @current_marble.left = @current_marble

  end

  def play_game
    current_value = 0
    current_player = 0
    previous_points = 0

    while true
      current_value += 1
      new_marble = Marble.new(current_value)

      if current_value % SCORING_INC == 0
        points = 0
        points += current_value
        LEFT_ROTATION.times do
          @current_marble = @current_marble.left
        end
        points += @current_marble.value
        @current_marble.remove
        @current_marble = @current_marble.right

        @players[current_player] += points
      else
        current_marble.right.add_to_right(new_marble)
        @current_marble = new_marble
      end

      if current_value == @final_point_value
        break
      end

      current_player = (current_player + 1) % @players.length
    end
  end

  def winner
    players.max
  end
end