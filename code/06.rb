require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'set'

def get_parent_node(node, nodes)
  nodes.select {|n| nodes[n].include?(node)}.keys.first
end

def get_way(from, to, nodes)
  parent = get_parent_node(from, nodes)
  if parent == to
    [parent]
  else
    [parent].concat(get_way(parent, to, nodes))
  end
end

def get_way_to_com(node, nodes)
  get_way(node, "COM", nodes)
end

def get_distance_from_com(node, nodes)
  parent = get_parent_node(node, nodes)
  if parent == "COM"
    1
  else
    1 + get_distance_from_com(parent, nodes)
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

p get_way("YOU", "D", nodes)

puts

p santas_way = get_way_to_com("SAN", nodes).reverse
p my_way =  get_way_to_com("YOU", nodes).reverse
p meeting_point = (my_way & santas_way).last

p santas_way_to_meeting_point = get_way("SAN", meeting_point, nodes)
p my_way_to_meeting_point = get_way("SAN", meeting_point, nodes)

p santas_way_to_meeting_point.size+my_way_to_meeting_point.size