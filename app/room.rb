module Chat
  class Room < Hammer::Component::Base

    needs :room
    attr_reader :room, :message_form, :messages
    changing { attr_writer :message_form }

    shared :user, :user=

    after_initialize do
      @messages = []
      room.messages(:order => :time.asc, :limit => 30).each {|m| add_message(m) }
      room.class.add_observer(:created, self, :on_message_created)
      shared.add_observer(:user_changed, self, :user_change)
      user_change
    end

    def leave!
      room.delete_observer :message_created, self
    end

    def on_message_created(room_id, message_id)
      return unless room_id == room.id
      add_message Chat::Model::Message.get(message_id)
    end

    changing do
      def add_message(message)
        @messages.unshift Message.new :message => message
      end
    end

    def user_change
      if user
        ask_for_message
      else
        self.message_form = nil
      end
    end

    private

    def ask_for_message
      self.message_form = ask Chat::MessageForm.new(:record => Chat::Model::Message.new(:room => room)) do |message|
        pp message
        message.save
        ask_for_message
      end
    end

    class Widget < widget_class :Widget
      include Gravatarify::Helper

      css do
        img { margin_right '10px' }
      end

      def wrapper_classes
        super.push(*%w[grid_13 alpha omega])
      end

      def content
        h1 room.name

        render message_form # TODO check unnecessary ifs
        messages.each {|m| render m }
      end
    end
  end
end