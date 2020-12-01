require './lib/advent_of_code'
require './lib/stream_parser'

stream = File.read('./bin/day_9/stream_processing.dat')

StreamParser.parse_stream(stream.chars)

puts StreamParser.score
puts StreamParser.garbage_score
