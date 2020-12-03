class Light
  def initialize
    @on = false
  end

  def turn_on
    @on = true
  end

  def turn_off
    @on = false
  end

  def toggle
    @on = !@on
  end

  def on?
    @on
  end
end

class Light2
  attr_reader :brightness
  def initialize
    @brightness = 0
  end

  def turn_on
    @brightness += 1
  end

  def turn_off
    @brightness -= 1
    @brightness = 0 if @brightness < 0
  end

  def toggle
    @brightness += 2
  end
end
