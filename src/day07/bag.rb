class Bag
  include Comparable

  attr_reader :children, :description

  def initialize(children: [], description:)
    @description = description
    @children = children.map { |child| Bag.new(description: child) }
  end

  def <=>(other)
    description <=> other.description
  end
end
