module Hammer::Component::Rendering

  def self.included(base)
    base.class_eval do
      extend ClassMethods
      class_inheritable_accessor :_widget_class, :instance_writer => false, :instance_reader => false
      needs :widget_class => nil
    end
  end

  module ClassMethods
    # @return [Class] which is used to insatiate widget
    # @param [Class] klass when passed sets default widget_class to +klass+
    def widget_class(klass = nil)
      if klass
        raise ArgumentError, klass.inspect unless klass.kind_of?(Class) && klass < Hammer::Widget::Base
        self._widget_class = klass
      else
        _widget_class ||
            (const_defined?(:Widget) && const_get(:Widget) ) ||
            superclass.widget_class ||
            raise(Hammer::Component::MissingWidgetClass, "for #{self}")
      end
    end
  end

  # @return [Widget::Component] return instantiated widget or creates one
  def widget
    @widget ||= create_widget
  end

  # @return [String] html
  def to_html
    widget.to_html
  end

  # @return [Class] which is used to insatiate widget
  def widget_class
    @widget_class || self.class.widget_class
  end

  protected

  # default behavior, can by overwritten
  # @return [Hammer::Widget::Base]
  def create_widget
    widget_class.new(widget_assigns)
  end

  # always pass component to widget, can be extended by overwritten 
  def widget_assigns
    {:component => self}
  end

end