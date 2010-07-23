# encoding: UTF-8
module Examples
  module Counters
    class Base < Hammer::Component::Base

      attr_reader :counters
      alias_method :collection, :counters

      # defines the state after new instance is created
      after_initialize { @counters = []; add }

      # adds new counter
      def add
        counters << new(Examples::Counters::Counter, :collection => self)
      end

      # removes a +counter+
      def remove(counter)
        counters.delete(counter)
      end

      class Widget < Hammer::Widget::Collection
        def after
          cb.a('Add counter').event(:click).action! { add }
        end
      end

    end
  end
end
