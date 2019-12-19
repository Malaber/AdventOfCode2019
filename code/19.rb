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

puts 'P2:'

large_grid = []

1000.times do |x|
  puts x if x%100 == 0
  1000.times do |y|
    large_grid[x] ||= []
    large_grid[x] << calculate_output(lines, nil, nil, [x,y], false)
  end
end

p large_grid[999].count(1)
p large_grid.map{|g| g[999]}.count(1)