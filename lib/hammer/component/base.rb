# encoding: UTF-8

module Hammer::Component

  # represents component of a page. The basic logic building blocks of a application.
  class Base < Abstract
    include Rendering
    include Traversing
    include State
    include Answering
    include Passing
    include Inspection

    define_widget :Widget, Hammer::Widget::Base do
      wrap_in :div

      def wrapper_options
        super.merge :id => component.object_id
      end

      def wrapper_classes
        super << 'component'
      end

    end
  end
end
