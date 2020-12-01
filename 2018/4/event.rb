class Event
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  def self.parse_event(event)
    case event
    when /Guard #(\d+) begins shift/
      return GuardEvent.new(event, $1)
    when /falls asleep/
      return AsleepEvent.new(event)
    when /wakes up/
      return AwakeEvent.new(event)
    end
  end

  def to_s
    text
  end
end

class GuardEvent < Event
  attr_accessor :id

  def initialize(text, id)
    @text = text
    @id = id
  end
end

class AsleepEvent < Event

end

class AwakeEvent < Event

end