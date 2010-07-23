# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hammer::Component::FormPart do
  include HammerMocks

  class TestForm < Hammer::Component::FormPart
    class Widget < Hammer::Component::FormPart::Widget
      wrap_in :div
    end
  end

  let(:test_form) do
    TestForm.new(
      :context => context_mock,
      :form => @form_id = Object.new,
      :record => @struct = Struct.new(:record, :value, :name).new
    )
  end

  describe '@record' do
    it { test_form.record.should be_present }
    it { test_form.record.should be_kind_of(Struct) }
    it { test_form.record.should == @struct }
  end

  describe '@form' do
    it { test_form.form.should == @form_id }
  end

  describe '#set_value and #value' do
    describe "('value')" do
      before { test_form.set_value 'value' }
      subject { test_form.value }
      it { should == 'value' }
    end

    describe "(:name, 'name')" do
      before { test_form.set_value :name, 'name' }
      subject { test_form.value :name }
      it { should == 'name' }
    end
  end

  describe '#to_html' do
    subject { test_form.to_html }
    it { should match(/data-form-id="#{test_form.form.object_id}"/) }
    it { should match(/data-component-id="#{test_form.object_id}"/) }
  end

end