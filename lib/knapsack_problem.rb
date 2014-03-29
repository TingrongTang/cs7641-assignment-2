require 'benchmark'
require './lib/optimization_algorithms'
class KnapsackProblem
  java_import 'opt.DiscreteChangeOneNeighbor'
  java_import 'dist.DiscreteUniformDistribution'
  java_import 'opt.example.KnapsackEvaluationFunction'

  include OptimizationAlgorithms

  def initialize(items = 40, copies = 4, max_weight = 50, max_volume = 50)
    @num_items = items
    @copies_each = copies
    @max_weight = max_weight
    @max_volume = max_volume
    @knapsack_volume = @max_volume * @num_items * @copies_each * 0.4

    @copies = Array.new(@num_items) { @copies_each }.to_java(Java::int)
    @weights = Array.new(@num_items) { rand * @max_weight }.to_java(Java::double)
    @volumes = Array.new(@num_items) { rand * @max_volume }.to_java(Java::double)
    @ranges = Array.new(@num_items) { @copies_each + 1 }.to_java(Java::int)
  end

  def train_all!
    evaluate(randomized_hill_climber, 200000)
    evaluate(genetic_algorithm, 1000)
    evaluate(simulated_annealer, 200000)
    evaluate(mimic, 1000)
  end

  def eval_function
    @eval_function ||= KnapsackEvaluationFunction.new(@weights, @volumes, @knapsack_volume.to_java(Java::double), @copies)
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