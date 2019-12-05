require_relative '../input'
lines = get_lines $PROGRAM_NAME

def calculate_output(lines, noun = nil, verb = nil)
  codes = lines.first.split(',').map!(&:to_i)

# restore
  codes[1] = noun unless noun.nil?
  codes[2] = verb unless verb.nil?

  running = true
  current = 0

  while running
    case codes[current]
    when 1
      # addition
      dig1 = codes[codes[current + 1]]
      dig2 = codes[codes[current + 2]]
      codes[codes[current + 3]] = dig1 + dig2
      current += 4
    when 2
      # multiplication
      dig1 = codes[codes[current + 1]]
      dig2 = codes[codes[current + 2]]
      codes[codes[current + 3]] = dig1 * dig2
      current += 4
    when 99
      current += 1
      running = false
    else
      puts 'The ship computer bursts into flames.'
      current += 1
      running = false
    end
  end

  output = codes[0]
end

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