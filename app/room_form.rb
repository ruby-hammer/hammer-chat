module Chat
  class RoomForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:room, :record)
    on_submit { answer!(room) if room.valid? }

    class Widget < widget_class :Widget
      def wrapper_classes
        super << 'form'
      end

      def content
        render Hammer::Widget::Form::Field.new :component => component, :value => :name

        input :type => :submit, :value => "Add"
        link_to("Cancel").action { answer!(nil) }
      end
    end

  end
end