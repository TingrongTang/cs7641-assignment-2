class NeuralNetworkTester
  java_implements 'shared.tester.Tester'
  java_import 'shared.Instance'
  java_import 'shared.reader.DataSetLabelBinarySeperator'

  def initialize(network, *metrics)
    @network = network
    @metrics = metrics
  end

  def test(instances)
    instances.each do |instance|
      @network.input_values = instance.data
      @network.run

      expected = instance.label

      actual_vector = []
      @network.output_values.size.times do |i|
        actual_vector[i] = @network.output_values.get(i).round
      end

      actual = Instance.new(actual_vector.to_java(Java::double))

      expected_one = DataSetLabelBinarySeperator.combine_labels(expected)
      actual_one = DataSetLabelBinarySeperator.combine_labels(actual)

      @metrics.each do |metric|
        metric.add_result(expected_one, actual_one)
      end
    end
  end
end