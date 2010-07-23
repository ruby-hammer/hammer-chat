module Hammer::Component::Developer::Inspection
  class Hash < Object
    def unpack
      @components = obj.to_a.flatten(1).map do |value|
        inspector value
      end
    end
  end
end
