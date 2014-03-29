Dir['./lib/optimization/*.rb'].each {|_| require _ }

module OptimizationAlgorithms
  include Optimization::MIMIC
  include Optimization::Evaluation
  include Optimization::RandomizedHillClimbing
  include Optimization::GeneticAlgorithm
  include Optimization::SimulatedAnnealing
end