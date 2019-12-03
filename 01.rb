require_relative 'input'
lines = get_lines $0

def fuelfuel(fuel)
  required_fuel = ((fuel / 3).floor) - 2
  if required_fuel > 0
    return fuelfuel(required_fuel) + required_fuel
  else
    return 0
  end
end


allfuel = 0
lines.each do |line|
  mass = line.to_i
  fuel = ((mass / 3).floor) - 2
  allfuel += fuel
end

print "1: "
puts allfuel

allfuel_with_fuelfuel = 0
lines.each do |line|
  mass = line.to_i
  fuel = ((mass / 3).floor) - 2
  allfuel_with_fuelfuel += fuel

  allfuel_with_fuelfuel += fuelfuel(fuel)
end

print "2: "
puts allfuel_with_fuelfuel