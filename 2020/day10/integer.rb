class Integer
  def factorial
    return 1 if self == 1

    return self * (self - 1).factorial
  end
end