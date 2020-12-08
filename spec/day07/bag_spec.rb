require_relative '../../src/day07/bag'

RSpec.describe Bag do
  describe '#description' do
    it 'is recorded' do
      expect(Bag.new(description: 'muted red').description).to eq('muted red')
    end
  end

  describe '#children' do
    it 'can be empty' do
      expect(Bag.new(description: 'muted red').children).to be_empty
    end

    it 'can be present' do
      expect(Bag.new(description: 'muted red', children: ['faded plum']).children).to contain_exactly(Bag.new(description: 'faded plum'))
    end
  end
end
