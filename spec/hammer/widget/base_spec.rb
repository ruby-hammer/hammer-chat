# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hammer::Widget::Base do
  include HammerMocks

  module Foo
    class FooWidget < Hammer::Component::Base::Widget
      wrap_in :span
    end
    class BooWidget < Hammer::Widget::Base
    end
    class DooWidget < Hammer::Widget::Base
      wrap_in :span
    end
  end

  describe Foo::BooWidget, "#to_html", 'when wrap_in(nil)' do
    subject { (@widget = Foo::BooWidget.new(:component => component_mock)).to_html }
    it { should == "" }
  end

  describe Foo::FooWidget do
    describe ".css_class" do
      subject { Foo::FooWidget.css_class }
      it { should == 'foo-foo_widget' }
    end

    describe "wrap_in", "#to_html" do
      subject { (@widget = Foo::FooWidget.new(:component => component_mock)).to_html }
      it { should ==
            "<span class=\"#{Foo::FooWidget.css_class} component\" id=\"#{@widget.component.object_id}\"></span>" }

      describe 'when subwidget' do
        subject do
          (@widget = Foo::FooWidget.new(:component => component_mock) do |w|
            w.widget Foo::DooWidget
          end).to_html
        end
        it { should == "<span class=\"#{Foo::FooWidget.css_class} component\" id=\"#{@widget.component.object_id}\">" +
              "<span class=\"#{Foo::DooWidget.css_class}\"></span></span>"}
      end
    end

    describe '.wrapped_in' do
      subject { Foo::FooWidget.wrapped_in }
      it { should == :span}
    end

    describe '#render' do
      describe "(a_widget)" do
        subject do
          (@widget = Foo::FooWidget.new(:component => component_mock) do |w|
            w.render @subwidget = Foo::DooWidget.new(:component => component_mock)
          end).to_html
        end
        it { should == "<span class=\"#{Foo::FooWidget.css_class} component\" id=\"#{@widget.component.object_id}\">" +
              "<span class=\"#{Foo::DooWidget.css_class}\"></span></span>"}
      end

      describe "(a_object_responding_to_widget)" do

        class ObjectWithWidget
          def widget
            @number = 3
            Erector.inline(:obj => @number) { text @obj }
          end
        end

        subject do
          (@widget = Foo::FooWidget.new(:component => component_mock) do |w|
            w.render @obj = ObjectWithWidget.new
          end).to_html
        end
        it { should == "<span class=\"#{Foo::FooWidget.css_class} component\"" +
              " id=\"#{@widget.component.object_id}\">3</span>" }
      end

      describe "(other)" do
        subject { lambda { Foo::FooWidget.new(:component => component_mock) {|w| w.render Object.new }.to_html} }
        it { should raise_error(ArgumentError) }
      end
    end
  end
end

