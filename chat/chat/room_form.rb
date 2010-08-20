module Chat
  class RoomForm < Hammer::Component::Base

    include Hammer::Component::Form
    alias_method(:room, :record)

    define_widget do
      wrap_in(:div)

      def wrapper_classes
        super << 'form'
      end

      def content
        input :name => :name, :value => value(:name), :type => :text

        submit("Add").update { answer!(room) if room.valid? }
        link_to("Cancel").action { answer!(nil) }
      end
    end

  end
end