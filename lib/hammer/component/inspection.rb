module Hammer::Component::Inspection
  def inspector(obj, options = {})
    inspector_class(obj.class).new options.merge(:obj => obj)
  end

  private

  # @return [Class] suitable inspector class for +klass+
  # @param [Class] klass to inspect
  def inspector_class(klass)
    raise ArgumentError, klass.inspect unless klass && klass.kind_of?(Class)
    "Hammer::Component::Developer::Inspection::#{klass}".constantize
  rescue NameError
    inspector_class(klass.superclass)
  end
end