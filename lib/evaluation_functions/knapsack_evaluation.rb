class KnapsackEvaluation
  java_implements 'opt.EvaluationFunction'

  def initialize(weights, profits, capacity)
    @weights = weights
    @profits = profits
    @capacity = capacity
    @max_weight = weights.reduce(&:+)
  end

  def value(instance)
    data = instance.data
    volume = 0
    profit = 0
    
    data.each_with_index do |d, i|
      volume += @weights[i] * d
      profit += @profits[i] * d
    end

    if volume > @capacity
      1e-10 * (@max_weight - volume)
    else
      value
    end
  end
end
