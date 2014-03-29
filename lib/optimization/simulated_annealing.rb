module Optimization
  module SimulatedAnnealing
    include Optimization::HillClimbing
    java_import 'opt.SimulatedAnnealing'

    def simulated_annealer
      @sa ||= SimulatedAnnealing.new(100, 0.95, hill_climbing_problem)
    end
  end
end