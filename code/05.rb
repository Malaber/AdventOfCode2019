require_relative '../input'
lines = get_lines $PROGRAM_NAME

require_relative 'intcode_computer.rb'

puts 'P1:'
calculate_output(lines, nil, nil, 1)

puts

puts 'P2:'
calculate_output(lines, nil, nil, 5)
