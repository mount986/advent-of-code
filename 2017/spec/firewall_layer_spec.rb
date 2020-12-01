require './lib/firewall_layer'

describe FirewallLayer do
  before(:each) do
    FirewallLayer.layers.clear
  end

  context '#collision?' do
    it 'will return true if the scanner would be at position 1 when the scanner reaches its depth after a given delay' do
      zero_layer = FirewallLayer.new(0, 10)
      one_layer = FirewallLayer.new(1, 2)
      eighty_layer = FirewallLayer.new(80, 20)

      expect(zero_layer.collision?(0)).to be_truthy
      expect(zero_layer.collision?(1)).to be_falsey
      expect(zero_layer.collision?(10)).to be_falsey
      expect(zero_layer.collision?(18)).to be_truthy
      expect(one_layer.collision?(0)).to be_falsey
      expect(one_layer.collision?(1)).to be_truthy
      expect(one_layer.collision?(2)).to be_falsey
      expect(one_layer.collision?(3)).to be_truthy
      expect(eighty_layer.collision?(0)).to be_falsey
      expect(eighty_layer.collision?(34)).to be_truthy
      expect(eighty_layer.collision?(72)).to be_truthy

    end
  end
end
