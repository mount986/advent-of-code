class Guard
  attr_accessor :id
  attr_accessor :sleepy_minutes

  def initialize(id)
    @id = id
    @sleepy_minutes = Hash.new
    @sleepy_minutes[-1] = 0
  end

  def fall_asleep(moment)
    @time_asleep = moment
  end

  def wake_up(moment)
    current_time = @time_asleep
    until current_time == moment
      if current_time.hour == 0
        @sleepy_minutes[current_time.min] = 0 if @sleepy_minutes[current_time.min].nil?
        @sleepy_minutes[current_time.min] += 1
      end
      current_time = current_time + 1.minute
    end
  end

  def sleepiest_minute
    sleepiest = nil
    max_time_asleep = 0
    @sleepy_minutes.each do |minute, time_asleep|
      if time_asleep > max_time_asleep
        sleepiest = minute
        max_time_asleep = time_asleep
      end
    end

    sleepiest
  end

  def total_time_asleep
    sum = 0

    @sleepy_minutes.each do |minute, time_asleep|
      sum += time_asleep
    end

    sum
  end
end