require 'csv'
class CSVFile
  java_import 'shared.DataSet'
  java_import 'shared.Instance'

  attr_reader :data_set, :labels
  def initialize(file)
    instances = []

    CSV.foreach(file, :headers => true) do |csv|
      instances << Instance.new(csv.map {|k,v| v.to_f }.to_java(Java::double))
    end

    @data_set = DataSet.new(instances.to_java(Instance))
    @labels = File.open(file, 'r') {|f| f.readline }.split(",")
  end
end