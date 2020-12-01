require './lib/balancing_tower'

describe BalancingTower do
  before(:each) do
    BalancingTower.towers.clear
  end

  context '::get_tower' do
    it 'will return the tower with the specified name' do
      abc_tower = BalancingTower.new('abc', 10)
      def_tower = BalancingTower.new('def', 10, 'abc')

      expect(BalancingTower.get_tower('abc')).to eq(abc_tower)
      expect(BalancingTower.get_tower('def')).to eq(def_tower)
    end
  end

  context '::build_towers' do
    it 'will build loop through all the towers and replace children with the actual towers, not just the name' do
      abc_tower = BalancingTower.new('abc', 10)
      def_tower = BalancingTower.new('def', 10, 'abc')
      ghi_tower = BalancingTower.new('ghi', 10)
      jkl_tower = BalancingTower.new('jkl', 10, 'def', 'ghi')

      BalancingTower.build_towers

      expect(abc_tower.children).to be_empty
      expect(def_tower.children).to eq [abc_tower]
      expect(ghi_tower.children).to be_empty
      expect(jkl_tower.children).to eq [def_tower, ghi_tower]
    end
  end

  context '#has_children?' do
    it 'will return whether this tower has any children' do
      tower = BalancingTower.new('abc', 10)

      tower.children = []
      expect(tower.has_children?).to be_falsey

      tower = BalancingTower.new('def', 10, 'abc')
      expect(tower.has_children?).to be_truthy
    end
  end

  context '#total_weight' do
    it 'will equal the weight of the tower, plus the total weight of all its children' do
      abc_tower = BalancingTower.new('abc', 10)
      def_tower = BalancingTower.new('def', 10, 'abc')
      ghi_tower = BalancingTower.new('ghi', 10)
      jkl_tower = BalancingTower.new('jkl', 10, 'def', 'ghi')

      BalancingTower.build_towers

      expect(abc_tower.total_weight).to eq 10
      expect(def_tower.total_weight).to eq 20
      expect(ghi_tower.total_weight).to eq 10
      expect(jkl_tower.total_weight).to eq 40
    end
  end

  context '#balanced?' do
    it 'will determine if the total weight of all children are balanced' do
      abc_tower = BalancingTower.new('abc', 10)
      def_tower = BalancingTower.new('def', 10)
      ghi_tower = BalancingTower.new('ghi', 10, 'abc', 'def')
      jkl_tower = BalancingTower.new('jkl', 10, 'def', 'ghi')

      BalancingTower.build_towers

      expect(abc_tower.balanced?).to be_truthy
      expect(ghi_tower.balanced?).to be_truthy
      expect(jkl_tower.balanced?).to be_falsey
    end
  end
end