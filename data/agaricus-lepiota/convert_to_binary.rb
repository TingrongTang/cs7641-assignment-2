require 'csv'
require 'set'

map = {}

CSV.foreach('./data/agaricus-lepiota/agaricus-lepiota.csv', :headers => true) do |csv|
  csv.each do |k,v|
    map[k] ||= Set.new
    map[k] << v
  end
end

headers = map.flat_map do |k, s|
  if s.length == 1
    next
  elsif s.length == 2
    "#{k}_#{s.first}"
  else
    s.map {|ss| "#{k}_#{ss}"}
  end
end.compact

CSV.open("./data/agaricus-lepiota/agaricus-lepiota-numeric.csv", 'wb') do |row|
  row << headers
  CSV.foreach('./data/agaricus-lepiota/agaricus-lepiota.csv', :headers => true) do |csv|
    vector = headers.map do |h|
      k,v = h.split("_")
      if csv[k] == v
        1
      else
        0
      end
    end
    row << vector
  end
end