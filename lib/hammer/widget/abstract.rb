# encoding: UTF-8

# Abstract class of all widgets
class Hammer::Widget::Abstract < Erector::Widget

  # try to obtain widget and render it with Erector::Widget#widget
  # @param [Erector::Widget, #widget] obj to render
  def render(obj)
    widget begin
      if obj.kind_of?(Erector::Widget)
        obj
      elsif obj.respond_to?(:widget)
        obj.widget
      else
        raise ArgumentError, obj.inspect
      end
    end
  end


  private

  # @return [String] class name transformed into CSS class, used by #content_with_wrapper
  def self.css_class
    @css_class ||= self.to_s.to_s.underscore.gsub '/', '-'
  end
      
end

