# encoding: UTF-8
module Examples
  module Ask
    class Counter < Examples::Counter

      class Widget < superclass.widget_class

        # adds links to answer the number (counter) or
        # to answer nothing.
        # Everything else is as we need.
        def actions
          a 'Add number', :callback => on(:click) { answer!(counter) }
          a 'Cancel', :callback => on(:click) { answer! }
        end
      end
    end

  end
end
