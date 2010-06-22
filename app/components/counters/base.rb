module Counters
  class Base < Isy::Component::Base

    attr_reader :counters

    # defines the state after new instance is created
    def initial_state
      @counters = [ new(Counter, self) ]
    end

    # adds new counter
    def add
      counters << new(Counter, self)
    end

    # removes a +counter+
    def remove(counter)
      counters.delete(counter)
    end

    # params for widget that is used to render this component
    def widget_args
      [counters]
    end

    class Widget < Isy::Widget::Collection
      def after
        link_to("Add counter") { add }
      end
    end

  end
end