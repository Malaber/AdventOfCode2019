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
          if [a,b,c,d,e].uniq.size == [a,b,c,d,e].size
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
end

puts max

puts "P2:"

def run_continuously(a, b, c, d, e, lines)
  amp_a_codes, amp_b_codes, amp_c_codes, amp_d_codes, amp_e_codes = [].take 5 # this assigns nil to all vars
  amp_a_state, amp_b_state, amp_c_state, amp_d_state, amp_e_state = [0, 0, 0, 0, 0]
  max2 = 0

  running = true
  amp_a, amp_a_codes, amp_a_state, running = calculate_output(lines, nil, nil, [a], false, true, amp_a_codes, amp_a_state)
  unless running
    return amp_a
  end
  amp_b, amp_b_codes, amp_b_state, running = calculate_output(lines, nil, nil, [b], false, true, amp_b_codes, amp_b_state)
  unless running
    return amp_b
  end
  amp_c, amp_c_codes, amp_c_state, running = calculate_output(lines, nil, nil, [c], false, true, amp_c_codes, amp_c_state)
  unless running
    return amp_c
  end
  amp_d, amp_d_codes, amp_d_state, running = calculate_output(lines, nil, nil, [d], false, true, amp_d_codes, amp_d_state)
  unless running
    return amp_d
  end
  amp_e, amp_e_codes, amp_e_state, running = calculate_output(lines, nil, nil, [e], false, true, amp_e_codes, amp_e_state)
  unless running
    return amp_e
  end

  while running
    amp_a, amp_a_codes, amp_a_state, running = calculate_output(lines, nil, nil, [amp_e], false, true, amp_a_codes, amp_a_state)
    unless running
      return amp_a
    end
    amp_b, amp_b_codes, amp_b_state, running = calculate_output(lines, nil, nil, [amp_a], false, true, amp_b_codes, amp_b_state)
    unless running
      return amp_b
    end
    amp_c, amp_c_codes, amp_c_state, running = calculate_output(lines, nil, nil, [amp_b], false, true, amp_c_codes, amp_c_state)
    unless running
      return amp_c
    end
    amp_d, amp_d_codes, amp_d_state, running = calculate_output(lines, nil, nil, [amp_c], false, true, amp_d_codes, amp_d_state)
    unless running
      return amp_d
    end
    amp_e, amp_e_codes, amp_e_state, running = calculate_output(lines, nil, nil, [amp_d], false, true, amp_e_codes, amp_e_state)
    unless running
      return amp_e
    end
  end
end

max2 = 0
max2_params = nil

(5..9).each do |a|
  (5..9).each do |b|
    (5..9).each do |c|
      (5..9).each do |d|
        (5..9).each do |e|
          if [a,b,c,d,e].uniq.size == [a,b,c,d,e].size
            check = run_continuously(a, b, c, d, e, lines)
            if check > max2
              max2 = check
              max2_params = [a,b,c,d,e]
            end
          end
        end
      end
    end
  end
end

puts max2
p max2_params