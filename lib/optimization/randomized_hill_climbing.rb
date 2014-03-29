module Optimization
  module RandomizedHillClimbing
    java_import 'opt.RandomizedHillClimbing'

    def randomized_hill_climber
      @rhcp ||= RandomizedHillClimbing.new(hill_climbing_problem)
    end
  end
end