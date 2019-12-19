require_relative '../input'
lines = get_lines $PROGRAM_NAME

require_relative 'intcode_computer.rb'

puts 'P1:'

pulled_fields = 0
50.times do |x|
  50.times do |y|
    pulled = calculate_output(lines, nil, nil, [x,y], false)
    pulled_fields += 1 if pulled == 1
  end
end

p pulled_fields