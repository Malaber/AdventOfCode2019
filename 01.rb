require_relative 'input'
lines = get_lines $0

allfuel = 0
lines.each do |line|
  mass = line.to_i
  fuel = ((mass / 3).floor) - 2
  allfuel += fuel
end

puts allfuel
