require 'optionparser'
require_relative 'tree'

options = {}

OptionParser.new do |parser|
  parser.on('--input INPUT', 'Input file for rules') do |input|
    options[:input] = input
  end

  parser.on('--brightness BRIGHTNESS', 'Brightness of bag to find') do |brightness|
    options[:brightness] = brightness
  end

  parser.on('--color color', 'Color of bag to find') do |color|
    options[:color] = color
  end
end.parse(ARGV)

tree = Tree.new(input: options[:input], bag: "#{options[:brightness]} #{options[:color]}")

puts <<~OUTPUT
  Possible outer containers: #{tree.outer_bags.count}
  Required inner containers: #{tree.inner_bags.count}
OUTPUT
