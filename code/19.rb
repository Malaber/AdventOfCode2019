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
large_grid_dimensions = 1000

large_grid_dimensions.times do |x|
  puts x if x%100 == 0
  skip = false
  found_1 = false

  large_grid_dimensions.times do |y|
    large_grid[x] ||= []
    if skip
      is_pulling = 0
    else
      is_pulling = calculate_output(lines, nil, nil, [x,y], false)
      if is_pulling == 0
        if found_1
          skip = true
        end
      else
        found_1 = true
      end
    end
    large_grid[x] << is_pulling
  end
end

p large_grid[999].count(1)
p large_grid.map{|g| g[999]}.count(1)