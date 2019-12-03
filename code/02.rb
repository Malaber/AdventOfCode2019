require_relative '../input'
lines = get_lines $PROGRAM_NAME

codes = lines.first.split(',').map!(&:to_i)

# restore
codes[1] = 12
codes[2] = 2

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
    puts 'Program halted.'
    running = false
  else
    puts 'The ship computer bursts into flames.'
    running = false
  end
  current += 4
end

print 'Code at Position 0: '
puts codes[0]
