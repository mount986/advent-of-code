class Dance < Array
  def initialize
    super(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p'])
  end

  def do(move)
    case move.chr
      when 's'
        spin!(move[1, 2])
      when 'x'
        exchange!(move[1, 5])
      when 'p'
        partner!(move[1, 3])
    end
  end

  def spin!(step)
    tail = self.pop(step.to_i)
    unshift(*tail)
  end

  def exchange!(step)
    index_1, index_2 = step.split('/').map {|val| val.to_i}

    temp = self[index_1]
    self[index_1] = self[index_2]
    self[index_2] = temp
  end

  def partner!(step)
    values = step.split('/')

    index_1 = self.index(values.first).to_i
    index_2 = self.index(values.last).to_i

    temp = self[index_1]
    self[index_1] = self[index_2]
    self[index_2] = temp
  end

end

