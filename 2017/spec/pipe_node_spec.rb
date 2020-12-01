require './lib/pipe_node'

describe PipeNode do
  before(:each) do
    PipeNode.nodes.clear
  end

  context '::build_nodes' do
    it 'will build loop through all the nodes and replace children with the actual nodes, not just the name' do
      abc_node = PipeNode.new('abc', 'def')
      def_node = PipeNode.new('def', 'abc', 'jkl')
      ghi_node = PipeNode.new('ghi', 'ghi')
      jkl_node = PipeNode.new('jkl', 'def')

      PipeNode.build_nodes

      expect(abc_node.children).to eq [def_node]
      expect(def_node.children).to eq [abc_node, jkl_node]
      expect(ghi_node.children).to eq [ghi_node]
      expect(jkl_node.children).to eq [def_node]
    end
  end

  context '::get_node' do
    it 'will return the node with the specified name' do
      abc_node = PipeNode.new('abc', 'def')
      def_node = PipeNode.new('def', 'abc')

      PipeNode.build_nodes

      expect(PipeNode.get_node('abc')).to eq(abc_node)
      expect(PipeNode.get_node('def')).to eq(def_node)
    end
  end

  context '::build_group' do
    it 'will return an array of all the pipes connected to each other, starting where specified' do
      abc_node = PipeNode.new('abc', 'def')
      def_node = PipeNode.new('def', 'abc', 'jkl')
      ghi_node = PipeNode.new('ghi', 'ghi')
      jkl_node = PipeNode.new('jkl', 'def')

      PipeNode.build_nodes

      expect(PipeNode.build_group('abc')).to contain_exactly(abc_node, def_node, jkl_node)
      expect(PipeNode.build_group('def')).to contain_exactly(abc_node, def_node, jkl_node)
      expect(PipeNode.build_group('ghi')).to contain_exactly(ghi_node)
      expect(PipeNode.build_group('jkl')).to contain_exactly(abc_node, def_node, jkl_node)
    end
  end
end