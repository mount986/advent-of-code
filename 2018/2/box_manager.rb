class BoxManager
  attr_accessor :boxes

  def initialize
    @boxes = Array.new
  end

  def sort!
    @boxes.sort_by! {|box| box.id}
  end

  def write_to_file(file_name)
    File.open(file_name, 'w+') do |file|
      @boxes.each do |box|
        file.puts([box.id,
                   "2: #{box.letters_with_2.join(',')}",
                   "3: #{box.letters_with_3.join(',')}"].join(' '))
      end
    end
  end

  def compare_boxes(index_1, index_2)
    difference_count = 0
    box_1 = @boxes[index_1]
    box_2 = @boxes[index_2]

    box_1.id.chars.count.times do |index|
      difference_count += 1 unless box_1.id[index] == box_2.id[index]
    end

    return difference_count
  end

end