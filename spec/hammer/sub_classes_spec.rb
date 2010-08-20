# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hammer::SubClasses do
  before do
    @parent = Class.new
    @parent.send :include, Hammer::SubClasses
    @child = Class.new @parent
    @grandchild = Class.new @child
  end

  describe 'parent' do
    subject { @parent }
    its(:sub_classes) { should have(1).items }
    its(:sub_classes) { should == [@child] }
    its(:all_sub_classes) { should == [@child, @grandchild] }
  end

  describe 'child' do
    subject { @child }
    its(:sub_classes) { should == [@grandchild] }
    its(:all_sub_classes) { should == [@grandchild] }
  end
end