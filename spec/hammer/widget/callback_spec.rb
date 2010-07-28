# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'benchmark'

describe Hammer::Widget::Callback do
  include HammerMocks

  let(:widget) { Hammer::Widget::Base.new(:component => component_mock) }

  describe '#simple_json' do
    it { widget.send(:simple_json, :action => "asd").should == '{"action":"asd"}' }
    it { widget.send(:simple_json, :form => 12).should == '{"form":12}' }
    it { widget.send(:simple_json, :action => "asd", :form => 12).should == '{"action":"asd","form":12}' }
  end

  describe 'output' do
    before { context_mock.stub(:register_action).and_return('id') }
    subject do
      @widget = Hammer::Widget::Base.new(:component => component_mock) do |w|
        w.a "label", :class => 'a', :callback => w.on(:click) {}
        w.span(:class => 'b', :callback => w.on(:click, 123)) { w.text 'content'}
      end
      @widget.to_html
    end

    it { should == "<a class=\"a\" data-callback-click=\"{&quot;action&quot;:&quot;id&quot;}\" href=\"#\">label</a>" +
          "<span class=\"b\" data-callback-click=\"{&quot;form&quot;:123}\">content</span>" }
    
  end

end