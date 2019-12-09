def get_next_param_mode!(digits)
  digit = digits.pop
  digit.nil? ? 0 : digit
end

def get_parameter_value(position, mode, codes, relative_base)
  case mode
  when 0
    # position mode
    return codes[codes[position]].to_i
  when 1
    # immediate mode
    return codes[position].to_i
  when 2
    # relative mode
    return codes[codes[position] + relative_base].to_i
  else
    raise "OP Parameter Mode '#{mode}' not allowed"
  end
end

def set_parameter_value!(position, mode, codes, relative_base, input)
  case mode
  when 0
    # position mode
    codes[codes[position]] = input
  when 1
    # immediate mode
    raise 'AoC states that parameters are never written to in immediate mode'
  when 2
    # relative mode
    codes[codes[position] + relative_base] = input
  else
    raise "OP Parameter Mode '#{mode}' not allowed"
  end
end

def calculate_output(lines, noun = nil, verb = nil, input = nil, verbose = true, continuous_mode = false, previous_codestate = nil, previous_pointer = 0)
  codes = lines.first.split(',').map(&:to_i)

# restore
  codes[1] = noun unless noun.nil?
  codes[2] = verb unless verb.nil?

  running = true
  current = previous_pointer
  output = []

  unless previous_codestate.nil?
    codes = previous_codestate.first
  end

  relative_base = 0

  while running
    op_code_digits = codes[current].digits.reverse
    op_code = op_code_digits.pop(2).join('').to_i

    p1_mode = get_next_param_mode!(op_code_digits)
    p2_mode = get_next_param_mode!(op_code_digits)
    p3_mode = get_next_param_mode!(op_code_digits)

    case op_code
    when 1
      # addition
      dig1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      dig2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      set_parameter_value!(current + 3, p3_mode, codes, relative_base, dig1 + dig2)
      current += 4
    when 2
      # multiplication
      dig1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      dig2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      set_parameter_value!(current + 3, p3_mode, codes, relative_base, dig1 * dig2)
      current += 4
    when 3
      # input
      if input.is_a? Array
        input_code = input.shift
      else
        input_code = input
      end

      if input.nil? && continuous_mode
        break
      end
      set_parameter_value!(current + 1, p1_mode, codes, relative_base, input_code)
      puts "Input Code: #{input_code}" if verbose
      current += 2
    when 4
      # output
      out = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      puts "Output Code: #{out}" if verbose
      output << out
      current += 2
    when 5
      # jump if true
      p1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      p2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      if p1.zero?
        current +=3
      else
        current = p2
      end
    when 6
      # jump if false
      p1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      p2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      if p1.zero?
        current = p2
      else
        current +=3
      end
    when 7
      # less than
      dig1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      dig2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      set_parameter_value!(current + 3, p3_mode, codes, relative_base, (dig1 < dig2)? 1 : 0)
      current += 4
    when 8
      # equals
      dig1 = get_parameter_value(current + 1, p1_mode, codes, relative_base)
      dig2 = get_parameter_value(current + 2, p2_mode, codes, relative_base)
      set_parameter_value!(current + 3, p3_mode, codes, relative_base, (dig1 == dig2)? 1 : 0)
      current += 4
    when 9
      # equals
      relative_base += get_parameter_value(current + 1, p1_mode, codes, relative_base)
      current += 2
    when 99
      current += 1
      running = false
    else
      current += 1
      running = false
      raise 'The ship computer bursts into flames.'
    end
  end

  if continuous_mode
    output = [output, codes, current, running]
  elsif output.empty?
    output = codes[0]
  elsif output.size == 1
    output = output.first
  end
  output
end