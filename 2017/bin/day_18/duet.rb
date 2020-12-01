require './lib/advent_of_code'
require './lib/sound_card'
require './lib/duet'

instructions = File.readlines('./bin/day_18/duet.dat')

sound_card = SoundCard.new(instructions)

until sound_card.song_over
  sound_card.next_instruction
end

puts sound_card.frequency

duet_0 = Duet.new(instructions)
duet_1 = Duet.new(instructions)
until duet_0.deadlock? and duet_1.deadlock?
  duet_0.next_instruction
  duet_1.next_instruction
end

puts Duet.duets[1].count