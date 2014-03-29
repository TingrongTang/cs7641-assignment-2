module Optimization
  module Evaluation
    java_import 'shared.FixedIterationTrainer'

    def evaluate(algo, iterations)
      puts "Evaluating #{algo} with iterations #{iterations}"
      walltime = Benchmark.measure do
        fit = FixedIterationTrainer.new(algo, iterations)
        fit.train
      end
      puts walltime
      puts eval_function.value(algo.optimal)
    end
  end
end