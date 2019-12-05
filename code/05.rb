require_relative '../input'
lines = get_lines $PROGRAM_NAME

def get_next_param_mode!(digits)
  digit = digits.pop
  digit.nil? ? 0 : digit
end

def get_parameter_value(position, mode, codes)
  case mode
  when 0
    return codes[codes[position]].to_i
  when 1
    return codes[position].to_i
  else
    raise "OP Parameter Mode '#{mode}' not allowed"
  end
end

def calculate_output(lines, noun = nil, verb = nil)
  codes = lines.first.split(',').map!(&:to_i)

# restore
  codes[1] = noun unless noun.nil?
  codes[2] = verb unless verb.nil?

  running = true
  current = 0

  while running
    op_code_digits = codes[current].digits.reverse
    op_code = op_code_digits.pop(2).join('').to_i

    p1 = get_next_param_mode!(op_code_digits)
    p2 = get_next_param_mode!(op_code_digits)
    p3 = get_next_param_mode!(op_code_digits)

    case op_code
    when 1
      # addition
      dig1 = get_parameter_value(current + 1, p1, codes)
      dig2 = get_parameter_value(current + 2, p2, codes)
      codes[codes[current + 3]] = dig1 + dig2
      current += 4
    when 2
      # multiplication
      dig1 = get_parameter_value(current + 1, p1, codes)
      dig2 = get_parameter_value(current + 2, p2, codes)
      codes[codes[current + 3]] = dig1 * dig2
      current += 4
    when 3
      puts "Input Code:"
      input = gets.chomp
      codes[codes[current + 1]] = input
      current += 2
    when 4
      puts "Output Code:"
      puts get_parameter_value(current + 1, p1, codes)
      current += 2
    when 99
      current += 1
      running = false
    else
      puts 'The ship computer bursts into flames.'
      current += 1
      running = false
    end
  end

  codes[0]
end

puts 'P1:'
calculate_output(lines)
