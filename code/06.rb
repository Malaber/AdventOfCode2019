require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'rgl/dot'
require 'rgl/adjacency'
require 'set'

graph = RGL::DirectedAdjacencyGraph.new
unique_nodes = Set.new

lines.each do | line |
  p1, p2 = line.split(')')
  graph.add_edge(p1, p2)
  unique_nodes << p1
  unique_nodes << p2
end

unique_nodes.each do | node |
  # puts graph.dijkstra_shortest_path({}, "COM", node)
end

graph.print_dotted_on
graph.write_to_graphic_file