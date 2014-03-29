module Optimization
  module MIMIC
    java_import 'opt.prob.MIMIC'
    java_import 'opt.prob.GenericProbabilisticOptimizationProblem'
    java_import 'opt.prob.ProbabilisticOptimizationProblem'
    java_import 'dist.DiscreteDependencyTree'

    def mimic
      @mimic ||= MIMIC.new(200, 100, probabilistic_optimization_problem)
    end

    def probabilistic_optimization_problem
      @pop ||= GenericProbabilisticOptimizationProblem.new(eval_function, distribution, discrete_dependency_tree)
    end

    def discrete_dependency_tree
      @ddt ||= DiscreteDependencyTree.new(0.1, @ranges)
    end
  end
end