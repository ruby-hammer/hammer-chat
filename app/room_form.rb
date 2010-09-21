module Chat
  class InlineField < Hammer::Widget::Form::Field
    wrap_in :span
  end

  class RoomForm < Hammer::Component::Base
    include Hammer::Component::Form
    alias_method(:room, :record)
    on_submit do
      room.user = shared.user
      answer!(room) if room.valid?
    end

    class Widget < widget_class :Widget
      css { input('[type=text]') { width '80px' } }
      def content
        render InlineField.new :component => component, :value => :name
        input :type => :submit, :value => "Add"
      end
    end

  end
end