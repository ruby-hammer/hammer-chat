# encoding: UTF-8
module Examples
  class Counter < Hammer::Component::Base

    attr_reader :counter
    changing { attr_writer :counter }
    needs :counter => 0

    define_widget do
      def content
        h3 'Counter'
        p do
          text("Value is #{counter} ")
          link_to('Increase').action { self.counter += 1 }
          link_to('Decrease').action { self.counter -= 1 }
          actions
        end
      end

      def actions
      end
    end

  end
end
