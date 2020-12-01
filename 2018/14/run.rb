require './recipes'

score_to_find = File.read('input.txt').strip.split('')

scores = [3, 7]
elf_1 = 0
elf_2 = 1

20_000_000.times do
  elf_scores = [scores[elf_1], scores[elf_2]]

  scores.concat(elf_scores.inject(&:+).to_s.chars.map(&:to_i))

  elf_1 = (elf_1 + 1 + scores[elf_1].to_i) % scores.length
  elf_2 = (elf_2 + 1 + scores[elf_2].to_i) % scores.length
end


puts "First Score: #{scores[score_to_find.join('').to_i..(score_to_find.join('').to_i + 9)]}"
puts "Second Score: #{scores.join('').index(score_to_find.join(''))}"