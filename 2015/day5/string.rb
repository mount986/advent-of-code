class String
  def contains_vowels?(min_required)
    return self.count('aeiou') >= min_required
  end

  def has_consecutive_letters?(min_required)
    prev = nil
    each_char do |char|
      return true if char == prev
      prev = char
    end

    false
  end

  def has_double_repeat?
    temp = self.chars

    while temp.size > 3
      chars = "#{temp.shift}#{temp[0]}"
      return true if temp.join('')[1, temp.length - 1].include?(chars)
    end

    false
  end

  def has_excluded_patterns?(patterns)
    patterns.each do |pattern|
      return true if include?(pattern)
    end

    false
  end

  def has_sandwhich?
    (size - 2).times do |index|
      return true if chars[index] == chars[index + 2]
    end

    false
  end

  def old_nice?(vowels: 3, consecutive: 2, patterns: ['ab', 'cd', 'pq', 'xy'])
    contains_vowels?(vowels) and has_consecutive_letters?(consecutive) and not has_excluded_patterns?(patterns)
  end

  def new_nice?(vowels: 3, consecutive: 2, patterns: ['ab', 'cd', 'pq', 'xy'])
    has_double_repeat? and has_sandwhich?
  end
end