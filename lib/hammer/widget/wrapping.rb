module Hammer::Widget::Wrapping

  def self.included(base)
    base.class_inheritable_accessor :wrapper
    base.extend ClassMethods
  end

  module ClassMethods
    # @param [Symbol] element which will by used to wrap widget
    def wrap_in(element)
      self.wrapper = element
    end

    # @return [Symbol] element which will by used to wrap widget
    def wrapped_in
      self.wrapper
    end

    # @return [String] class name transformed into CSS class, used by #content_with_wrapper
    def css_class
      @css_class ||= self.to_s.to_s.underscore.gsub '/', '-'
    end
  end

  # Wraps widget with element set by .wrap_in. Method is called automatically use #content.
  def content_with_wrapper
    if self.class.wrapped_in
      send self.class.wrapped_in, wrapper_options do
        content
      end
    else
      content
    end
  end

  # calls #content_with_wrapper in place of #content
  def to_html(options = {})
    super options.merge(:content_method_name => :content_with_wrapper) {|_,old,_| old }
  end

  protected

  # @return [Hash] options passed to wrapping element, intended for overwriting
  def wrapper_options
    {:class => self.class.css_class}
  end

  # calls #content_with_wrapper in place of #content
  def _render_via(parent, options = {}, &block)
    super parent, options.merge(:content_method_name => :content_with_wrapper) {|_,old,_| old }, &block
  end

end