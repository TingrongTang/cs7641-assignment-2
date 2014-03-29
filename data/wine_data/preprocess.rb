require 'csv'

CSV.open("winequality.csv", 'wb') do |out|
  headers = nil
  CSV.foreach("winequality-red.csv", :headers => true) do |csv|
    if headers.nil?
      headers = %w[red].concat(csv.headers)
      out << headers
    end

    row = %w[1].concat(csv.to_hash.values)
    out << row
  end

  CSV.foreach("winequality-white.csv", :headers => true) do |csv|
    row = %w[0].concat(csv.to_hash.values)
    out << row
  end
end
