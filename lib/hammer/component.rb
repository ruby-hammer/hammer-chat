module Hammer::Component
  class ComponentException < StandardError; end
  class MissingWidgetClass < ComponentException; end

  def self.all
    Hammer::Component::Base.all_sub_classes
  end
end