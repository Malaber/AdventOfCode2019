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

puts "P1: #{minlayer.count(1) * minlayer.count(2)}"

puts

puts "P2:"
squash = []

def get_pixel_color(i, layers)
  layers.each do |layer|
    unless layer[i] == 2
      return layer[i]
    end
  end
end

layers.first.each_with_index do |_pixel, i|
  squash[i] = get_pixel_color(i, layers)
end

rows = []

until squash.empty?
  rows << squash.shift(width)
end

rows.each do |row|
  p row.join("").gsub("0", " ").gsub("1", "█")
end