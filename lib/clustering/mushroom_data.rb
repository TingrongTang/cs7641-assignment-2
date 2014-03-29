class MushroomData < ClusteringProblem
  def initialize
    super
    @file = './data/agaricus-lepiota/agaricus-lepiota-numeric.csv'
    @csv_file = CSVFile.new(@file)
    @data_set = @csv_file.data_set
    @k = 2
  end
end