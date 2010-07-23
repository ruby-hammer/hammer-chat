module Hammer::Component
  class ComponentException < StandardError; end
  class MissingWidgetClass < ComponentException; end
end