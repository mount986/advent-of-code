require './box'
require './box_manager'

box_manager = BoxManager.new

count_with_2 = 0
count_with_3 = 0
File.open('input.txt', 'r').each_line do |line|
  box = Box.new(line)
  count_with_2 += 1 if box.has_2_alike?
  count_with_3 += 1 if box.has_3_alike?

  box_manager.boxes.push box
end

box_manager.write_to_file('output.txt')

puts "final checksum: #{count_with_2 * count_with_3}"

box_manager.boxes.count.times do |index_1|
  ((index_1 + 1)..(box_manager.boxes.count - 1)).each do |index_2|
    difference = box_manager.compare_boxes(index_1, index_2)

    if difference == 1
      puts box_manager.boxes[index_1].id
      puts box_manager.boxes[index_2].id
      break
    end
  end
end