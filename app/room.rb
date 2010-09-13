module Chat
  class Room < Hammer::Component::Base

    needs :room, :user
    attr_reader :room, :user, :message_form, :messages
    changing { attr_writer :message_form }

    after_initialize do
      ask_message
      @messages = []
      room.messages.each {|m| add_message(m) }
      room.add_observer(:new, self, :add_message)
      room.add_observer(:deleted, self, :remove_message)
    end

    def leave!
      room.delete_observer :new, self
      room.delete_observer :deleted, self
    end

    changing do
      def add_message(message)
        @messages.unshift Message.new :message => message
      end

      def remove_message(message)
        @messages.delete @messages.reverse.find {|m| m.message == message }
      end
    end

    private

    def ask_message
      self.message_form = ask Chat::MessageForm.new(:record => Chat::Model::Message.new(user)) do |message|
        room.add_message message
        ask_message
      end
    end

    class Widget < widget_class :Widget
      include Gravatarify::Helper

      def content
        h2 room.name
        component.room.get_observers(:new).each do |room|
          img :src => gravatar_url(room.user.email, :size => 38, :default => :wavatar), :alt => 'avatar'
        end
        render message_form
        messages.each {|m| render m }
      end
    end
  end
end