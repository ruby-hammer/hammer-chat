module Hammer::SubClasses
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def inherited(sub_class)
      super
      _sub_classes << sub_class
    end

    def sub_classes
      _sub_classes
    end

    def all_sub_classes
      sub_classes.inject([]) do |sub_classes, klass|
        sub_classes.push klass, *klass.sub_classes
      end
    end

    private

    def _sub_classes
      @_sub_classes ||= []
    end
  end
end