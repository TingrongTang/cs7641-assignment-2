task :console do
  require 'irb'
  require 'irb/completion'
  require 'java'
  require 'vendor/ABAGAIL.jar'

  def reload!
    Dir['./lib/**/*.rb'].each {|_| load _ }
  end

  reload!
  ARGV.clear
  IRB.start
end
