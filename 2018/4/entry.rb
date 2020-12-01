require './event'

class Entry
  attr_accessor :time, :event

  def initialize(input)
    match_data = /\[(?<year>\d{4})\-(?<month>\d{2})\-(?<day>\d{2}) (?<hour>\d{2}):(?<minute>\d{2})\] (?<event>.*)/.match(input)

    @time = Time.new(match_data[:year], match_data[:month], match_data[:day], match_data[:hour], match_data[:minute])
    @event = Event.parse_event(match_data[:event])
  end

  def to_s
    sprintf("[%04d-%02d-%02d %02d:%02d] %s", time.year, time.month, time.day, time.hour, time.min, event)
  end
end