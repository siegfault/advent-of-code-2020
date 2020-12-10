class Bag
  include Comparable

  attr_reader :description

  def initialize(children: [], description:)
    @description = description
    @children_hash = children.each_with_object({}) do |child, hash|
      count, _, description = child.partition(' ')
      hash[Bag.new(description: description)] = count.to_i
    end
  end

  def <=>(other)
    description <=> other.description
  end

  def unique_children
    children_hash.keys
  end

  def children
    children_hash.flat_map do |child, count|
      [child] * count
    end
  end

  private

  attr_reader :children_hash
end
