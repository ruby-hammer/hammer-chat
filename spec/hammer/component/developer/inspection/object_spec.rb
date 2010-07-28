require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

describe Hammer::Component::Developer::Inspection::Object do

  include HammerMocks

  class InspectTest
    @array = [1]
  end

  def subject
    inspector
  end

  def self.subject(&block)
    define_method :subject, &block
  end

  let(:inspector) do
    Hammer::Component::Developer::Inspection::Object.new(:context => context_mock, :obj => InspectTest)
  end

  before do
    Fiber.current.stub(:hammer_context).and_return context_mock
  end

  describe '#obj' do
    subject { super().obj }
    it { should eql(InspectTest) }
  end

  describe '#components' do
    subject { super().components }
    it { should_not be_nil }
    it { should be_empty }
    it { should be_kind_of(Array) }
  end

  describe 'when unpacked' do
    before do
      method = inspector.method(:unpack)
      inspector.should_receive(:unpack).and_return { method.call }
      inspector.toggle!
    end

    it { subject.instance_variable_get(:@packed).should == false }
    it { subject.components.should_not be_empty }

    describe 'when packed' do
      before do
        method = inspector.method(:pack)
        inspector.should_receive(:pack).and_return { method.call }
        inspector.toggle!
      end

      it { subject.instance_variable_get(:@packed).should == true }
      it { subject.components.should be_empty }
    end

    describe '#components' do
      subject { super().components }
      
      it { should_not be_empty }
      it { should be_kind_of(Array) }
      it { should have(1).items }

      describe '#first' do
        subject { super().first }
        it { should be_kind_of(Hammer::Component::Developer::Inspection::Hash) }

        describe '#label' do
          subject { super().label }
          it { should == 'Instance variables' }
        end

        describe '#obj' do
          subject { super().obj }
          it { should be_kind_of ::Hash }

          describe '#keys' do
            subject { super().keys }
            it { should include(:@array) }
          end
        end
      end

    end

  end


end

