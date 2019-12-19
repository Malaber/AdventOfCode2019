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
large_grid_dimensions = 3000
santa_dimensions = 100

large_grid_dimensions.times do |x|
  large_grid_dimensions.times do
    large_grid[x] ||= []
    large_grid[x] << 0
  end
end

left = 0
right = large_grid_dimensions-1

large_grid.each_with_index do |line, x|
  puts "#{x}/#{large_grid_dimensions}" if (x % 100).zero?

  skip = false
  found_1 = false

  (left..right).each do |y|
    next if skip

    is_pulling = calculate_output(lines, nil, nil, [x, y], false)
    if is_pulling.zero?
      if found_1
        skip = true
        next
      end
    else
      found_1 = true
    end
    large_grid[x][y] = is_pulling
  end

  first_one = line.index(1)
  unless first_one.nil?
    left = first_one - 1
  end
  left = 0 if left.negative?
end

break_now = false
santa_x = 0
santa_y = 0

large_grid.each_with_index do |line, x|
  line.each_with_index do |tractor, y|
    next if tractor.zero?

    next unless large_grid[x][y, santa_dimensions].count(1) == santa_dimensions

    next unless large_grid[x, santa_dimensions].map { |i| i[y] }.count(1) == santa_dimensions

    santa_x = x
    santa_y = y

    break_now = true
    break
  end

  break if break_now
end

puts "P2: #{santa_x * 10_000 + santa_y}, x: #{santa_x}, y: #{santa_y}"
