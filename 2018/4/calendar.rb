require './entry'
require './guard'

class Calendar
  attr_accessor :entries
  attr_accessor :guards

  def initialize
    @entries = Array.new
    @guards = Hash.new
  end

  def read_entries(input_file)
    File.open(input_file, 'r').each_line do |line|
      @entries.push Entry.new(line)
    end
  end

  def write_entries(output_file)
    File.open(output_file, 'w+') do |file|
      @entries.each do |entry|
        file.puts(entry)
      end
    end
  end

  def sort_entries!
    entries.sort_by! {|entry| entry.time}
  end

  def guard(id)
    return guards[id] if guards[id]

    guard = Guard.new(id)
    guards[id] = guard

    guard
  end

  def build_timeline
    current_guard = nil
    entries.each do |entry|
      case entry.event
      when GuardEvent
        current_guard = guard(entry.event.id)
      when AsleepEvent
        current_guard.fall_asleep(entry.time)
      when AwakeEvent
        current_guard.wake_up(entry.time)
      end
    end
  end

  def best_time_1
    sleepiest_guard = nil
    most_time_asleep = 0
    guards.each do |id, guard|
      time_asleep = guard.total_time_asleep
      if time_asleep > most_time_asleep
        sleepiest_guard = guard
        most_time_asleep = time_asleep
      end
    end

    sleepiest_guard.id.to_i * sleepiest_guard.sleepiest_minute.to_i
  end

  def best_time_2
    sleepiest_minute = nil
    sleepiest_guard = nil
    greatest_time = 0

    guards.each do |id, guard|
      this_guards_sleepiest_minute = guard.sleepiest_minute
      next if this_guards_sleepiest_minute.nil?
      if guard.sleepy_minutes[this_guards_sleepiest_minute] > greatest_time
        sleepiest_minute = this_guards_sleepiest_minute
        sleepiest_guard = guard
        greatest_time = guard.sleepy_minutes[this_guards_sleepiest_minute]
      end
    end

    sleepiest_guard.id.to_i * sleepiest_minute.to_i
  end

end