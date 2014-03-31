class NeuralNetworkProblem
  java_import 'shared.Instance'
  java_import 'func.nn.feedfwd.FeedForwardNeuralNetworkFactory'
  java_import 'shared.Instance'
  java_import 'shared.SumOfSquaresError'
  java_import 'shared.DataSet'
  java_import 'opt.example.NeuralNetworkOptimizationProblem'
  java_import 'shared.tester.AccuracyTestMetric'
  java_import 'shared.tester.ConfusionMatrixTestMetric'

  include Optimization::RandomizedHillClimbing
  include Optimization::GeneticAlgorithm
  include Optimization::SimulatedAnnealing
  include Optimization::Evaluation

  def initialize(instances = [])
    back_prop_factory = FeedForwardNeuralNetworkFactory.new

    if instances.empty?
      @instances = []
      CSV.foreach('./data/agaricus-lepiota/agaricus-lepiota-numeric.csv', :headers => true) do |row|
        points = row.to_hash.values[1..-1].map(&:to_f).to_java(Java::double)
        output_layer = [row['class_p'].to_i]

        instance = Instance.new(points)
        instance.label = Instance.new(output_layer.to_java(Java::double))
        @instances << instance
      end
    else
      @instances = instances
    end

    @data_set = DataSet.new(@instances.to_java(Instance))

    hidden_layer = (2 * (@data_set.get(1).data.size + 1)) / 3

    @network = back_prop_factory.create_classification_network([@data_set.get(1).data.size, hidden_layer, 1].to_java(Java::int))

    @network_problem = NeuralNetworkOptimizationProblem.new(@data_set, @network, SumOfSquaresError.new)
  end

  def train_all!
    evaluate(randomized_hill_climber, 1000)
    evaluate(genetic_algorithm, 1000)
    evaluate(simulated_annealer, 1000)
  end

  def evaluate(algo, iterations)
    puts "Evaluating #{algo} with iterations #{iterations}"
    walltime = Benchmark.measure do
      fit = FixedIterationTrainer.new(algo, iterations)
      fit.train
    end

    @network.weights = algo.optimal.data

    accuracy = AccuracyTestMetric.new
    confusion_matrix = ConfusionMatrixTestMetric.new([0,1].to_java(Java::int))
    tester = NeuralNetworkTester.new(@network, accuracy, confusion_matrix)
    tester.test(@instances)

    accuracy.print_results
    confusion_matrix.print_results

    puts walltime
  end

  def randomized_hill_climber
    @rhc ||= RandomizedHillClimbing.new(@network_problem)
  end

  def genetic_algorithm
    @gap ||= StandardGeneticAlgorithm.new(10, 2, 2, @network_problem)
  end

  def simulated_annealer
    @sa ||= SimulatedAnnealing.new(10, 0.999, @network_problem)
  end
end