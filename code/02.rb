require_relative '../input'
lines = get_lines $PROGRAM_NAME

def calculate_output(lines, noun, verb)
  codes = lines.first.split(',').map!(&:to_i)

# restore
  codes[1] = noun
  codes[2] = verb

  running = true
  current = 0

  while running
    case codes[current]
    when 1
      # addition
      dig1 = codes[codes[current + 1]]
      dig2 = codes[codes[current + 2]]
      codes[codes[current + 3]] = dig1 + dig2
    when 2
      # multiplication
      dig1 = codes[codes[current + 1]]
      dig2 = codes[codes[current + 2]]
      codes[codes[current + 3]] = dig1 * dig2
    when 99
      running = false
    else
      puts 'The ship computer bursts into flames.'
      running = false
    end
    current += 4
  end

  output = codes[0]
end

output = calculate_output(lines, 12, 2)

print 'P1: Code at Position 0: '
puts output

