# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'benchmark'
require 'ruby-prof'

describe 'Rendering Benchmar' do
  include HammerMocks

  before do
    @context = Hammer::Core::Context.new('id', container_mock, 'devel')
    RubyProf.start
  end

  it do
    puts(Benchmark.measure do
        5_000.times { $out = @context.to_html }
      end)
    puts $out
  end

  #  it do
  #    n = 100000
  #    Benchmark.bm(7) do |x|
  #      x.report("string") { str = ''; n.times { str << 'abc' }; str }
  #      x.report("array") { arr = []; n.times { arr << 'abc'}; arr.join }
  #      x.report("stringIO") { str = StringIO.new; n.times { str << 'abc'}; str.string }
  #    end
  #  end

  after do
    result = RubyProf.stop
    File.open('profile.html', 'w') do |f|
      RubyProf::GraphHtmlPrinter.new(result).print(f)
    end

    File.open('profile.txt', 'w') do |f|
      RubyProf::FlatPrinter.new(result).print(f)
    end
  end

  # callbacks 5_000
  # Rendering Benchmar
  #   9.210000   5.160000  14.370000 ( 14.442743)


end
