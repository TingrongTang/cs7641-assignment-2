require 'pp'
class ClusteringProblem
  java_import 'func.KMeansClusterer'
  java_import 'func.EMClusterer'
  java_import 'shared.filt.IndependentComponentAnalysis'
  java_import 'shared.filt.PrincipalComponentAnalysis'
  java_import 'shared.filt.InsignificantComponentAnalysis'
  java_import 'shared.filt.RandomizedProjectionFilter'

  attr_reader :data_set

  def run_experiments
    kmeans
    em_clustering

    [:random_projections, :pca, :insignificant_ca, :ica].reverse.each do |filterer|
      puts filterer
      experiment(filterer) { kmeans }
      experiment(filterer) { em_clustering }
    end
  end

  def experiment(filterer, &block)
    @filterer = filterer.to_s
    filtering_algo = public_send(filterer)
    filtering_algo.filter(@data_set)
    block.call
    filtering_algo.reverse(@data_set)
  end

  def kmeans
    kmeans = KMeansClusterer.new(@k)
    bm = Benchmark.measure { kmeans.estimate(@data_set) }

    puts "K = #{@k}"
    labels = @csv_file.labels

    File.open("./data/supporting/#{self.class.to_s}_kmeans_#{@filterer}.txt", "wb") do |f|
      kmeans.cluster_centers.each do |cc|
        values = []
        cc.data.size.times do |i|
          values << cc.data.get(i)
        end
        f.write(Hash[labels.zip(values)].select {|k,v| v && v.abs > 0.01 })
        f.write("\n")
      end

      f.write("\n")
      f.write(bm)
    end
  end

  def em_clustering
    em_clustering = EMClusterer.new(@k, 1e-6, 1000)
    bm = Benchmark.measure { em_clustering.estimate(@data_set) }
    File.open("./data/supporting/#{self.class.to_s}_em_#{@filterer}.txt", "wb") do |f|
      f.write(em_clustering.to_s)
      f.write("\n")
      f.write(bm)
    end
  end

  def compare_projections(first, second)

    ica.filter(@data_set)
    ica.reverse(@data_set)

    labels.each_with_index do |lab, i|
      if first_point.get(i).zero? == second_point.get(i).zero?
        next
      end

      vector = [first_point, second_point, pca_first, pca_second, ica_first, ica_second, rand_first, rand_second, insig_first, insig_second].map do |proj|
        "%0.2f" % proj.get(i)
      end

      puts "#{lab} & #{vector.join(' & ')} \\\\ \\hline"
    end
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
