require_relative '../input'
lines = get_lines $PROGRAM_NAME

require_relative 'intcode_computer.rb'

puts 'P1:'

grid = []

50.times do |x|
  50.times do |y|
    grid[x] ||= []
    grid[x] << calculate_output(lines, nil, nil, [x,y], false)
  end
end

p grid.flatten.count(1)