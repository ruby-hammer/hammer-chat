# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hammer::Loader do
  pending
  #  describe "cba" do
  #    let(:files) do
  #      { 'a' => "class TA; TB; end",
  #        'b' => "class TB; TC; end",
  #        'c' => "class TC; end"
  #      }
  #    end
  #
  #    let(:loader) do
  #      Hammer::Loader.new(%w[a b c])
  #    end
  #
  #    before do
  #      loader.stub(:require).and_return {|file| eval files[file] }
  #    end
  #
  #    subject { lambda { loader.load! } }
  #
  #    it { should_not raise_error }
  #
  #    describe 'a loadable?' do
  #      it { loader.send(:loadable?, 'a').should == false }
  #    end
  #
  #    describe 'b loadable?' do
  #      it { loader.send(:loadable?, 'b').should == false }
  #    end
  #    describe 'c loadable?' do
  #      it { loader.send(:loadable?, 'c').should == true }
  #    end
  #
  #    describe 'classes are defined' do
  #      before { subject.call }
  #      it { lambda { TA; TB; TC; }.should_not raise_error }
  #      it { loader.instance_variable_get(:@loaded).should == ['c', 'b', 'a'] }
  #    end
  #  end

end
