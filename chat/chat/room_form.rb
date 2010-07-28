module Chat
  class RoomForm < Hammer::Component::FormPart

    alias_method(:room, :record)

    class Widget < Hammer::Component::FormPart::Widget
      wrap_in(:span)
      def content
        widget Hammer::Widget::FormPart::Input, :value => :name, :options =>
            { :class => %w[ui-widget-content ui-corner-all] }
        a "Add", :callback => on(:click, component.form) {
            if room.valid?
              answer!(room)
            end
          }
        a "Cansel", :callback => on(:click) { answer!(nil) }
      end
    end

  end
end