class PeaksProblem
  java_import 'opt.DiscreteChangeOneNeighbor'
  java_import 'dist.DiscreteUniformDistribution'
  java_import 'opt.example.FourPeaksEvaluationFunction'
  java_import 'opt.ga.SingleCrossOver'

  include OptimizationAlgorithms

  def initialize(n = 60, t = n / 10)
    @t = t
    @n = n
    @ranges = Array.new(@n) { 2 }.to_java(Java::int)
  end

  def train_all!
    evaluate(randomized_hill_climber, 200000)
    evaluate(genetic_algorithm, 1000)
    evaluate(simulated_annealer, 200000)
    evaluate(mimic, 1000)
  end

  def eval_function
    @eval_function ||= FourPeaksEvaluationFunction.new(@t)
  end

  def distribution
    @dist ||= DiscreteUniformDistribution.new(@ranges)
  end

  def neighbor_function
    @neigh ||= DiscreteChangeOneNeighbor.new(@ranges)
  end

  def mutation_function
    @mf ||= DiscreteChangeOneMutation.new(@ranges)
  end

  def crossover_function
    @cf ||= SingleCrossOver.new
  end
end