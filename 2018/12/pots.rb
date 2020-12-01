class Pots < Hash

  def [] key
    value = super(key)

    (value.nil? ? '.' : value)
  end
end