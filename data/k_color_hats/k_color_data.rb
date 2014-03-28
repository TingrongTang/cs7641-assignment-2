require 'csv'

class KColorHat
  def initialize(agents, colors)
    @agents = agents
    @colors = colors
  end

  def save_data!
    CSV.open("#{@agents}_#{@colors}.csv", "wb") do |csv|
      csv << %w[agent_number hat_number]
      @agents.times do |i|
        csv << [i, rand(@colors)]
      end
    end
  end

  def self.calculate_experiment(agents, colors)
    new(agents, colors).save_data!
  end

  def self.calculate_experiments!
    (1..5).each do |exp|
      agents = 10 ** exp

      (1..5).each do |bucket|
        colors = (bucket - 1) * ((agents - 2) / 4) + 2
        calculate_experiment(agents, colors)
      end
    end
  end
end
