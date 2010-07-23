# encoding: UTF-8

module Examples
  module Counters
    class Counter < Examples::Counter

      # we need to store @counters_collection to know where to delete itself
      needs :collection
      attr_reader :collection

      # we could use ::Counter::Widget but this si much nore flexible
      class Widget < superclass.widget_class

        # here we overwrite actions and to add Remove link
        def actions
          cb.a('Remove').event(:click).action! { @collection.remove(self) }
        end
      end
    end
  end
end
