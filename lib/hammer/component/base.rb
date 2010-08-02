# encoding: UTF-8

module Hammer::Component

  # represents component of a page. The basic logic building blocks of a application.
  class Base < Abstract
    include Rendering
    include Answer
    include Passing
    include Inspection

    class Widget < Hammer::Widget::Base
      wrap_in :div

      def wrapper_options
        super.merge :id => component.object_id, :class => 'component' do |key, old, new|
          [*old] + [*new] if key == :class
        end
      end

    end
  end
end
