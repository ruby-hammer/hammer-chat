# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hammer::Widget::JQuery::MethodStack do

  tests = {
    'jquery.jq!' => "jQuery.jQuery()",
    'a.a!' => "a.a()",
    "a('a')" => "a(\"a\")",
    'a(1, nil)' => "a(1,null)",
    'a(1 => "a", :b => [1,2])' => "a({\"1\":\"a\",\"b\":[1,2]})",
  }

  tests.each do |ruby, jquery|
    describe ruby do
      it { Hammer::Widget::JQuery::MethodStack.new.instance_eval("self.#{ruby}").to_js.should == jquery }
    end
  end
end

describe Hammer::Widget::JQuery::Generator do
  include HammerMocks

  tests = {
    'a.c!; b!;' => "a.c();b();",
    'a.c(b!);' => "a.c(b());",
    'a.c(b(c));' => "a.c(b(c));",
    'b(a!, a); a.c(b(c));' => "b(a(),a);a.c(b(c));",
    'b(a!, 1, "ab"); a.c(b(c));' => "b(a(),1,\"ab\");a.c(b(c));",
    'a.c!; b(function {b!.c!})' => 'a.c();b(function() {b().c();});',
    'b(function(a, 1.2) {b!.c!})' => 'b(function(a,1.2) {b().c();});'
  }

  tests.each do |ruby, jquery|
    describe ruby do
      it { Hammer::Widget::JQuery::Generator.new(widget_mock) { eval ruby }.to_js.should == jquery }
    end
  end

  #  describe 'a.c!; b!;' do
  #    it { Hammer::Widget::JQuery::Generator.new { a.c!; b! }.to_js.should == 'a.c();b();' }
  #  end
  #
  #  describe 'a.c(b!);' do
  #    it { Hammer::Widget::JQuery::Generator.new { a.c(b!); }.to_js.should == 'a.c(b());' }
  #  end

end

#describe Hammer::Widget::JQuery::Function do
#  describe 'a.c!; b(function {b!.c!})' do
#    it do
#      Hammer::Widget::JQuery::Generator.
#          new { a.c!; b(function {b!.c!}) }.to_js.should == 'a.c();b(function() {b().c();});'
#    end
#  end
#end
