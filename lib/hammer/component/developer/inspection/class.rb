module Hammer::Component::Developer::Inspection
  class Class < Module
    def unpack
      super << inspector(obj.superclass, :label => 'superclass')
    end
  end
end
