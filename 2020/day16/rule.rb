class Rule
  attr_reader :name, :ranges

  def initialize(rule)
    @name, ranges = rule.split(': ')
    @ranges = ranges.split(" or ")
  end

  def match?(field)
    @ranges.each do |range|
      min_range, max_range = range.split('-').map { |value| value.to_i }
      return true if field >= min_range and field <= max_range
    end

    false
  end

  def match_all?(field_values)
    field_values.all? { |field| match?(field) }
  end
end