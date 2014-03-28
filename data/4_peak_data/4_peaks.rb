valleys = [1, 4, 15,20, 28]

peaks = {
  3 => 1,
  8 => 3,
  18 => 7,
  27 => 3
}

last_valley = 0
(1..28).each do |i|
  x, y = peaks.find {|k,v| k >= i }

  closest_valley = valleys.find {|k| k < x && k > last_valley }
  if x == i
    last_valley = i
  end

  rate = Rational(y, (x - closest_valley))
  puts (i - closest_valley) * rate
end
