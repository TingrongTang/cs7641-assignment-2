class ClusteringProblem
  java_import 'func.KMeansClusterer'
  java_import 'func.EMClusterer'
  java_import 'shared.filt.IndependentComponentAnalysis'
  java_import 'shared.filt.PrincipalComponentAnalysis'
  java_import 'shared.filt.InsignificantComponentAnalysis'
  java_import 'shared.filt.RandomizedProjectionFilter'

  attr_reader :data_set

  def run_experiments
    Benchmark.bm do |x|
      x.report("KMeans Without Filtering") do
        kmeans
      end

      x.report("EMClustering Without Filtering") do
        em_clustering
      end

      [:random_projections, :pca, :insignificant_ca, :ica].each do |filterer|
        x.report("KMeans with #{filterer}") do
          experiment(filterer) { kmeans }
          experiment(filterer) { em_clustering }
        end
      end
    end
  end

  def experiment(filterer, &block)
    puts "Filtering using #{filterer}"
    filtering_algo = public_send(filterer)
    filtering_algo.filter(@data_set)
    block.call
    filtering_algo.reverse(@data_set)
  end

  def kmeans
    kmeans = KMeansClusterer.new(@k)
    kmeans.estimate(@data_set)

    puts "K = #{@k}"
    labels = @csv_file.labels

    kmeans.cluster_centers.each do |cc|
      values = []
      cc.data.size.times do |i|
        values << cc.data.get(i)
      end
      pp(Hash[labels.zip(values)].select {|k,v| v.abs > 0.01 })
    end

  end

  def em_clustering
    em_clustering = EMClusterer.new(@k, 1e-6, 1000)
    em_clustering.estimate(@data_set)
    puts em_clustering.to_s
  end

  def ica
    @ica ||= IndependentComponentAnalysis.new(@data_set)
  end

  def pca
    @pca ||= PrincipalComponentAnalysis.new(@data_set)
  end

  def random_projections(keep = 0.6)
    in_amount = @data_set.get(1).data.size
    out_amount = (in_amount * keep).floor
    @rp ||= RandomizedProjectionFilter.new(in_amount, out_amount)
  end

  def insignificant_ca
    @insig ||= InsignificantComponentAnalysis.new(@data_set)
  end
end