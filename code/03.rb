require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'set'

wire_points = []
wire_points[1] = {}
wire_points[2] = {}

def add_to_hash!(x, y, hash, steps)
  hash["X#{x},Y#{y}"] = steps
end

def step!(hash, steps, x, y)
  steps += 1
  add_to_hash!(x, y, hash, steps)
  steps
end

lines.each_with_index do |wire, index|
  hash = wire_points[index + 1]
  x = 0
  y = 0
  steps = 0

  wire.split(',').each do |action|
    direction = action[0]
    action[0] = ''
    length = action.to_i
    case direction
    when 'D'
      length.times do
        y -= 1
        steps = step!(hash, steps, x, y)
      end
    when 'U'
      length.times do
        y += 1
        steps = step!(hash, steps, x, y)
      end
    when 'R'
      length.times do
        x += 1
        steps = step!(hash, steps, x, y)
      end
    when 'L'
      length.times do
        x -= 1
        steps = step!(hash, steps, x, y)
      end
    end
  end
end

intersections = wire_points[1].keys & wire_points[2].keys

distances = {}

intersections.each do |inter|
  regex = inter.match(/X[-]?(?<x>\d+),Y[-]?(?<y>\d+)/)
  x = regex[:x].to_i
  y = regex[:y].to_i

  distances[inter] = y + x
end

intersection_steps = {}

intersections.each do |inter|
  intersection_steps[inter] = wire_points[1][inter] + wire_points[2][inter]
end

puts "P1:"
puts(distances.min_by { |_k, v| v })
puts

puts "P2:"
puts(intersection_steps.min_by { |_k, v| v })
puts
