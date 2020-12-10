require_relative '../../src/day07/bag'

RSpec.describe Bag do
  describe '#description' do
    it 'is recorded' do
      expect(Bag.new(description: 'muted red').description).to eq('muted red')
    end
  end

  describe '#unique_children' do
    it 'can be empty' do
      expect(Bag.new(description: 'muted red').unique_children).to be_empty
    end

    it 'can be present' do
      expect(Bag.new(description: 'muted red', children: ['1 faded plum']).unique_children).to contain_exactly(Bag.new(description: 'faded plum'))
    end
  end

  describe '#children' do
    it 'can represent a count of children' do
      expect(Bag.new(description: 'muted red', children: ['3 faded plum', '2 dark red']).children.count).to eq(5)
    end
  end
end
