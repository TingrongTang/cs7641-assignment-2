# http://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/knapsack_01.html
(1..8).each do |i|
  %w[c w p s].each do |type|
    `wget http://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/p0#{i}_#{type}.txt`
  end
end
