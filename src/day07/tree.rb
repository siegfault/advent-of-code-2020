require_relative 'bag'

class Tree
  def initialize(input:, bag:)
    @child = Bag.new(description: bag)
    @input = File.read(input)
    @outermost_bags = []
  end

  def outermost_bags
    containers_for(child).uniq
  end

  private

  attr_reader :input, :child

  def containers_for(bag)
    parents = bags.select { |b| b.children.include?(bag) }

    return [] if parents.empty?

    parents + parents.flat_map { |p| containers_for(p) }
  end

  def bags
    @bags ||= input.each_line.map do |line|
      description, *children = line.to_enum(:scan, /(\w+ \w+) bag/).map { Regexp.last_match[1] } # https://stackoverflow.com/a/6807722
      Bag.new(description: description, children: children)
    end
  end
end
