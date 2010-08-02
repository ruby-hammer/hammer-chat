# encoding: UTF-8
module Examples
  class Base < Hammer::Component::Base

    attr_reader :example

    class Widget < superclass::Widget
      def content
        strong 'Examples:'
        ul do
          li { link_to("Counters").action { @example = Examples::Counters::Base.new } }
          li { link_to("#ask").action { @example = Examples::Ask::Base.new } }
          li { link_to("Form").action {
              @example = Examples::Form::Base.new \
                  :record => Struct.new("Data", :name, :sex, :password, :hidden, :description).new
            } }
          li { link_to('none').action { @example = nil } }
        end
        hr

        render example if example
      end
    end

  end
end
