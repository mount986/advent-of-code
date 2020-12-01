class DiskGrid

  def initialize
    @nodes = Array.new
    @num_regions = 0
  end

  def add_row(row_num, binary_string)
    @nodes[row_num] = Array.new

    index = 0
    binary_string.chars.each do |char|
      if char.to_i == 1
        @num_regions += 1
        @nodes[row_num][index] = @num_regions
      else
        @nodes[row_num][index] = 0
      end

      index += 1
    end

    def build_regions!
      @nodes.length.times do |row|
        @nodes.length.times do |col|
          current_node = @nodes[row][col]
          unless current_node == 0
            previous_col = (col == 0 ? 0 : @nodes[row][col - 1])
            if previous_col != 0 and previous_col != current_node
              flip_regions(previous_col, current_node)
            end

            previous_row = (row == 0 ? 0 : @nodes[row - 1][col])
            if previous_row != 0 and previous_row != current_node
              flip_regions(previous_row, current_node)
            end
          end
        end
      end
    end

    def flip_regions(reg_1, reg_2)
      @nodes.length.times do |row|
        @nodes.length.times do |col|
          @nodes[row][col] = reg_2 if @nodes[row][col] == reg_1
        end
      end
    end

    def count_on
      count = 0

      @nodes.each do |row|
        row.each do |node|
          count += 1 unless node == 0
        end
      end

      count
    end

    def count_regions
      active_regions = Array.new

      @nodes.each do |row|
        row.each do |node|
          active_regions.push node unless node == 0
        end
      end

      active_regions.uniq.count
    end

    def print_nodes
      @nodes.each do |row|
        puts row.join(' ')
      end
    end
  end
end