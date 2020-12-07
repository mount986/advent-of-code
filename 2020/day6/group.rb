class Group
  attr_reader :uniq_answers
  attr_reader :common_answers

  def initialize(group_answers)
    @uniq_answers = group_answers.gsub(/\s+/, '').chars.uniq
    @common_answers = Array.new

    answers = group_answers.split(/\s+/)
    ('a'..'z').each do |question|
      @common_answers.push question if (answers.select {|answer| answer.chars.include?(question)}.size == answers.size)
    end
  end
end