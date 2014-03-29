require './lib/optimization_algorithms'
class CountOnesProblem
  java_import 'opt.example.CountOnesEvaluationFunction'
  java_import 'opt.DiscreteChangeOneNeighbor'
  java_import 'dist.DiscreteUniformDistribution'
  include OptimizationAlgorithms

  def initialize(buckets = 80)
    @ranges = Array.new(buckets) { 2 }.to_java(Java::int)
  end

  def train_all!
    evaluate(randomized_hill_climber, 200)
    evaluate(genetic_algorithm, 300)
    evaluate(simulated_annealer, 200)
    evaluate(mimic, 100)
  end

  def eval_function
    @eval_function ||= CountOnesEvaluationFunction.new
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
    @cf ||= UniformCrossOver.new
  end
end