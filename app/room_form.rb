module Chat
  class RoomForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:room, :record)
    on_submit { answer!(room) if room.valid? }

    class Widget < widget_class :Widget
      def content
        render Chat::Widget::Field.new :component => component, :value => :name, :label => 'Name: '

        div :class => %w{prefix_2 grid_2} do
          input :type => :submit, :value => "Add"
          link_to("Cancel").action { answer!(nil) }
        end
        div :class => 'clear'
      end
    end

  end
end