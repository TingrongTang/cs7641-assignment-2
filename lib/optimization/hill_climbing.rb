module Optimization
  module HillClimbing
    java_import 'opt.GenericHillClimbingProblem'

    def hill_climbing_problem
      @hcp ||= GenericHillClimbingProblem.new(eval_function, distribution, neighbor_function)
    end
  end
end
