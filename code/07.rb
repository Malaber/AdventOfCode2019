require_relative '../input'
lines = get_lines $PROGRAM_NAME

require_relative 'intcode_computer.rb'

puts 'P1:'
max = 0

5.times do |a|
  5.times do |b|
    5.times do |c|
      5.times do |d|
        5.times do |e|
          amp_a = calculate_output(lines, nil, nil, [a, 0], false)
          amp_b = calculate_output(lines, nil, nil, [b, amp_a], false)
          amp_c = calculate_output(lines, nil, nil, [c, amp_b], false)
          amp_d = calculate_output(lines, nil, nil, [d, amp_c], false)
          amp_e = calculate_output(lines, nil, nil, [e, amp_d], false)

          if amp_e > max
            max = amp_e
          end
        end
      end
    end
  end
end

puts max