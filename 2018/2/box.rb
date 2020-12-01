class Box
  attr_accessor :id
  attr_accessor :sorted_id
  attr_accessor :letters_with_2, :letters_with_3

  def initialize(id)
    @id = id.strip
    @sorted_id = @id.chars.sort

    @letters_with_2 = Array.new
    @letters_with_3 = Array.new

    find_dups
  end

  def find_dups
    count = 1
    previous_letter = nil
    @sorted_id.each do |letter|
      if letter == previous_letter
        count += 1
      else
        if count == 2
          @letters_with_2.push previous_letter
        elsif count == 3
          @letters_with_3.push previous_letter
        end
        count = 1
      end

      previous_letter = letter
    end

    if count == 2
      @letters_with_2.push previous_letter
    elsif count == 3
      @letters_with_3.push previous_letter
    end

  end

  def has_2_alike?
    @letters_with_2.count > 0
  end

  def has_3_alike?
    @letters_with_3.count > 0
  end
end