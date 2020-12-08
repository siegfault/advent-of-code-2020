require_relative '../../src/day07/tree'

RSpec.describe Tree do
  let(:rules) do
    <<~RULES
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    RULES
  end
  let(:expected_parents) do
    [
      Bag.new(description: 'bright white'),
      Bag.new(description: 'muted yellow'),
      Bag.new(description: 'dark orange'),
      Bag.new(description: 'light red')
    ]
  end
  let(:expected_children) do
    [
      [Bag.new(description: 'dark olive')] * 1,
      [Bag.new(description: 'vibrant plum')] * 2,
      [Bag.new(description: 'faded blue')] * 13,
      [Bag.new(description: 'dotted black')] * 16
    ].flatten
  end

  it 'finds the outermost bags' do
    allow(File).to receive(:read)
    allow(File).to receive(:read).with('filename.txt').and_return(rules)
    expect(Tree.new(input: 'filename.txt', bag: 'shiny gold').outer_bags).to contain_exactly(*expected_parents)
  end

  it 'finds the inner bags' do
    allow(File).to receive(:read)
    allow(File).to receive(:read).with('filename.txt').and_return(rules)
    expect(Tree.new(input: 'filename.txt', bag: 'shiny gold').inner_bags).to contain_exactly(*expected_children)
  end
end
