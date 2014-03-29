class WineData < ClusteringProblem
  def initialize
    super
    @file = './data/wine_data/winequality.csv'
    @csv_file = CSVFile.new(@file)
    @data_set = @csv_file.data_set
    @k = 10
  end
end