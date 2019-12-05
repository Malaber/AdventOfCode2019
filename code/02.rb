require_relative '../input'
lines = get_lines $PROGRAM_NAME

require_relative 'intcode_computer.rb'

output = calculate_output(lines, 12, 2)

print 'P1: Code at Position 0: '
puts output

100.times do |noun|
  100.times do |verb|
    output = calculate_output(lines, noun, verb)
    if output == 19690720
      print "P2: 19690720 found: "
      puts 100 * noun + verb
    end
  end
end