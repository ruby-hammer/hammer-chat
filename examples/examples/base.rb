# encoding: UTF-8
module Examples
  class Base < Hammer::Component::Base

    attr_reader :example

    class Widget < Hammer::Widget::Base
      def content
        strong 'Examples:'
        ul do
          li { a "Counters", :callback => on(:click) { @example = new Examples::Counters::Base } }
          li { a "#ask", :callback => on(:click) { @example = new Examples::Ask::Base } }
          li { a "form", :callback => on(:click) {
              @example = new Examples::Form::Base, :record => Struct.new("Data", :name, :sex, :description).new
            } }
          li { a "none", :callback => on(:click) { @example = nil } }
        end
        hr

        render example if example
      end
    end

  end
end
