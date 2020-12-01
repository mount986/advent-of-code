require './lib/register'

describe Register do
  context '#[]' do
    it 'will return the value of the specified register' do
      reg = Register.new
      reg['abc'] = 123

      expect(reg['abc']).to eq 123
    end

    it 'will set the register equal to 0 if it has not previously been defined' do
      reg = Register.new

      expect(reg['abc']).to eq 0
    end
  end

  context '#[]=' do
    it 'will set the value of the specified regist' do
      reg = Register.new
      reg['abc'] = 123

      expect(reg['abc']).to eq 123
    end

    it 'will set @max equal to the value, if the value is greater than the current max' do
      reg = Register.new

      reg['abc'] = 123
      expect(reg.max).to eq(123)

      reg['def'] = 10
      expect(reg.max).to eq(123)

      reg['ghi'] = 5000
      expect(reg.max).to eq(5000)
    end
  end

  context '#inc' do
    it 'will increment the value of the register by the given amount' do
      reg = Register.new
      reg['abc'] = 123

      reg.inc('abc', 10)
      expect(reg['abc']).to eq(133)

      reg.inc('abc', -20)
      expect(reg['abc']).to eq(113)

      reg.inc('def', 30)
      expect(reg['def']).to eq(30)
    end
  end

  context '#dec' do
    it 'will decrement the value of the register by the given amount' do
      reg = Register.new
      reg['abc'] = 123

      reg.dec('abc', 10)
      expect(reg['abc']).to eq(113)

      reg.dec('abc', -20)
      expect(reg['abc']).to eq(133)

      reg.dec('def', 30)
      expect(reg['def']).to eq(-30)
    end
  end
end
