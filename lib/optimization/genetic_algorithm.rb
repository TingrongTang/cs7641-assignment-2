module Optimization
  module GeneticAlgorithm
    java_import 'opt.ga.GenericGeneticAlgorithmProblem'
    java_import 'opt.ga.DiscreteChangeOneMutation'
    java_import 'opt.ga.UniformCrossOver'
    java_import 'opt.ga.StandardGeneticAlgorithm'

    def genetic_algorithm
      @gap ||= begin
        gap = GenericGeneticAlgorithmProblem.new(eval_function, distribution, mutation_function, crossover_function)
        StandardGeneticAlgorithm.new(200, 150, 25, gap)
      end
    end
  end
end