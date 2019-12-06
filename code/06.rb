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

distance = 0
unique_nodes.each do |node|
  unless node == "COM"
    distance += get_distance_from_com(node, nodes)
  end
end

puts "P1: #{distance}"

# P2
#
santas_way = get_way_to_com("SAN", nodes).reverse
my_way =  get_way_to_com("YOU", nodes).reverse
meeting_point = (my_way & santas_way).last

santas_way_to_meeting_point = get_way("SAN", meeting_point, nodes)
my_way_to_meeting_point = get_way("YOU", meeting_point, nodes)

I_DIDNT_MANAGE_TO_CORRECTLY_READ_THE_PUZZLE_AND_THEREFORE_DIDNT_SEE_THAT_I_WASNT_SUPPOSED_TO_COUNT_THE_ACTUAL_DISTANCE_TO_SANTA_BUT_RATHER_HOW_MANY_ORBIT_JUMPS_IT_TAKES_TO_GET_INTO_THE_SAME_ORBIT_AS_HE_IS = 2
orbits_to_jump = santas_way_to_meeting_point.size + my_way_to_meeting_point.size - I_DIDNT_MANAGE_TO_CORRECTLY_READ_THE_PUZZLE_AND_THEREFORE_DIDNT_SEE_THAT_I_WASNT_SUPPOSED_TO_COUNT_THE_ACTUAL_DISTANCE_TO_SANTA_BUT_RATHER_HOW_MANY_ORBIT_JUMPS_IT_TAKES_TO_GET_INTO_THE_SAME_ORBIT_AS_HE_IS

puts "P2: #{orbits_to_jump}"