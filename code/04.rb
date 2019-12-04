require_relative '../input'
lines = get_lines $PROGRAM_NAME

require 'set'

def not_decreasing?(number)
  current = nil

  number.digits.reverse.each do |digit|
    last = current
    current = digit

    next if last.nil?

    return false if current < last
  end
  true
end

def two_repeating_digits?(number)
  current = nil

  digits = number.digits.reverse

  digits.each_with_index do |_digit, index|
    pre_last = digits[index - 2]
    last = digits[index - 1]
    current = digits[index]
    next_dig = digits[index + 1]

    return true if current == last && current != next_dig && current != pre_last
  end
  false
end

boundaries = lines.first.split('-')
upper = boundaries.first.to_i
lower = boundaries[1].to_i

valid_bounds = Set.new

(upper..lower).each do |bound|
  if not_decreasing?(bound) && two_repeating_digits?(bound)
    valid_bounds << bound
  end
end

puts "P1: #{valid_bounds.size}"
