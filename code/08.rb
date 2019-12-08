require_relative '../input'
lines = get_lines $PROGRAM_NAME

height = 6
width = 25

digits = lines.first.split('').map(&:to_i)

layers = []

while digits.size > 0
  layers << digits.shift(height * width)
end

min = 999999999999999999999999999999999999999999999
minlayer = nil

layers.each do |layer|
  count1 = layer.count(0)
  if count1 < min
    min = count1
    minlayer = layer
  end
end

puts "P1:"
p minlayer.count(1) * minlayer.count(2)

