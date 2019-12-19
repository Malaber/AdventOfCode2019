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
  large_grid_dimensions.times do
    large_grid[x] ||= []
    large_grid[x] << 0
  end
end

left = 0
right = large_grid_dimensions-1

large_grid.each_with_index do |line, x|
  catch :skip_outer_loop do
    puts "#{x}/#{large_grid_dimensions}" if (x % 100).zero?

    found_1 = false

    (left..right).each do |y|
      is_pulling = calculate_output(lines, nil, nil, [x, y], false)
      if is_pulling.zero?
        if found_1
          throw :skip_outer_loop
        end
      else
        found_1 = true
      end

      large_grid[x][y] = is_pulling
    end

    first_one = line.index(1)
    unless first_one.nil?
      left = first_one - 3
    end
    left = 0 if left.negative?
  end
end

p large_grid[999].count(1),large_grid[999]
p large_grid.flatten.count(1)
