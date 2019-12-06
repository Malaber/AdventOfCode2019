require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'set'

def get_parent_node(node, nodes)
  nodes.select {|n| nodes[n].include?(node)}.keys.first
end

def get_distance_from_com(node, nodes)
  parent = get_parent_node(node, nodes)
  if parent == "COM"
    return 1
  else
    return 1 + get_distance_from_com(parent, nodes)
  end
end

unique_nodes = Set.new

nodes = {}
lines.each do | line |
  p1, p2 = line.chomp.split(')')

  unique_nodes << p1
  unique_nodes << p2

  nodes[p1] ||= []
  nodes[p1] << p2
end

distance = 0
unique_nodes.each do |node|
  unless node == "COM"
    distance += get_distance_from_com(node, nodes)
  end
end

puts distance