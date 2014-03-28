require 'csv'
require 'sequel'

DB = Sequel.sqlite('./stock_data.db')
DB.create_table? :stock_data do
  primary_key :id
  String :ticker, :index => true
  DateTime :date
  Decimal :open
  Decimal :high
  Decimal :low
  Decimal :close
  Integer :volume
end


class StockData < Sequel::Model
  set_dataset DB[:stock_data]

  def self.consume(file)
    truncate
    CSV.foreach(file) do |row|
      date, ticker, open, high, low, close, volume = row
      create({
        :date => date,
        :ticker => ticker,
        :open => open,
        :high => high,
        :low => low,
        :close => close,
        :volume => volume
      })
    end
  end
end
