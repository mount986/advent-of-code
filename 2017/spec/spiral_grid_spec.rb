require './lib/spiral_grid'

describe SpiralGrid do
  before(:each) do
    SpiralGrid.new_grid
  end

  context '::new_grid' do
    it 'will reset Grids nodes to a single root node at (0,0) with value of 1' do
      SpiralGrid.nodes = [1, 2, 3, 4, 5]

      SpiralGrid.new_grid
      expect(SpiralGrid.nodes.count).to eq 1
      expect(SpiralGrid.nodes.first).to be_a SpiralGrid::Node
      expect(SpiralGrid.nodes.first.x).to eq 0
      expect(SpiralGrid.nodes.first.y).to eq 0
      expect(SpiralGrid.nodes.first.value).to eq 1
    end
  end

  context '::next_direction' do
    it 'will return left if the direction passed in is up' do
      expect(SpiralGrid.next_direction(:up)).to eq :left
    end

    it 'will return right if the direction passed in is down' do
      expect(SpiralGrid.next_direction(:down)).to eq :right
    end

    it 'will return up if the direction passed in is right' do
      expect(SpiralGrid.next_direction(:right)).to eq :up
    end

    it 'will return down if the direction passed in is left' do
      expect(SpiralGrid.next_direction(:left)).to eq :down
    end
  end

  context '::get_node' do
    it 'will return the node at the specified coordinates on the SpiralGrid' do
      node = SpiralGrid::Node.new(3, 10, 10)
      SpiralGrid.nodes.push node

      expect(SpiralGrid.get_node(3, 10)).to eq node
    end

    it 'will return an EmptyNode if the specified coordinates on the grid have not been populated' do
      node = SpiralGrid::Node.new(3, 10, 10)
      SpiralGrid.nodes.push node

      expect(SpiralGrid.get_node(10, 3)).to be_a SpiralGrid::EmptyNode
      expect(SpiralGrid.get_node(10, 3).value).to eq(0)
    end
  end

  context '::next_node' do
    it 'will return the coordinates of the next node in the specified direction' do
      expect(SpiralGrid.next_node(1,1,:right)).to eq [2,1]
      expect(SpiralGrid.next_node(1,1,:left)).to eq [0,1]
      expect(SpiralGrid.next_node(1,1,:up)).to eq [1,2]
      expect(SpiralGrid.next_node(1,1,:down)).to eq [1,0]
    end
  end

  context '::populate_next_node' do
    it 'will push a new node onto the grid using new_direction if empty, otherwise in the current direction' do
      SpiralGrid.nodes.push SpiralGrid::Node.new(1, 0, 1)
      SpiralGrid.nodes.push SpiralGrid::Node.new(1, 1, 2)

      SpiralGrid.direction = :up

      new_node = SpiralGrid.populate_next_node
      expect(new_node.x).to eq 0
      expect(new_node.y).to eq 1
      expect(SpiralGrid.direction).to eq :left

      new_node = SpiralGrid.populate_next_node
      expect(new_node.x).to eq -1
      expect(new_node.y).to eq 1
      expect(SpiralGrid.direction).to eq :left
    end
  end
end

describe SpiralGrid::Node do
  before(:each) do
    SpiralGrid.new_grid
  end

  context '#sum_of_surrounding_nodes' do
    it 'will return the value in all of the nodes surrounding this one, including diagnols' do
      node = SpiralGrid::Node.new(10,10,10)
      node.up = SpiralGrid::Node.new(10,11,1)
      node.down = SpiralGrid::Node.new(10,9,2)
      node.left = SpiralGrid::Node.new(9,10,3)
      node.right = SpiralGrid::Node.new(11,10,4)
      node.upleft = SpiralGrid::Node.new(9,11,5)
      node.upright = SpiralGrid::Node.new(11,11,6)
      node.downleft = SpiralGrid::Node.new(9,9,7)
      node.downright = SpiralGrid::Node.new(11,9,8)

      expect(node.sum_of_surrounding_nodes).to eq (1+2+3+4+5+6+7+8)
    end
  end
end