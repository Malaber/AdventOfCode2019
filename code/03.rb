require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'set'

wire_points = []
wire_points[1] = Set[]
wire_points[2] = Set[]

def add_to_set!(x, y, set)
  set << "X#{x},Y#{y}"
end

lines.each_with_index do |wire, index|
  set = wire_points[index + 1]
  x = 0
  y = 0

  wire.split(',').each do |action|
    direction = action[0]
    action[0] = ''
    length = action.to_i
    case direction
    when 'D'
      length.times do
        y -= 1
        add_to_set!(x, y, set)
      end
    when 'U'
      length.times do
        y += 1
        add_to_set!(x, y, set)
      end
    when 'R'
      length.times do
        x += 1
        add_to_set!(x, y, set)
      end
    when 'L'
      length.times do
        x -= 1
        add_to_set!(x, y, set)
      end
    end
  end
end

intersections = wire_points[1] & wire_points[2]

distances = {}

intersections.each do |inter|
  regex = inter.match(/X[-]?(?<x>\d+),Y[-]?(?<y>\d+)/)
  x = regex[:x].to_i
  y = regex[:y].to_i

  distances[inter] = y + x
end

puts(distances.min_by { |_k, v| v })
