class Fabric
  attr_accessor :claims
  attr_accessor :claimed_squares

  def initialize
    @claims = Array.new
    @claimed_squares = Hash.new
  end

  def parse_input(file_name)
    File.open(file_name, 'r').each do |line|
      claim = Claim.new(line.strip)
      claim_area(claim)
      @claims.push claim
    end
  end

  def claim_area(claim)
    claim.width.times do |left_index|
      claim.height.times do |top_index|
        hash_index = :"#{claim.left + left_index}, #{claim.top + top_index}"
        if @claimed_squares[hash_index].nil?
          @claimed_squares[hash_index] = 1
        else
          @claimed_squares[hash_index] = @claimed_squares[hash_index] + 1
        end
      end
    end
  end

  def find_dupes
    @claimed_squares.select {|key, value| value > 1}
  end

  def find_uniq
    claims.each do |claim|
      unique = true
      claim.width.times do |left_index|
        claim.height.times do |top_index|
          hash_index = :"#{claim.left + left_index}, #{claim.top + top_index}"
          if @claimed_squares[hash_index] > 1
            unique = false
          end
        end
      end

      return claim.id if unique
    end
  end

  class Claim
    attr_accessor :id, :left, :top, :width, :height

    def initialize(input)
      match_object = /#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/.match(input)

      @id = match_object[:id].to_i
      @left = match_object[:left].to_i
      @top = match_object[:top].to_i
      @width = match_object[:width].to_i
      @height = match_object[:height].to_i
    end
  end

end