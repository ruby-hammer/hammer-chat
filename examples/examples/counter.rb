# encoding: UTF-8
module Examples
  class Counter < Hammer::Component::Base

    attr_reader :counter
    needs :counter => 0

    class Widget < Hammer::Widget::Base
      def content
        h3 'Counter'
        p do
          text("Value is #{counter} ")
          a 'Increase', :callback => on(:click) { @counter += 1 }
          a 'Decrease', :callback => on(:click) { @counter -= 1 }
          actions
        end
      end

      def actions
      end
    end

  end
end
