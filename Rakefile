require 'rubygems'
require 'rake'

begin
  require 'yard'

  options = %w[--protected --private --verbose]
  output = "--output-dir=./yardoc/"
  input = %w[./app/**/*.rb]
  
  YARD::Rake::YardocTask.new(:yard) do |yardoc|
    yardoc.options.push(*options) << output
    yardoc.files.push(*input)
    yardoc.options << '--incremental' if File.exist? './.yardoc'
  end

  namespace :yard do
    YARD::Rake::YardocTask.new(:regenerate) do |yardoc|
      yardoc.options.push(*options) << output
      yardoc.files.push(*input)
    end
  end

rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
